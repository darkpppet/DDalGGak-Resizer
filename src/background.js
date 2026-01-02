import { CONFIG, api } from './config.js';

api.action.onClicked.addListener(async (tab) => {
    const items = await api.storage.sync.get({
        width: CONFIG.DEFAULT_WIDTH,
        height: CONFIG.DEFAULT_HEIGHT
    });

    await api.windows.update(tab.windowId, {
        width: parseInt(items.width),
        height: parseInt(items.height),
        focused: true
    });
});