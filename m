From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [RFC 1/2] PM / Domains: Power on domain early during system resume
Date: Wed, 29 Oct 2014 10:46:29 -0700
Message-ID: <7hk33iahvu.fsf@deeprootsystems.com>
References: <1414072090-11293-1-git-send-email-k.kozlowski@samsung.com>
	<1414072090-11293-2-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1414072090-11293-2-git-send-email-k.kozlowski@samsung.com>
	(Krzysztof Kozlowski's message of "Thu, 23 Oct 2014 15:48:09 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Inki Dae <inki.dae@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, David Airlie <airlied@linux.ie>, Kukjin Kim <kgene.kim@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

Krzysztof Kozlowski <k.kozlowski@samsung.com> writes:

> When resuming the system the power domain has to be powered on early so
> any runtime PM aware devices could resume.
>
> This fixes following scenario reproduced on Exynos DRM:
> 1. Power domain is off before suspending the system.
> 2. System is suspended to RAM.
> 3. Resuming starts. The Exynos DRM driver resume callback is called.
> 4. The Exynos DRM driver calls drm_helper_resume_force_mode which turns
>    the screen on by calling exynos_dsi_dpms with DRM_MODE_DPMS_ON.

Dumb Q: if the device (and power domain) were off before (and during)
suspend, why are they being resumed?

Shouldn't the resume path restore things to the same state they were
before suspend?

Kevin
