import { CONFIG, api } from './config.js';

const saveOptions = async () => {
    const width = document.getElementById('width').value;
    const height = document.getElementById('height').value;

    await api.storage.sync.set({
        width: width,
        height: height
    });

    window.close();
};

const restoreOptions = async () => {
    const items = await api.storage.sync.get({
        width: CONFIG.DEFAULT_WIDTH,
        height: CONFIG.DEFAULT_HEIGHT
    });

    document.getElementById('width').value = items.width;
    document.getElementById('height').value = items.height;
};

const setDefault = () => {
    document.getElementById('width').value = CONFIG.DEFAULT_WIDTH;
    document.getElementById('height').value = CONFIG.DEFAULT_HEIGHT;
}

document.addEventListener('DOMContentLoaded', restoreOptions);
document.getElementById('save').addEventListener('click', saveOptions);
document.getElementById('default').addEventListener('click', setDefault);
