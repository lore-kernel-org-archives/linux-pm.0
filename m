From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [RFC 1/2] PM / Domains: Power on domain early during system resume
Date: Thu, 30 Oct 2014 08:36:34 +0100
Message-ID: <1414654594.5114.8.camel@AMDC1943>
References: <1414072090-11293-1-git-send-email-k.kozlowski@samsung.com>
 <1414072090-11293-2-git-send-email-k.kozlowski@samsung.com>
 <7hk33iahvu.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49286 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626AbaJ3Hgj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Oct 2014 03:36:39 -0400
In-reply-to: <7hk33iahvu.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Inki Dae <inki.dae@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, David Airlie <airlied@linux.ie>, Kukjin Kim <kgene.kim@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On =C5=9Bro, 2014-10-29 at 10:46 -0700, Kevin Hilman wrote:
> Krzysztof Kozlowski <k.kozlowski@samsung.com> writes:
>=20
> > When resuming the system the power domain has to be powered on earl=
y so
> > any runtime PM aware devices could resume.
> >
> > This fixes following scenario reproduced on Exynos DRM:
> > 1. Power domain is off before suspending the system.
> > 2. System is suspended to RAM.
> > 3. Resuming starts. The Exynos DRM driver resume callback is called=
=2E
> > 4. The Exynos DRM driver calls drm_helper_resume_force_mode which t=
urns
> >    the screen on by calling exynos_dsi_dpms with DRM_MODE_DPMS_ON.
>=20
> Dumb Q: if the device (and power domain) were off before (and during)
> suspend, why are they being resumed?
>=20
> Shouldn't the resume path restore things to the same state they were
> before suspend?

One could expect that... but the Exynos DRM driver behaves differently
(and some other drivers also). In resume method it calls
drm_helper_resume_force_mode() which forces restoring mode setting
configuration. Apparently setting a mode needs DPMS on:
static void exynos_drm_crtc_commit(struct drm_crtc *crtc)
{
	...
	exynos_drm_crtc_dpms(crtc, DRM_MODE_DPMS_ON);
	...

The previous DPMS status (status during suspend) is completely ignored
here.

I dunno why... maybe someone from DRM could share some thoughts?


Best regards,
Krzysztof

