Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794844336;
	b=hAlX8ZexkL701fd0zbJOElrEDoV2bl/nkay/G2UxggQb6bhj6BXtmXOjxToZEPxgF1ij
	 B9RR3IGyKyME5cUM9Jsvtu/ZphenxSVjx9U1gskHqhIzEgi2bOGvVAe0+PzLt9vNjju9p
	 WyIohJFe45LEXfLZi+LMX07mSYd2N8lyxboRDLYnMZsQER5HcGYDGuG/rQ1Ip740pR8jh
	 VdUK7L041YnCgVZTcW22/0reLrJu3iCEJAizu3KNFGZpOH2YV1G7+FPpvMycUGO8VBlmZ
	 dL/7tYd8RaQWVeZbY2jWxjlMKoehZYOFoNLybgC8dVptdy0uyWrHG5dj7q/ED5NZtUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794844336;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=tc6KfHj5fySnLDo/yssasn7KXGGvXcSn8JCgqMRWVxQ=;
	b=M/iaVomGYpVSksW1KdJggGVP9jcu05FHF5h4deKEQ+fN0q3dOyqoGDCMYXE+3DuGU8MP
	 lX5p3SGlYyqLFpFDdEm2DyZ+Ahju/dZbI1EYYKvBG7aHgrAwPMn8sJfUuSaYAePo6pvQx
	 /uougziPd8hA2kWyih4ttV32snqF+KfM4jWYpXbLuTz/gcEgAkgfytiSfmnM6rHX4b81D
	 ZtrhgJifiTcNU0Eepe0AqIh2QHZ9FpX9ACxqv4ToED270PROhCVaaBiBW41pgad5iwwL8
	 vuydK0N+TXr4V4zuf5F6GWNeUQ7yvwvp1c9mRZxfG0GvsI3hla4prXIEazb2oGlFnew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=NusKEKiY;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D21F606A331;
	Mon, 16 Nov 2026 15:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D21F606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=NusKEKiY
