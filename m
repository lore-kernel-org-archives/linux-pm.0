From: Junjie Mao <junjie.mao@enight.me>
Subject: Need a pairing decrement if pm_runtime_get_sync() fails?
Date: Fri, 17 Jul 2015 19:56:28 +0800
Message-ID: <86io9jvvyr.fsf@enight.me>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi all,

While analyzing the source, I notice that many drivers use
pm_runtime_get_sync() in the following pattern:

    err = pm_runtime_get_sync(...)
    if (err < 0) {
        dev_err(...);
        return err;
    }

Can this lead to the imbalance of runtime PM usage counter, as the
counter is always incremented in __pm_runtime_resume() regardless of the
return value? Is a pairing decrement (e.g. pm_runtime_put_sync() or
pm_runtime_put_noidle()) a must on the error-handling path? If so, which
is a better fix, adding a pairing decrement to each call site, or
decrementing the usage counter in __pm_runtime_resume() if rpm_resume()
fails?

A quick grep in the source shows that there are 150 calls to
pm_runtime_get() or pm_runtime_get_sync() (I only search for call
sites where the return values are checked), and 102 of them lack the
pairing decrement on the error-handling path. A list of these 102 call
sites, along with their contexts, are attached below for reference.

Best Regards
Junjie Mao

--------------------------------------------------------------------------------

