Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622032;
	b=2n8DSeoyn0IHhgm6/lX/jrAavGSn0vU7VPMZBfPzh5Rj5wXi50fcrRXg7S0/9/IjFPzV
	 3dDljy5GHT5/TLiIKxm/KidwbbN6hFDCp+u127JwKAdhSQ4BedloAqKyopqqtjq9AbZIR
	 CrTtcTuWsxYN2gaiCYrXrMeTpvjKMfLwDL+pTuCGmOJ2Fxtdyj5C3nE0I5TcTX4lMMHFs
	 ooj89naRibP7qksBXJLID4vve3QjlZoOezd0uhPhuJfhlNij46ztDjyRPqNdLKmVdKCIu
	 2ZcWcyURPxjCw1sX9AYuKcyXOyoxyu+K7R5j571l4S07EpjUVXsdcP1DozD7fIYnRnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622032;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/QyiPsXELdVcU8h8SMClaBGSEvaC+/rJrAPi6gmrO6o=;
	b=1Pmd/JWa9OPmZoEg0jI14amGz8cmJRCmzblR2A+cKCxfYozJhjd3xygzUyD7zs0B5ggk
	 H9hj0u24wTOhR/acZ2eEIvC0HK+87flNR52bX54Mm2eB2xB5Q/VNgJhcTCjKDWURh53BM
	 s+F0tH5yDyP7OXVNrMTrjHdiaj08N9S11Mqkz+/njirQIfg7qTc+zQx94gf+5JEXVQjwf
	 1rm6iKOK0iMv7Lmeb+CT07udMC1pGhoSWSpWmxpW3/eRBZVwj1L1lnLpw2TwB3QECuNVw
	 kOrNMy8IhwG5xQ9F/6pdXX04OvdkjJ23xbsWnIGttdy7DK4gvAEsh6mBY7hL4w/8w9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PQxfwm4H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EBE606A321
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PQxfwm4H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F181F000CA
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 15:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795622031;
	bh=/QyiPsXELdVcU8h8SMClaBGSEvaC+/rJrAPi6gmrO6o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PQxfwm4HZ/4IqyyrMOscRAB2kuaFOJ+mjqRe77pK7wNNL/dxm6v/H5iv9tkA+8Ghc
	 6eBHSrAii4f84K/dSSppdUYZ6q80NYTG26eI8racfvJjvM3sISdvsCZKZze19cLvq3
	 1+EyHmosT/IEVYUe1o8vZHe3wQw9uMooKYd3ePSTp6OQp95659nLXZeOsv/OtVnLYd
	 ft+bbBdo9XqMrpSX8Qzxg9vg7lbJLigI67Tt3AZZ6Zw0bDnaQ5el3aqqYqaDH2aLXv
	 wfxAt75u0olCnHZace59c40GuFU6HGv49t6FrfoRajlrY+6Nxyv0RiCmTBHk9AkK3Y
	 XdhaGwekSgKpQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5c14a204305so4046094e87.3
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 07:53:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHyFM17Lw2wJqtNxeuz8CnVtv/7PnE6s2LJaYCnBj2oOf5Lu/HHZw7BQ8z5HGcDs7OBc3lldLcwUg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8R/Y/rtgCEPL0X59qAQbR/siOQhWJv/IAOokOFegesQAq7S2TK
	Iv6jXvOFyR13cePCKgGTEY+UzBHfG/yxFZv/YOTbIBu3cOlCFkVv2HY1mp1NXP/VW4xKpK3BLQ3
	S18Ya6bsBPdw/Hjnn3fruOC4PH/DEg8k=
X-Received: by 2002:ac2:4e07:0:b0:5c1:4f54:a6c6 with SMTP id
 2adb3069b0e04-5c1bc7cb0f6mr5811261e87.30.1795622030011; Wed, 25 Nov 2026
 07:53:50 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117173738.1073856-1-Frank.Li@oss.nxp.com>
 <20261117173738.1073856-2-Frank.Li@oss.nxp.com> <CAPx+jO9RwkpSKwq6vq00uoXK-mcovJ2LMH7b_ByRnxOUj8nH8w@mail.gmail.com>