Received: from killaraus.ideasonboard.com (2001-14ba-7086-3000--a06.rev.dnainternet.fi [IPv6:2001:14ba:7086:3000::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id ED0204BB;
	Mon, 16 Nov 2026 16:49:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1794844186;
	bh=dmodi+YIJbHNHccq3QM7tWgiNzPRHtMFkx//VJBaXh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NusKEKiY4bzAOfEoYrIhBXyGlIkZI3PnloPf2BxBVRwuEIJvmtu+vw7O/jc41VQuU
	 J3Ty1U67T4ibE4hILXY3O/CpMrCBJQpictxpRHUyim+WJ3gBdqwhQf8GriCHlXRv3w
	 cuUezGZlAQGClI/3BR6NS7TrNFoxwJ2vIQYfr6tw=
Date: Mon, 16 Nov 2026 17:52:11 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Frank Li <Frank.Li@nxp.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
	Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	Alessio Belle <alessio.belle@imgtec.com>,
	Luigi Santivetti <luigi.santivetti@imgtec.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>, Yong Wu <yong.wu@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Dafna Hirschfeld <dafna@fastmail.com>,
	Michael Tretter <m.tretter@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Will Deacon <will@kernel.org>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	dri-devel@lists.freedesktop.org, imagination@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-sound@vger.kernel.org,
	sound-open-firmware@alsa-project.org, imx@lists.linux.dev
Subject: Re: [PATCH v2 2/2] PM: runtime: fix stub pm_runtime_get_if_in_use()
 for !CONFIG_PM
Message-ID: <20261116155211.GB1763340@killaraus.ideasonboard.com>
References: <20261116152513.2676573-1-Frank.Li@oss.nxp.com>
 <20261116152513.2676573-2-Frank.Li@oss.nxp.com>
 <20261116153139.GB1763944@killaraus.ideasonboard.com>
 <avskkbztzVF_SRo6@SMW015318>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <avskkbztzVF_SRo6@SMW015318>

On Mon, Nov 16, 2026 at 09:43:13AM -0600, Frank Li wrote:
> On Mon, Nov 16, 2026 at 05:31:39PM +0200, Laurent Pinchart wrote:
> > On Mon, Nov 16, 2026 at 10:25:11AM -0500, Frank.Li@oss.nxp.com wrote:
> > > From: Frank Li <Frank.Li@nxp.com>
> > >
> > > The stub for pm_runtime_get_if_in_use() under !CONFIG_PM currently
> > > returns -EINVAL.  The real implementation returns:
> > >   1  - device is active and its usage counter is non-zero (bumped)
> > >   0  - device is not in use or not active (counter not bumped)
> > >  -EINVAL - runtime PM disabled for this device
> > >
> > > When CONFIG_PM is not set every device is permanently "active" and
> > > always considered "in use", so the stub must return 1, mirroring
> > > __pm_runtime_resume() which already returns 1 in the same build.
> > >
> > > Returning -EINVAL breaks callers that test the return value with
> > > comparisons other than "!= 0 / == 0":
> > >
> > > drivers/gpu/drm/i915/intel_runtime_pm.c:
> > >   if (intel_runtime_pm_get_if_in_use(rpm))
> > >   which wraps to: ret = pm_runtime_get_if_in_use(); return ret > 0;
> > >   With -EINVAL the wrapper returns false, causing an incorrect error
> > >   path in the GT fence revocation code.
> > >
> > > drivers/gpu/drm/xe/xe_pm.c:
> > >   if (pm_runtime_get_if_in_use(xe->drm.dev) > 0)
> > >   With -EINVAL the condition is false; xe_pm_runtime_get_if_in_use()
> > >   returns false, so callers believe the device is not usable.
> > >
> > > drivers/gpu/drm/gma500/power.c:
> > >   return pm_runtime_get_if_in_use(dev) == 1;
> > >   -EINVAL != 1, so the helper always returns false when !CONFIG_PM.
> > >
> > > drivers/gpu/drm/imagination/pvr_power.c:
> > >   if (pm_runtime_get_if_in_use(...) <= 0)
> > >   -EINVAL <= 0 is true, so the driver always takes the "requeue" error
> > >   path instead of proceeding with the active device.
> > >
> > > sound/soc/sof/debug.c:
> > >   if (pm_runtime_get_if_in_use(sdev->dev) == 1)
> > >   -EINVAL != 1, so d3_prevented is never set, corrupting exception
> > >   debug accounting.
> > >
> > > drivers/iommu/mtk_iommu.c:
> > >   if (pm_runtime_get_if_in_use(dom->plat_dev->dev) <= 0)
> > >   -EINVAL <= 0 skips the TLB flush, leaving stale IOMMU mappings.
> > >
> > > drivers/iommu/rockchip-iommu.c:
> > >   Three call sites use WARN_ON_ONCE(err < 0) or similar patterns.
> > >   -EINVAL < 0 triggers a spurious WARNING on every call.
> > >
> > > drivers/media/i2c/isl7998x.c:
> > >   if (pm_runtime_get_if_in_use(dev) <= 0)  (two call sites)
> > >   -EINVAL <= 0 causes the driver to always skip register programming
> > >   when !CONFIG_PM.
> > >
> > > drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c:
> > >   if (pm_runtime_get_if_in_use(dev) <= 0)  (two call sites)
> > >   -EINVAL <= 0 prevents any debug statistics from being collected.
> > >
> > > Fixes: 9d58aa46291d ("drm/i915: Fix the GT fence revocation runtime PM logic")
> > > Fixes: cbb6a7413b17 ("drm/xe: Introduce xe_pm_runtime_get_noresume for inner callers")
> > > Fixes: 672c473576ca ("drm/gma500: Rewrite power management code")
> > > Fixes: 727538a4bbff ("drm/imagination: Implement power management")
> > > Fixes: b30289e7fa92 ("ASoC: SOF: Fix runtime pm usage counter balance after fw exception")
> > > Fixes: c0b57581b73b ("iommu/mediatek: Add power-domain operation")
> > > Fixes: 0f181d3cf7d9 ("iommu/rockchip: Add runtime PM support")
> > > Fixes: 51ef2be546e2 ("media: i2c: isl7998x: Add driver for Intersil ISL7998x")
> > > Fixes: cbb819c363c5 ("media: rkisp1: debug: Collect input status by sampling ISP_FLAGS_SHD")
> >
> > I don't think this one is right. The rkisp1 driver only runs on ARCH_MXC
> > and ARCH_ROCKCHIP, which select CONFIG_PM. The same may be true for some
> > of the other fixes tags.
> 
> But code itself should be wrong even though these platform force enable
> CONFIG_PM.

How does it make the code wrong in the rkisp1 driver ? There's nothing
to fix there, because there's no bug.

I'm not saying this patch is wrong (I'll let the runtime PM folks
provide expert feedback), but I think some of the Fixes: tags are not
correct.

> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > > Change in v2
> > > - new patches.
> > >
> > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > Cc: linux-pm@vger.kernel.org
> > > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > > Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > Cc: Maxime Ripard <mripard@kernel.org>
> > > Cc: "Thomas Hellstrom" <thomas.hellstrom@linux.intel.com>
> > > Cc: Simona Vetter <simona@ffwll.ch>
> > > Cc: David Airlie <airlied@gmail.com>
> > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > > Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
> > > Cc: Alessio Belle <alessio.belle@imgtec.com>
> > > Cc: Luigi Santivetti <luigi.santivetti@imgtec.com>
> > > Cc: Liam Girdwood <lgirdwood@gmail.com>
> > > Cc: Mark Brown <broonie@kernel.org>
> > > Cc: Jaroslav Kysela <perex@perex.cz>
> > > Cc: Takashi Iwai <tiwai@suse.com>
> > > Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
> > > Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
> > > Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> > > Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> > > Cc: Robin Murphy <robin.murphy@arm.com>
> > > Cc: Yong Wu <yong.wu@mediatek.com>
> > > Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > > Cc: Heiko Stuebner <heiko@sntech.de>
> > > Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> > > Cc: Dafna Hirschfeld <dafna@fastmail.com>
> > > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > Cc: Michael Tretter <m.tretter@pengutronix.de>
> > > Cc: Daniel Baluta <daniel.baluta@nxp.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> > > Cc: dri-devel@lists.freedesktop.org
> > > Cc: imagination@lists.freedesktop.org
> > > Cc: intel-gfx@lists.freedesktop.org
> > > Cc: intel-xe@lists.freedesktop.org
> > > Cc: iommu@lists.linux.dev
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Cc: linux-mediatek@lists.infradead.org
> > > Cc: linux-media@vger.kernel.org
> > > Cc: linux-rockchip@lists.infradead.org
> > > Cc: linux-sound@vger.kernel.org
> > > Cc: sound-open-firmware@alsa-project.org
> > > Cc: imx@lists.linux.dev
> > > ---
> > >  include/linux/pm_runtime.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> > > index de9e7518ecef2..1d983fe55a16a 100644
> > > --- a/include/linux/pm_runtime.h
> > > +++ b/include/linux/pm_runtime.h
> > > @@ -276,7 +276,7 @@ static inline int pm_schedule_suspend(struct device *dev, unsigned int delay)
> > >  }
> > >  static inline int pm_runtime_get_if_in_use(struct device *dev)
> > >  {
> > > -	return -EINVAL;
> > > +	return 1;
> > >  }
> > >  static inline int pm_runtime_get_if_active(struct device *dev)
> > >  {

-- 
Regards,

Laurent Pinchart