arch/arm/common/edma.c:	ret = pm_runtime_get_sync(dev);
arch/arm/common/edma.c-	if (ret < 0) {
arch/arm/common/edma.c-		dev_err(dev, "pm_runtime_get_sync() failed\n");
arch/arm/common/edma.c-		return ret;
arch/arm/common/edma.c-	}
--
drivers/hsi/controllers/omap_ssi.c:	err = pm_runtime_get_sync(ssi->device.parent);
drivers/hsi/controllers/omap_ssi.c-	if (err < 0) {
drivers/hsi/controllers/omap_ssi.c-		dev_err(&ssi->device, "runtime PM failed %d\n", err);
drivers/hsi/controllers/omap_ssi.c-		return err;
drivers/hsi/controllers/omap_ssi.c-	}
--
drivers/usb/core/hub.c:		status = pm_runtime_get_sync(&port_dev->dev);
drivers/usb/core/hub.c-		if (status < 0) {
drivers/usb/core/hub.c-			dev_dbg(&udev->dev, "can't resume usb port, status %d\n",
drivers/usb/core/hub.c-					status);
drivers/usb/core/hub.c-			return status;
--
drivers/usb/musb/omap2430.c:	status = pm_runtime_get_sync(dev);
drivers/usb/musb/omap2430.c-	if (status < 0) {
drivers/usb/musb/omap2430.c-		dev_err(dev, "pm_runtime_get_sync FAILED %d\n", status);
drivers/usb/musb/omap2430.c-		goto err1;
drivers/usb/musb/omap2430.c-	}
--
drivers/usb/musb/musb_dsps.c:	ret = pm_runtime_get_sync(&pdev->dev);
drivers/usb/musb/musb_dsps.c-	if (ret < 0) {
drivers/usb/musb/musb_dsps.c-		dev_err(&pdev->dev, "pm_runtime_get_sync FAILED");
drivers/usb/musb/musb_dsps.c-		goto err2;
drivers/usb/musb/musb_dsps.c-	}
--
drivers/usb/dwc3/dwc3-omap.c:	ret = pm_runtime_get_sync(dev);
drivers/usb/dwc3/dwc3-omap.c-	if (ret < 0) {
drivers/usb/dwc3/dwc3-omap.c-		dev_err(dev, "get_sync failed with err %d\n", ret);
drivers/usb/dwc3/dwc3-omap.c-		goto err0;
drivers/usb/dwc3/dwc3-omap.c-	}
--
drivers/crypto/omap-sham.c:	err = pm_runtime_get_sync(dd->dev);
drivers/crypto/omap-sham.c-	if (err < 0) {
drivers/crypto/omap-sham.c-		dev_err(dd->dev, "failed to get sync: %d\n", err);
drivers/crypto/omap-sham.c-		return err;
drivers/crypto/omap-sham.c-	}
--
drivers/crypto/omap-sham.c:	err = pm_runtime_get_sync(dev);
drivers/crypto/omap-sham.c-	if (err < 0) {
drivers/crypto/omap-sham.c-		dev_err(dev, "failed to get sync: %d\n", err);
drivers/crypto/omap-sham.c-		goto err_pm;
drivers/crypto/omap-sham.c-	}
--
drivers/crypto/omap-sham.c:	int err = pm_runtime_get_sync(dev);
drivers/crypto/omap-sham.c-	if (err < 0) {
drivers/crypto/omap-sham.c-		dev_err(dev, "failed to get sync: %d\n", err);
drivers/crypto/omap-sham.c-		return err;
drivers/crypto/omap-sham.c-	}
--
drivers/crypto/omap-aes.c:	err = pm_runtime_get_sync(dd->dev);
drivers/crypto/omap-aes.c-	if (err < 0) {
drivers/crypto/omap-aes.c-		dev_err(dd->dev, "%s: failed to get_sync(%d)\n",
drivers/crypto/omap-aes.c-			__func__, err);
drivers/crypto/omap-aes.c-		return err;
--
drivers/crypto/omap-aes.c:	err = pm_runtime_get_sync(dev);
drivers/crypto/omap-aes.c-	if (err < 0) {
drivers/crypto/omap-aes.c-		dev_err(dev, "%s: failed to get_sync(%d)\n",
drivers/crypto/omap-aes.c-			__func__, err);
drivers/crypto/omap-aes.c-		goto err_res;
--
drivers/gpu/vga/vga_switcheroo.c:			ret = pm_runtime_get_sync(&client->pdev->dev);
drivers/gpu/vga/vga_switcheroo.c-			if (ret) {
drivers/gpu/vga/vga_switcheroo.c-				if (ret != 1)
drivers/gpu/vga/vga_switcheroo.c-					return ret;
drivers/gpu/vga/vga_switcheroo.c-			}
--
drivers/gpu/drm/nouveau/nouveau_drm.c:	ret = pm_runtime_get_sync(dev->dev);
drivers/gpu/drm/nouveau/nouveau_drm.c-	if (ret < 0 && ret != -EACCES)
drivers/gpu/drm/nouveau/nouveau_drm.c-		return ret;
drivers/gpu/drm/nouveau/nouveau_drm.c-
drivers/gpu/drm/nouveau/nouveau_drm.c-	get_task_comm(tmpname, current);
--
drivers/gpu/drm/nouveau/nouveau_drm.c:	ret = pm_runtime_get_sync(dev->dev);
drivers/gpu/drm/nouveau/nouveau_drm.c-	if (ret < 0 && ret != -EACCES)
drivers/gpu/drm/nouveau/nouveau_drm.c-		return ret;
drivers/gpu/drm/nouveau/nouveau_drm.c-
drivers/gpu/drm/nouveau/nouveau_drm.c-	switch (_IOC_NR(cmd) - DRM_COMMAND_BASE) {
--
drivers/gpu/drm/nouveau/nouveau_gem.c:	ret = pm_runtime_get_sync(dev);
drivers/gpu/drm/nouveau/nouveau_gem.c-	if (WARN_ON(ret < 0 && ret != -EACCES))
drivers/gpu/drm/nouveau/nouveau_gem.c-		return;
drivers/gpu/drm/nouveau/nouveau_gem.c-
drivers/gpu/drm/nouveau/nouveau_gem.c-	if (gem->import_attach)
--
drivers/gpu/drm/nouveau/nouveau_gem.c:		ret = pm_runtime_get_sync(dev);
drivers/gpu/drm/nouveau/nouveau_gem.c-		if (ret < 0 && ret != -EACCES)
drivers/gpu/drm/nouveau/nouveau_gem.c-			goto out;
drivers/gpu/drm/nouveau/nouveau_gem.c-
drivers/gpu/drm/nouveau/nouveau_gem.c-		ret = nouveau_bo_vma_add(nvbo, cli->vm, vma);
--
drivers/gpu/drm/nouveau/dispnv04/crtc.c:	ret = pm_runtime_get_sync(dev->dev);
drivers/gpu/drm/nouveau/dispnv04/crtc.c-	if (ret < 0 && ret != -EACCES)
drivers/gpu/drm/nouveau/dispnv04/crtc.c-		return ret;
drivers/gpu/drm/nouveau/dispnv04/crtc.c-
drivers/gpu/drm/nouveau/dispnv04/crtc.c-	ret = drm_crtc_helper_set_config(set);
--
drivers/gpu/drm/nouveau/nouveau_connector.c:	ret = pm_runtime_get_sync(connector->dev->dev);
drivers/gpu/drm/nouveau/nouveau_connector.c-	if (ret < 0 && ret != -EACCES)
drivers/gpu/drm/nouveau/nouveau_connector.c-		return conn_status;
drivers/gpu/drm/nouveau/nouveau_connector.c-
drivers/gpu/drm/nouveau/nouveau_connector.c-	nv_encoder = nouveau_connector_ddc_detect(connector);
--
drivers/gpu/drm/rockchip/rockchip_drm_vop.c:	ret = pm_runtime_get_sync(vop->dev);
drivers/gpu/drm/rockchip/rockchip_drm_vop.c-	if (ret < 0) {
drivers/gpu/drm/rockchip/rockchip_drm_vop.c-		dev_err(vop->dev, "failed to get pm runtime: %d\n", ret);
drivers/gpu/drm/rockchip/rockchip_drm_vop.c-		return;
drivers/gpu/drm/rockchip/rockchip_drm_vop.c-	}
--
drivers/gpu/drm/radeon/radeon_drv.c:	ret = pm_runtime_get_sync(dev->dev);
drivers/gpu/drm/radeon/radeon_drv.c-	if (ret < 0)
drivers/gpu/drm/radeon/radeon_drv.c-		return ret;
drivers/gpu/drm/radeon/radeon_drv.c-
drivers/gpu/drm/radeon/radeon_drv.c-	ret = drm_ioctl(filp, cmd, arg);
--
drivers/gpu/drm/radeon/radeon_connectors.c:	r = pm_runtime_get_sync(connector->dev->dev);
drivers/gpu/drm/radeon/radeon_connectors.c-	if (r < 0)
drivers/gpu/drm/radeon/radeon_connectors.c-		return connector_status_disconnected;
drivers/gpu/drm/radeon/radeon_connectors.c-
drivers/gpu/drm/radeon/radeon_connectors.c-	if (encoder) {
--
drivers/gpu/drm/radeon/radeon_connectors.c:	r = pm_runtime_get_sync(connector->dev->dev);
drivers/gpu/drm/radeon/radeon_connectors.c-	if (r < 0)
drivers/gpu/drm/radeon/radeon_connectors.c-		return connector_status_disconnected;
drivers/gpu/drm/radeon/radeon_connectors.c-
drivers/gpu/drm/radeon/radeon_connectors.c-	encoder = radeon_best_single_encoder(connector);
--
drivers/gpu/drm/radeon/radeon_connectors.c:	r = pm_runtime_get_sync(connector->dev->dev);
drivers/gpu/drm/radeon/radeon_connectors.c-	if (r < 0)
drivers/gpu/drm/radeon/radeon_connectors.c-		return connector_status_disconnected;
drivers/gpu/drm/radeon/radeon_connectors.c-
drivers/gpu/drm/radeon/radeon_connectors.c-	encoder = radeon_best_single_encoder(connector);
--
drivers/gpu/drm/radeon/radeon_connectors.c:	r = pm_runtime_get_sync(connector->dev->dev);
drivers/gpu/drm/radeon/radeon_connectors.c-	if (r < 0)
drivers/gpu/drm/radeon/radeon_connectors.c-		return connector_status_disconnected;
drivers/gpu/drm/radeon/radeon_connectors.c-
drivers/gpu/drm/radeon/radeon_connectors.c-	if (!force && radeon_check_hpd_status_unchanged(connector)) {
--
drivers/gpu/drm/radeon/radeon_connectors.c:	r = pm_runtime_get_sync(connector->dev->dev);
drivers/gpu/drm/radeon/radeon_connectors.c-	if (r < 0)
drivers/gpu/drm/radeon/radeon_connectors.c-		return connector_status_disconnected;
drivers/gpu/drm/radeon/radeon_connectors.c-
drivers/gpu/drm/radeon/radeon_connectors.c-	if (!force && radeon_check_hpd_status_unchanged(connector)) {
--
drivers/gpu/drm/radeon/radeon_kms.c:	r = pm_runtime_get_sync(dev->dev);
drivers/gpu/drm/radeon/radeon_kms.c-	if (r < 0)
drivers/gpu/drm/radeon/radeon_kms.c-		return r;
drivers/gpu/drm/radeon/radeon_kms.c-
drivers/gpu/drm/radeon/radeon_kms.c-	/* new gpu have virtual address space support */
--
drivers/gpu/drm/radeon/radeon_display.c:	ret = pm_runtime_get_sync(dev->dev);
drivers/gpu/drm/radeon/radeon_display.c-	if (ret < 0)
drivers/gpu/drm/radeon/radeon_display.c-		return ret;
drivers/gpu/drm/radeon/radeon_display.c-
drivers/gpu/drm/radeon/radeon_display.c-	ret = drm_crtc_helper_set_config(set);
--
drivers/gpu/drm/amd/amdgpu/amdgpu_display.c:	ret = pm_runtime_get_sync(dev->dev);
drivers/gpu/drm/amd/amdgpu/amdgpu_display.c-	if (ret < 0)
drivers/gpu/drm/amd/amdgpu/amdgpu_display.c-		return ret;
drivers/gpu/drm/amd/amdgpu/amdgpu_display.c-
drivers/gpu/drm/amd/amdgpu/amdgpu_display.c-	ret = drm_crtc_helper_set_config(set);
--
drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:	ret = pm_runtime_get_sync(dev->dev);
drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c-	if (ret < 0)
drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c-		return ret;
drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c-
drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c-	ret = drm_ioctl(filp, cmd, arg);
--
drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c:	r = pm_runtime_get_sync(connector->dev->dev);
drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c-	if (r < 0)
drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c-		return connector_status_disconnected;
drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c-
drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c-	if (encoder) {
--
drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c:	r = pm_runtime_get_sync(connector->dev->dev);
drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c-	if (r < 0)
drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c-		return connector_status_disconnected;
drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c-
drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c-	encoder = amdgpu_connector_best_single_encoder(connector);
--
drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c:	r = pm_runtime_get_sync(connector->dev->dev);
drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c-	if (r < 0)
drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c-		return connector_status_disconnected;
drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c-
drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c-	if (!force && amdgpu_connector_check_hpd_status_unchanged(connector)) {
--
drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c:	r = pm_runtime_get_sync(connector->dev->dev);
drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c-	if (r < 0)
drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c-		return connector_status_disconnected;
drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c-
drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c-	if (!force && amdgpu_connector_check_hpd_status_unchanged(connector)) {
--
drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c:	r = pm_runtime_get_sync(dev->dev);
drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c-	if (r < 0)
drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c-		return r;
drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c-
drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c-	fpriv = kzalloc(sizeof(*fpriv), GFP_KERNEL);
--
drivers/gpu/drm/exynos/exynos_drm_g2d.c:	ret = pm_runtime_get_sync(g2d->dev);
drivers/gpu/drm/exynos/exynos_drm_g2d.c-	if (ret < 0)
drivers/gpu/drm/exynos/exynos_drm_g2d.c-		return;
drivers/gpu/drm/exynos/exynos_drm_g2d.c-
drivers/gpu/drm/exynos/exynos_drm_g2d.c-	writel_relaxed(node->dma_addr, g2d->regs + G2D_DMA_SFR_BASE_ADDR);
--
drivers/i2c/busses/i2c-omap.c:	r = pm_runtime_get_sync(dev->dev);
drivers/i2c/busses/i2c-omap.c-	if (r < 0)
drivers/i2c/busses/i2c-omap.c-		goto err_free_mem;
drivers/i2c/busses/i2c-omap.c-
drivers/i2c/busses/i2c-omap.c-	/*
--
drivers/i2c/busses/i2c-omap.c:	ret = pm_runtime_get_sync(&pdev->dev);
drivers/i2c/busses/i2c-omap.c-	if (ret < 0)
drivers/i2c/busses/i2c-omap.c-		return ret;
drivers/i2c/busses/i2c-omap.c-
drivers/i2c/busses/i2c-omap.c-	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
--
drivers/media/i2c/s5k6a3.c:	ret = pm_runtime_get(sensor->dev);
drivers/media/i2c/s5k6a3.c-	if (ret < 0)
drivers/media/i2c/s5k6a3.c-		return ret;
drivers/media/i2c/s5k6a3.c-
drivers/media/i2c/s5k6a3.c-	ret = regulator_enable(sensor->supplies[i].consumer);
--
drivers/media/platform/s5p-tv/sii9234_drv.c:		ret = pm_runtime_get_sync(&ctx->client->dev);
drivers/media/platform/s5p-tv/sii9234_drv.c-	else
drivers/media/platform/s5p-tv/sii9234_drv.c-		ret = pm_runtime_put(&ctx->client->dev);
drivers/media/platform/s5p-tv/sii9234_drv.c-	/* only values < 0 indicate errors */
drivers/media/platform/s5p-tv/sii9234_drv.c-	return ret < 0 ? ret : 0;
--
drivers/media/platform/s5p-tv/sii9234_drv.c:	ret = pm_runtime_get_sync(dev);
drivers/media/platform/s5p-tv/sii9234_drv.c-	if (ret)
drivers/media/platform/s5p-tv/sii9234_drv.c-		goto fail_pm;
drivers/media/platform/s5p-tv/sii9234_drv.c-
drivers/media/platform/s5p-tv/sii9234_drv.c-	/* verify chip version */
--
drivers/media/platform/s5p-tv/hdmi_drv.c:		ret = pm_runtime_get_sync(hdev->dev);
drivers/media/platform/s5p-tv/hdmi_drv.c-	else
drivers/media/platform/s5p-tv/hdmi_drv.c-		ret = pm_runtime_put_sync(hdev->dev);
drivers/media/platform/s5p-tv/hdmi_drv.c-	/* only values < 0 indicate errors */
drivers/media/platform/s5p-tv/hdmi_drv.c-	return ret < 0 ? ret : 0;
--
drivers/media/platform/s5p-tv/mixer_drv.c:	int ret = pm_runtime_get_sync(mdev->dev);
drivers/media/platform/s5p-tv/mixer_drv.c-
drivers/media/platform/s5p-tv/mixer_drv.c-	/* returning 1 means that power is already enabled,
drivers/media/platform/s5p-tv/mixer_drv.c-	 * so zero success be returned */
drivers/media/platform/s5p-tv/mixer_drv.c-	if (IS_ERR_VALUE(ret))
--
drivers/media/platform/s5p-tv/sdo_drv.c:		ret = pm_runtime_get_sync(dev);
drivers/media/platform/s5p-tv/sdo_drv.c-	else
drivers/media/platform/s5p-tv/sdo_drv.c-		ret = pm_runtime_put_sync(dev);
drivers/media/platform/s5p-tv/sdo_drv.c-
drivers/media/platform/s5p-tv/sdo_drv.c-	/* only values < 0 indicate errors */
--
drivers/media/platform/sti/bdisp/bdisp-debug.c:	ret = pm_runtime_get_sync(bdisp->dev);
drivers/media/platform/sti/bdisp/bdisp-debug.c-	if (ret < 0) {
drivers/media/platform/sti/bdisp/bdisp-debug.c-		seq_puts(s, "Cannot wake up IP\n");
drivers/media/platform/sti/bdisp/bdisp-debug.c-		return 0;
drivers/media/platform/sti/bdisp/bdisp-debug.c-	}
--
drivers/media/platform/sti/bdisp/bdisp-v4l2.c:	int ret = pm_runtime_get_sync(ctx->bdisp_dev->dev);
drivers/media/platform/sti/bdisp/bdisp-v4l2.c-
drivers/media/platform/sti/bdisp/bdisp-v4l2.c-	if (ret < 0) {
drivers/media/platform/sti/bdisp/bdisp-v4l2.c-		dev_err(ctx->bdisp_dev->dev, "failed to set runtime PM\n");
drivers/media/platform/sti/bdisp/bdisp-v4l2.c-
--
drivers/media/platform/sti/bdisp/bdisp-v4l2.c:	ret = pm_runtime_get_sync(dev);
drivers/media/platform/sti/bdisp/bdisp-v4l2.c-	if (ret < 0) {
drivers/media/platform/sti/bdisp/bdisp-v4l2.c-		dev_err(dev, "failed to set PM\n");
drivers/media/platform/sti/bdisp/bdisp-v4l2.c-		goto err_dbg;
drivers/media/platform/sti/bdisp/bdisp-v4l2.c-	}
--
drivers/media/platform/s3c-camif/camif-capture.c:	ret = pm_runtime_get_sync(camif->dev);
drivers/media/platform/s3c-camif/camif-capture.c-	if (ret < 0)
drivers/media/platform/s3c-camif/camif-capture.c-		goto err_pm;
drivers/media/platform/s3c-camif/camif-capture.c-
drivers/media/platform/s3c-camif/camif-capture.c-	ret = sensor_set_power(camif, 1);
--
drivers/media/platform/s3c-camif/camif-core.c:	ret = pm_runtime_get_sync(dev);
drivers/media/platform/s3c-camif/camif-core.c-	if (ret < 0)
drivers/media/platform/s3c-camif/camif-core.c-		goto err_pm;
drivers/media/platform/s3c-camif/camif-core.c-
drivers/media/platform/s3c-camif/camif-core.c-	/* Initialize contiguous memory allocator */
--
drivers/media/platform/s5p-jpeg/jpeg-core.c:	ret = pm_runtime_get_sync(ctx->jpeg->dev);
drivers/media/platform/s5p-jpeg/jpeg-core.c-
drivers/media/platform/s5p-jpeg/jpeg-core.c-	return ret > 0 ? 0 : ret;
drivers/media/platform/s5p-jpeg/jpeg-core.c-}
drivers/media/platform/s5p-jpeg/jpeg-core.c-
--
drivers/media/platform/exynos-gsc/gsc-core.c:	ret = pm_runtime_get_sync(&pdev->dev);
drivers/media/platform/exynos-gsc/gsc-core.c-	if (ret < 0)
drivers/media/platform/exynos-gsc/gsc-core.c-		goto err_m2m;
drivers/media/platform/exynos-gsc/gsc-core.c-
drivers/media/platform/exynos-gsc/gsc-core.c-	/* Initialize continious memory allocator */
--
drivers/media/platform/exynos-gsc/gsc-m2m.c:	ret = pm_runtime_get_sync(&ctx->gsc_dev->pdev->dev);
drivers/media/platform/exynos-gsc/gsc-m2m.c-	return ret > 0 ? 0 : ret;
drivers/media/platform/exynos-gsc/gsc-m2m.c-}
drivers/media/platform/exynos-gsc/gsc-m2m.c-
drivers/media/platform/exynos-gsc/gsc-m2m.c-static void gsc_m2m_stop_streaming(struct vb2_queue *q)
--
drivers/media/platform/exynos4-is/fimc-lite.c:	ret = pm_runtime_get_sync(&fimc->pdev->dev);
drivers/media/platform/exynos4-is/fimc-lite.c-	if (ret < 0)
drivers/media/platform/exynos4-is/fimc-lite.c-		goto unlock;
drivers/media/platform/exynos4-is/fimc-lite.c-
drivers/media/platform/exynos4-is/fimc-lite.c-	ret = v4l2_fh_open(file);
--
drivers/media/platform/exynos4-is/fimc-isp-video.c:	ret = pm_runtime_get_sync(&isp->pdev->dev);
drivers/media/platform/exynos4-is/fimc-isp-video.c-	if (ret < 0)
drivers/media/platform/exynos4-is/fimc-isp-video.c-		goto rel_fh;
drivers/media/platform/exynos4-is/fimc-isp-video.c-
drivers/media/platform/exynos4-is/fimc-isp-video.c-	if (v4l2_fh_is_singular_file(file)) {
--
drivers/media/platform/exynos4-is/media-dev.c:	ret = pm_runtime_get_sync(fmd->pmf);
drivers/media/platform/exynos4-is/media-dev.c-	if (ret < 0)
drivers/media/platform/exynos4-is/media-dev.c-		return ret;
drivers/media/platform/exynos4-is/media-dev.c-
drivers/media/platform/exynos4-is/media-dev.c-	fmd->num_sensors = 0;
--
drivers/media/platform/exynos4-is/media-dev.c:	ret = pm_runtime_get_sync(camclk->fmd->pmf);
drivers/media/platform/exynos4-is/media-dev.c-	return ret < 0 ? ret : 0;
drivers/media/platform/exynos4-is/media-dev.c-}
drivers/media/platform/exynos4-is/media-dev.c-
drivers/media/platform/exynos4-is/media-dev.c-static void cam_clk_unprepare(struct clk_hw *hw)
--
drivers/media/platform/exynos4-is/fimc-capture.c:	ret = pm_runtime_get_sync(&fimc->pdev->dev);
drivers/media/platform/exynos4-is/fimc-capture.c-	if (ret < 0)
drivers/media/platform/exynos4-is/fimc-capture.c-		goto unlock;
drivers/media/platform/exynos4-is/fimc-capture.c-
drivers/media/platform/exynos4-is/fimc-capture.c-	ret = v4l2_fh_open(file);
--
drivers/media/platform/exynos4-is/fimc-is.c:	ret = pm_runtime_get_sync(dev);
drivers/media/platform/exynos4-is/fimc-is.c-	if (ret < 0)
drivers/media/platform/exynos4-is/fimc-is.c-		goto err_pm;
drivers/media/platform/exynos4-is/fimc-is.c-
drivers/media/platform/exynos4-is/fimc-is.c-	is->alloc_ctx = vb2_dma_contig_init_ctx(dev);
--
drivers/media/platform/exynos4-is/fimc-m2m.c:	ret = pm_runtime_get_sync(&ctx->fimc_dev->pdev->dev);
drivers/media/platform/exynos4-is/fimc-m2m.c-	return ret > 0 ? 0 : ret;
drivers/media/platform/exynos4-is/fimc-m2m.c-}
drivers/media/platform/exynos4-is/fimc-m2m.c-
drivers/media/platform/exynos4-is/fimc-m2m.c-static void stop_streaming(struct vb2_queue *q)
--
drivers/media/platform/exynos4-is/mipi-csis.c:		ret = pm_runtime_get_sync(&state->pdev->dev);
drivers/media/platform/exynos4-is/mipi-csis.c-		if (ret && ret != 1)
drivers/media/platform/exynos4-is/mipi-csis.c-			return ret;
drivers/media/platform/exynos4-is/mipi-csis.c-	}
drivers/media/platform/exynos4-is/mipi-csis.c-
--
drivers/media/platform/exynos4-is/fimc-isp.c:		ret = pm_runtime_get_sync(&is->pdev->dev);
drivers/media/platform/exynos4-is/fimc-isp.c-		if (ret < 0)
drivers/media/platform/exynos4-is/fimc-isp.c-			return ret;
drivers/media/platform/exynos4-is/fimc-isp.c-		set_bit(IS_ST_PWR_ON, &is->state);
drivers/media/platform/exynos4-is/fimc-isp.c-
--
drivers/media/platform/coda/coda-common.c:	ret = pm_runtime_get_sync(&dev->plat_dev->dev);
drivers/media/platform/coda/coda-common.c-	if (ret < 0) {
drivers/media/platform/coda/coda-common.c-		v4l2_err(&dev->v4l2_dev, "failed to power up: %d\n", ret);
drivers/media/platform/coda/coda-common.c-		goto err_pm_get;
drivers/media/platform/coda/coda-common.c-	}
--
drivers/mfd/arizona-irq.c:	ret = pm_runtime_get_sync(arizona->dev);
drivers/mfd/arizona-irq.c-	if (ret < 0) {
drivers/mfd/arizona-irq.c-		dev_err(arizona->dev, "Failed to resume device: %d\n", ret);
drivers/mfd/arizona-irq.c-		return IRQ_NONE;
drivers/mfd/arizona-irq.c-	}
--
drivers/video/fbdev/omap2/dss/hdmi5.c:	r = pm_runtime_get_sync(&hdmi.pdev->dev);
drivers/video/fbdev/omap2/dss/hdmi5.c-	WARN_ON(r < 0);
drivers/video/fbdev/omap2/dss/hdmi5.c-	if (r < 0)
drivers/video/fbdev/omap2/dss/hdmi5.c-		return r;
drivers/video/fbdev/omap2/dss/hdmi5.c-
--
drivers/video/fbdev/omap2/dss/dispc.c:	r = pm_runtime_get_sync(&dispc.pdev->dev);
drivers/video/fbdev/omap2/dss/dispc.c-	WARN_ON(r < 0);
drivers/video/fbdev/omap2/dss/dispc.c-	return r < 0 ? r : 0;
drivers/video/fbdev/omap2/dss/dispc.c-}
drivers/video/fbdev/omap2/dss/dispc.c-EXPORT_SYMBOL(dispc_runtime_get);
--
drivers/video/fbdev/omap2/dss/hdmi4.c:	r = pm_runtime_get_sync(&hdmi.pdev->dev);
drivers/video/fbdev/omap2/dss/hdmi4.c-	WARN_ON(r < 0);
drivers/video/fbdev/omap2/dss/hdmi4.c-	if (r < 0)
drivers/video/fbdev/omap2/dss/hdmi4.c-		return r;
drivers/video/fbdev/omap2/dss/hdmi4.c-
--
drivers/video/fbdev/omap2/dss/dss.c:	r = pm_runtime_get_sync(&dss.pdev->dev);
drivers/video/fbdev/omap2/dss/dss.c-	WARN_ON(r < 0);
drivers/video/fbdev/omap2/dss/dss.c-	return r < 0 ? r : 0;
drivers/video/fbdev/omap2/dss/dss.c-}
drivers/video/fbdev/omap2/dss/dss.c-
--
drivers/video/fbdev/omap2/dss/venc.c:	r = pm_runtime_get_sync(&venc.pdev->dev);
drivers/video/fbdev/omap2/dss/venc.c-	WARN_ON(r < 0);
drivers/video/fbdev/omap2/dss/venc.c-	return r < 0 ? r : 0;
drivers/video/fbdev/omap2/dss/venc.c-}
drivers/video/fbdev/omap2/dss/venc.c-
--
drivers/video/fbdev/omap2/dss/rfbi.c:	r = pm_runtime_get_sync(&rfbi.pdev->dev);
drivers/video/fbdev/omap2/dss/rfbi.c-	WARN_ON(r < 0);
drivers/video/fbdev/omap2/dss/rfbi.c-	return r < 0 ? r : 0;
drivers/video/fbdev/omap2/dss/rfbi.c-}
drivers/video/fbdev/omap2/dss/rfbi.c-
--
drivers/video/fbdev/omap2/dss/dsi.c:	r = pm_runtime_get_sync(&dsi->pdev->dev);
drivers/video/fbdev/omap2/dss/dsi.c-	WARN_ON(r < 0);
drivers/video/fbdev/omap2/dss/dsi.c-	return r < 0 ? r : 0;
drivers/video/fbdev/omap2/dss/dsi.c-}
drivers/video/fbdev/omap2/dss/dsi.c-
--
drivers/input/misc/bma150.c:	error = pm_runtime_get_sync(&bma150->client->dev);
drivers/input/misc/bma150.c-	if (error < 0 && error != -ENOSYS)
drivers/input/misc/bma150.c-		return error;
drivers/input/misc/bma150.c-
drivers/input/misc/bma150.c-	/*
--
drivers/input/keyboard/omap4-keypad.c:	error = pm_runtime_get_sync(&pdev->dev);
drivers/input/keyboard/omap4-keypad.c-	if (error) {
drivers/input/keyboard/omap4-keypad.c-		dev_err(&pdev->dev, "pm_runtime_get_sync() failed\n");
drivers/input/keyboard/omap4-keypad.c-		goto err_unmap;
drivers/input/keyboard/omap4-keypad.c-	}
--
drivers/dma/cppi41.c:	ret = pm_runtime_get_sync(dev);
drivers/dma/cppi41.c-	if (ret < 0)
drivers/dma/cppi41.c-		goto err_get_sync;
drivers/dma/cppi41.c-
drivers/dma/cppi41.c-	cdd->queues_rx = glue_info->queues_rx;
--
drivers/dma/sh/rcar-dmac.c:	ret = pm_runtime_get_sync(&pdev->dev);
drivers/dma/sh/rcar-dmac.c-	if (ret < 0) {
drivers/dma/sh/rcar-dmac.c-		dev_err(&pdev->dev, "runtime PM get sync failed (%d)\n", ret);
drivers/dma/sh/rcar-dmac.c-		return ret;
drivers/dma/sh/rcar-dmac.c-	}
--
drivers/dma/sh/usb-dmac.c:	ret = pm_runtime_get_sync(&pdev->dev);
drivers/dma/sh/usb-dmac.c-	if (ret < 0) {
drivers/dma/sh/usb-dmac.c-		dev_err(&pdev->dev, "runtime PM get sync failed (%d)\n", ret);
drivers/dma/sh/usb-dmac.c-		return ret;
drivers/dma/sh/usb-dmac.c-	}
--
drivers/gpio/gpio-zynq.c:	ret = pm_runtime_get_sync(chip->dev);
drivers/gpio/gpio-zynq.c-
drivers/gpio/gpio-zynq.c-	/*
drivers/gpio/gpio-zynq.c-	 * If the device is already active pm_runtime_get() will return 1 on
drivers/gpio/gpio-zynq.c-	 * success, but gpio_request still needs to return 0.
--
drivers/hid/i2c-hid/i2c-hid.c:		ret = pm_runtime_get_sync(&client->dev);
drivers/hid/i2c-hid/i2c-hid.c-		if (ret < 0) {
drivers/hid/i2c-hid/i2c-hid.c-			hid->open--;
drivers/hid/i2c-hid/i2c-hid.c-			goto done;
drivers/hid/i2c-hid/i2c-hid.c-		}
--
drivers/pci/host/pci-dra7xx.c:	ret = pm_runtime_get_sync(dev);
drivers/pci/host/pci-dra7xx.c-	if (IS_ERR_VALUE(ret)) {
drivers/pci/host/pci-dra7xx.c-		dev_err(dev, "pm_runtime_get_sync failed\n");
drivers/pci/host/pci-dra7xx.c-		goto err_phy;
drivers/pci/host/pci-dra7xx.c-	}
--
drivers/soc/ti/knav_dma.c:	ret = pm_runtime_get_sync(kdev->dev);
drivers/soc/ti/knav_dma.c-	if (ret < 0) {
drivers/soc/ti/knav_dma.c-		dev_err(kdev->dev, "unable to enable pktdma, err %d\n", ret);
drivers/soc/ti/knav_dma.c-		return ret;
drivers/soc/ti/knav_dma.c-	}
--
drivers/soc/ti/knav_qmss_queue.c:	ret = pm_runtime_get_sync(&pdev->dev);
drivers/soc/ti/knav_qmss_queue.c-	if (ret < 0) {
drivers/soc/ti/knav_qmss_queue.c-		dev_err(dev, "Failed to enable QMSS\n");
drivers/soc/ti/knav_qmss_queue.c-		return ret;
drivers/soc/ti/knav_qmss_queue.c-	}
--
drivers/spi/spi-tegra114.c:	ret = pm_runtime_get_sync(tspi->dev);
drivers/spi/spi-tegra114.c-	if (ret < 0) {
drivers/spi/spi-tegra114.c-		dev_err(tspi->dev, "pm runtime failed, e = %d\n", ret);
drivers/spi/spi-tegra114.c-		return ret;
drivers/spi/spi-tegra114.c-	}
--
drivers/spi/spi-tegra114.c:	ret = pm_runtime_get_sync(dev);
drivers/spi/spi-tegra114.c-	if (ret < 0) {
drivers/spi/spi-tegra114.c-		dev_err(dev, "pm runtime failed, e = %d\n", ret);
drivers/spi/spi-tegra114.c-		return ret;
drivers/spi/spi-tegra114.c-	}
--
drivers/spi/spi-tegra20-slink.c:	ret = pm_runtime_get_sync(tspi->dev);
drivers/spi/spi-tegra20-slink.c-	if (ret < 0) {
drivers/spi/spi-tegra20-slink.c-		dev_err(tspi->dev, "pm runtime failed, e = %d\n", ret);
drivers/spi/spi-tegra20-slink.c-		return ret;
drivers/spi/spi-tegra20-slink.c-	}
--
drivers/spi/spi-tegra20-slink.c:	ret = pm_runtime_get_sync(dev);
drivers/spi/spi-tegra20-slink.c-	if (ret < 0) {
drivers/spi/spi-tegra20-slink.c-		dev_err(dev, "pm runtime failed, e = %d\n", ret);
drivers/spi/spi-tegra20-slink.c-		return ret;
drivers/spi/spi-tegra20-slink.c-	}
--
drivers/spi/spi-ti-qspi.c:	ret = pm_runtime_get_sync(qspi->dev);
drivers/spi/spi-ti-qspi.c-	if (ret < 0) {
drivers/spi/spi-ti-qspi.c-		dev_err(qspi->dev, "pm_runtime_get_sync() failed\n");
drivers/spi/spi-ti-qspi.c-		return ret;
drivers/spi/spi-ti-qspi.c-	}
--
drivers/spi/spi-ti-qspi.c:	ret = pm_runtime_get_sync(qspi->dev);
drivers/spi/spi-ti-qspi.c-	if (ret < 0) {
drivers/spi/spi-ti-qspi.c-		dev_err(qspi->dev, "pm_runtime_get_sync() failed\n");
drivers/spi/spi-ti-qspi.c-		return ret;
drivers/spi/spi-ti-qspi.c-	}
--
drivers/spi/spi-omap2-mcspi.c:	ret = pm_runtime_get_sync(mcspi->dev);
drivers/spi/spi-omap2-mcspi.c-	if (ret < 0)
drivers/spi/spi-omap2-mcspi.c-		return ret;
drivers/spi/spi-omap2-mcspi.c-
drivers/spi/spi-omap2-mcspi.c-	ret = omap2_mcspi_setup_transfer(spi, NULL);
--
drivers/spi/spi-omap2-mcspi.c:	ret = pm_runtime_get_sync(mcspi->dev);
drivers/spi/spi-omap2-mcspi.c-	if (ret < 0)
drivers/spi/spi-omap2-mcspi.c-		return ret;
drivers/spi/spi-omap2-mcspi.c-
drivers/spi/spi-omap2-mcspi.c-	mcspi_write_reg(master, OMAP2_MCSPI_WAKEUPENABLE,
--
drivers/spi/spi-tegra20-sflash.c:	ret = pm_runtime_get_sync(dev);
drivers/spi/spi-tegra20-sflash.c-	if (ret < 0) {
drivers/spi/spi-tegra20-sflash.c-		dev_err(dev, "pm runtime failed, e = %d\n", ret);
drivers/spi/spi-tegra20-sflash.c-		return ret;
drivers/spi/spi-tegra20-sflash.c-	}
--
drivers/spi/spi.c:		ret = pm_runtime_get_sync(master->dev.parent);
drivers/spi/spi.c-		if (ret < 0) {
drivers/spi/spi.c-			dev_err(&master->dev, "Failed to power device: %d\n",
drivers/spi/spi.c-				ret);
drivers/spi/spi.c-			return;
--
drivers/spi/spi-img-spfi.c:	ret = pm_runtime_get_sync(dev);
drivers/spi/spi-img-spfi.c-	if (ret)
drivers/spi/spi-img-spfi.c-		return ret;
drivers/spi/spi-img-spfi.c-	spfi_reset(spfi);
drivers/spi/spi-img-spfi.c-	pm_runtime_put(dev);
--
drivers/spi/spi-qup.c:	ret = pm_runtime_get_sync(&pdev->dev);
drivers/spi/spi-qup.c-	if (ret < 0)
drivers/spi/spi-qup.c-		return ret;
drivers/spi/spi-qup.c-
drivers/spi/spi-qup.c-	ret = spi_qup_set_state(controller, QUP_STATE_RESET);
--
drivers/net/ethernet/freescale/fec_main.c:	ret = pm_runtime_get_sync(dev);
drivers/net/ethernet/freescale/fec_main.c-	if (IS_ERR_VALUE(ret))
drivers/net/ethernet/freescale/fec_main.c-		return ret;
drivers/net/ethernet/freescale/fec_main.c-
drivers/net/ethernet/freescale/fec_main.c-	fep->mii_timeout = 0;
--
drivers/net/ethernet/freescale/fec_main.c:	ret = pm_runtime_get_sync(dev);
drivers/net/ethernet/freescale/fec_main.c-	if (IS_ERR_VALUE(ret))
drivers/net/ethernet/freescale/fec_main.c-		return ret;
drivers/net/ethernet/freescale/fec_main.c-
drivers/net/ethernet/freescale/fec_main.c-	fep->mii_timeout = 0;
--
drivers/net/ethernet/freescale/fec_main.c:	ret = pm_runtime_get_sync(&fep->pdev->dev);
drivers/net/ethernet/freescale/fec_main.c-	if (IS_ERR_VALUE(ret))
drivers/net/ethernet/freescale/fec_main.c-		return ret;
drivers/net/ethernet/freescale/fec_main.c-
drivers/net/ethernet/freescale/fec_main.c-	pinctrl_pm_select_default_state(&fep->pdev->dev);
--
sound/soc/tegra/tegra30_ahub.c:	ret = pm_runtime_get_sync(dev);
sound/soc/tegra/tegra30_ahub.c-	if (ret < 0)
sound/soc/tegra/tegra30_ahub.c-		return ret;
sound/soc/tegra/tegra30_ahub.c-	ret = regcache_sync(ahub->regmap_ahub);
sound/soc/tegra/tegra30_ahub.c-	ret |= regcache_sync(ahub->regmap_apbif);
--
sound/soc/tegra/tegra30_i2s.c:	ret = pm_runtime_get_sync(dev);
sound/soc/tegra/tegra30_i2s.c-	if (ret < 0)
sound/soc/tegra/tegra30_i2s.c-		return ret;
sound/soc/tegra/tegra30_i2s.c-	ret = regcache_sync(i2s->regmap);
sound/soc/tegra/tegra30_i2s.c-	pm_runtime_put(dev);
--
sound/soc/codecs/tas2552.c:	ret = pm_runtime_get_sync(codec->dev);
sound/soc/codecs/tas2552.c-	if (ret < 0) {
sound/soc/codecs/tas2552.c-		dev_err(codec->dev, "Enabling device failed: %d\n",
sound/soc/codecs/tas2552.c-			ret);
sound/soc/codecs/tas2552.c-		goto probe_fail;
--
sound/soc/codecs/wm8962.c:	ret = pm_runtime_get_sync(codec->dev);
sound/soc/codecs/wm8962.c-	if (ret < 0) {
sound/soc/codecs/wm8962.c-		dev_err(codec->dev, "Failed to resume device: %d\n", ret);
sound/soc/codecs/wm8962.c-		return ret;
sound/soc/codecs/wm8962.c-	}
--
sound/soc/codecs/wm8962.c:	ret = pm_runtime_get_sync(dev);
sound/soc/codecs/wm8962.c-	if (ret < 0) {
sound/soc/codecs/wm8962.c-		dev_err(dev, "Failed to resume: %d\n", ret);
sound/soc/codecs/wm8962.c-		return IRQ_NONE;
sound/soc/codecs/wm8962.c-	}
--
sound/soc/intel/atom/sst/sst_drv_interface.c:		ret = pm_runtime_get_sync(dev);
sound/soc/intel/atom/sst/sst_drv_interface.c-
sound/soc/intel/atom/sst/sst_drv_interface.c-		dev_dbg(ctx->dev, "Enable: pm usage count: %d\n", usage_count);
sound/soc/intel/atom/sst/sst_drv_interface.c-		if (ret < 0) {
sound/soc/intel/atom/sst/sst_drv_interface.c-			dev_err(ctx->dev, "Runtime get failed with err: %d\n", ret);
--
sound/soc/intel/atom/sst/sst_drv_interface.c:	retval = pm_runtime_get_sync(ctx->dev);
sound/soc/intel/atom/sst/sst_drv_interface.c-	if (retval < 0)
sound/soc/intel/atom/sst/sst_drv_interface.c-		return retval;
sound/soc/intel/atom/sst/sst_drv_interface.c-
sound/soc/intel/atom/sst/sst_drv_interface.c-	str_id = sst_get_stream(ctx, str_params);
--
sound/soc/intel/atom/sst/sst_drv_interface.c:	ret_val = pm_runtime_get_sync(ctx->dev);
sound/soc/intel/atom/sst/sst_drv_interface.c-	if (ret_val < 0)
sound/soc/intel/atom/sst/sst_drv_interface.c-		return ret_val;
sound/soc/intel/atom/sst/sst_drv_interface.c-
sound/soc/intel/atom/sst/sst_drv_interface.c-	ret_val = sst_send_byte_stream_mrfld(ctx, bytes);