In-Reply-To: <CAPx+jO9RwkpSKwq6vq00uoXK-mcovJ2LMH7b_ByRnxOUj8nH8w@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 25 Nov 2026 16:53:35 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jsnLjEBxa1R4Q3hZLZKrCUW0xSE9SqLB8bd4tNAhXTAQ@mail.gmail.com>
X-Gm-Features: Aa3M54pn_ud7xKJ4Sp9_9mJsafRFGsiuNY-zMFg468C0_97OrWEf728wG9SLJbM
Message-ID: <CAJZ5v0jsnLjEBxa1R4Q3hZLZKrCUW0xSE9SqLB8bd4tNAhXTAQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] PM: runtime: fix stub pm_runtime_get_if_in_use()
 for !CONFIG_PM
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Frank.Li@oss.nxp.com, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Heiko Stuebner <heiko@sntech.de>, 
	Ulf Hansson <ulfh@kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Matthew Auld <matthew.auld@intel.com>, Hans de Goede <hansg@kernel.org>, 
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, 
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, Mark Brown <broonie@kernel.org>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, Yong Wu <yong.wu@mediatek.com>, 
	Will Deacon <will@kernel.org>, Tomasz Figa <tfiga@chromium.org>, Marek Vasut <marex@denx.de>, 
	Michael Tretter <m.tretter@pengutronix.de>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Hans Verkuil <hverkuil@kernel.org>, 
	"open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support:Keyword:mediatek" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support:Keyword:mediatek" <linux-mediatek@lists.infradead.org>, 
	"open list:ARM/Rockchip SoC support:Keyword:b[Rr]ock[Cc]hipb" <linux-rockchip@lists.infradead.org>, imx@lists.linux.dev, 
	Frank Li <Frank.Li@nxp.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>, Simona Vetter <simona@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Matthew Brost <matthew.brost@intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Alessio Belle <alessio.belle@imgtec.com>, 
	Luigi Santivetti <luigi.santivetti@imgtec.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Bard Liao <yung-chuan.liao@linux.intel.com>, 
	Kai Vehmanen <kai.vehmanen@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Dafna Hirschfeld <dafna@fastmail.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Daniel Baluta <daniel.baluta@nxp.com>, 
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>, dri-devel@lists.freedesktop.org, 
	imagination@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, iommu@lists.linux.dev, 
	linux-media@vger.kernel.org, linux-sound@vger.kernel.org, 
	sound-open-firmware@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 4:07=E2=80=AFPM Ulf Hansson
<ulf.hansson@oss.qualcomm.com> wrote:
>
> On Tue, Nov 17, 2026 at 6:38=E2=80=AFPM <Frank.Li@oss.nxp.com> wrote:
> >
> > From: Frank Li <Frank.Li@nxp.com>
> >
> > The stub for pm_runtime_get_if_in_use() under !CONFIG_PM currently
> > returns -EINVAL.  The real implementation returns:
> >   1  - device is active and its usage counter is non-zero (bumped)
> >   0  - device is not in use or not active (counter not bumped)
> >  -EINVAL - runtime PM disabled for this device
> >
> > When CONFIG_PM is not set every device is permanently "active" and
> > always considered "in use", so the stub must return 1, mirroring
> > __pm_runtime_resume() which already returns 1 in the same build.
> >
> > Returning -EINVAL breaks callers that test the return value with
> > comparisons other than "!=3D 0 / =3D=3D 0":
> >
> > drivers/gpu/drm/i915/intel_runtime_pm.c:
> >   if (intel_runtime_pm_get_if_in_use(rpm))
> >   which wraps to: ret =3D pm_runtime_get_if_in_use(); return ret > 0;
> >   With -EINVAL the wrapper returns false, causing an incorrect error
> >   path in the GT fence revocation code.
> >
> > drivers/gpu/drm/xe/xe_pm.c:
> >   if (pm_runtime_get_if_in_use(xe->drm.dev) > 0)
> >   With -EINVAL the condition is false; xe_pm_runtime_get_if_in_use()
> >   returns false, so callers believe the device is not usable.
> >
> > drivers/gpu/drm/gma500/power.c:
> >   return pm_runtime_get_if_in_use(dev) =3D=3D 1;
> >   -EINVAL !=3D 1, so the helper always returns false when !CONFIG_PM.
> >
> > drivers/gpu/drm/imagination/pvr_power.c:
> >   if (pm_runtime_get_if_in_use(...) <=3D 0)
> >   -EINVAL <=3D 0 is true, so the driver always takes the "requeue" erro=
r
> >   path instead of proceeding with the active device.
> >
> > sound/soc/sof/debug.c:
> >   if (pm_runtime_get_if_in_use(sdev->dev) =3D=3D 1)
> >   -EINVAL !=3D 1, so d3_prevented is never set, corrupting exception
> >   debug accounting.
> >
> > drivers/iommu/mtk_iommu.c:
> >   if (pm_runtime_get_if_in_use(dom->plat_dev->dev) <=3D 0)
> >   -EINVAL <=3D 0 skips the TLB flush, leaving stale IOMMU mappings.
> >
> > drivers/iommu/rockchip-iommu.c:
> >   Three call sites use WARN_ON_ONCE(err < 0) or similar patterns.
> >   -EINVAL < 0 triggers a spurious WARNING on every call.
> >
> > drivers/media/i2c/isl7998x.c:
> >   if (pm_runtime_get_if_in_use(dev) <=3D 0)  (two call sites)
> >   -EINVAL <=3D 0 causes the driver to always skip register programming
> >   when !CONFIG_PM.
> >
> > drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c:
> >   if (pm_runtime_get_if_in_use(dev) <=3D 0)  (two call sites)
> >   -EINVAL <=3D 0 prevents any debug statistics from being collected.
> >
> > Fixes: a436b6a19f57 ("PM / runtime: Add new helper for conditional usag=
e count incrementation")
> > Fixes: 3b85b7bcccf4 ("drm/xe: Fix display runtime_pm handling")
> > Fixes: 672c473576ca ("drm/gma500: Rewrite power management code")
> > Fixes: b30289e7fa92 ("ASoC: SOF: Fix runtime pm usage counter balance a=
fter fw exception")
> > Fixes: c0b57581b73b ("iommu/mediatek: Add power-domain operation")
> > Fixes: 51ef2be546e2 ("media: i2c: isl7998x: Add driver for Intersil ISL=
7998x")
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change in v3
> > - drop tag: cbb819c363c5 ("media: rkisp1: debug: Collect input status b=
y sampling ISP_FLAGS_SHD")
> > selected PM at arch config
> > - drop tag: 0f181d3cf7d9 ("iommu/rockchip: Add runtime PM support")
> > selected PM at arch config
> > - drop tag: 9d58aa46291d ("drm/i915: Fix the GT fence revocation runtim=
e PM logic")
> > guard by CONFIG_PM
> > - drop tag 727538a4bbff ("drm/imagination: Implement power management")
> > depend on PM
> > `
> > Change in v2
> > - new patches.
> >
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: linux-pm@vger.kernel.org
> > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: "Thomas Hellstrom" <thomas.hellstrom@linux.intel.com>
> > Cc: Simona Vetter <simona@ffwll.ch>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Matthew Brost <matthew.brost@intel.com>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
> > Cc: Alessio Belle <alessio.belle@imgtec.com>
> > Cc: Luigi Santivetti <luigi.santivetti@imgtec.com>
> > Cc: Liam Girdwood <lgirdwood@gmail.com>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Jaroslav Kysela <perex@perex.cz>
> > Cc: Takashi Iwai <tiwai@suse.com>
> > Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
> > Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
> > Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> > Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Yong Wu <yong.wu@mediatek.com>
> > Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com=
>
> > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > Cc: Heiko Stuebner <heiko@sntech.de>
> > Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> > Cc: Dafna Hirschfeld <dafna@fastmail.com>
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: Michael Tretter <m.tretter@pengutronix.de>
> > Cc: Daniel Baluta <daniel.baluta@nxp.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: imagination@lists.freedesktop.org
> > Cc: intel-gfx@lists.freedesktop.org
> > Cc: intel-xe@lists.freedesktop.org
> > Cc: iommu@lists.linux.dev
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-mediatek@lists.infradead.org
> > Cc: linux-media@vger.kernel.org
> > Cc: linux-rockchip@lists.infradead.org
> > Cc: linux-sound@vger.kernel.org
> > Cc: sound-open-firmware@alsa-project.org
> > Cc: imx@lists.linux.dev
> > ---
> >  include/linux/pm_runtime.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> > index de9e7518ecef2..1d983fe55a16a 100644
> > --- a/include/linux/pm_runtime.h
> > +++ b/include/linux/pm_runtime.h
> > @@ -276,7 +276,7 @@ static inline int pm_schedule_suspend(struct device=
 *dev, unsigned int delay)
> >  }
> >  static inline int pm_runtime_get_if_in_use(struct device *dev)
> >  {
> > -       return -EINVAL;
> > +       return 1;
>
> This should be return 0, as we did not bump the usage count.

This is kind of moot because there is no usage counter.

However, the caller may always take the opportunistic "in use" path
because there are no potential costs related to it.
