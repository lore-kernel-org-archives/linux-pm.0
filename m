From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [RESEND PATCH v3 1/2] PM / Domains: Allow genpd to power on during the system PM phases
Date: Wed, 15 Jun 2016 14:00:29 -0700
Message-ID: <m2fusep3pu.fsf@baylibre.com>
References: <1464601388-26693-1-git-send-email-ulf.hansson@linaro.org>
	<1464601388-26693-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35555 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751AbcFOVAc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jun 2016 17:00:32 -0400
Received: by mail-pf0-f178.google.com with SMTP id c2so12285926pfa.2
        for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2016 14:00:32 -0700 (PDT)
In-Reply-To: <1464601388-26693-2-git-send-email-ulf.hansson@linaro.org> (Ulf
	Hansson's message of "Mon, 30 May 2016 11:43:07 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, Alex Deucher <alexander.deucher@amd.com>, Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>, dri-devel@lists.freedesktop.org, Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>

Ulf Hansson <ulf.hansson@linaro.org> writes:

> If the PM domain is powered off when the first device starts its syst=
em PM
> prepare phase, genpd prevents any further attempts to power on the PM
> domain during the following system PM phases. Not until the system PM
> complete phase is finalized for all devices in the PM domain, genpd a=
gain
> allows it to be powered on.
>
> This behaviour needs to be changed, as a subsystem/driver for a devic=
e in
> the same PM domain may still need to be able to serve requests in som=
e of
> the system PM phases. Accordingly, it may need to runtime resume its
> device and thus also request the corresponding PM domain to be powere=
d on.
>
> To deal with these scenarios, let's make the device operational in th=
e
> system PM prepare phase by runtime resuming it, no matter if the PM d=
omain
> is powered on or off. Changing this also enables us to remove genpd's
> suspend_power_off flag, as it's being used to track this condition.
> Additionally, we must allow the PM domain to be powered on via runtim=
e PM
> during the system PM phases.
>
> This change also requires a fix in the AMD ACP (Audio CoProcessor) dr=
m
> driver. It registers a genpd to model the ACP as a PM domain, but
> unfortunately it's also abuses genpd's "internal" suspend_power_off f=
lag
> to deal with a corner case at system PM resume.
>
> More precisely, the so called SMU block powers on the ACP at system P=
M
> resume, unconditionally if it's being used or not. This may lead to t=
hat
> genpd's internal status of the power state, may not correctly reflect=
 the
> power state of the HW after a system PM resume.
>
> Because of changing the behaviour of genpd, by runtime resuming devic=
es in
> the prepare phase, the AMD ACP drm driver no longer have to deal with=
 this
> corner case. So let's just drop the related code in this driver.
>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes in v3:
> 	- Updated changelog.
>
> Changes in v2:
> 	- Updated changelog.
> 	- Added a fix in the AMD ACP (Audio CoProcessor) drm driver, which
> 	registers a genpd. The fix removes the usage of genpd's internal
> 	suspend_power_off flag as it's not needed after this change. Because=
 of
> 	this change I am also requesting an ack from the drm driver maintain=
er.
>
>
> ---
>  drivers/base/power/domain.c             | 84 ++++++++++++-----------=
----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 23 ---------
>  include/linux/pm_domain.h               |  1 -


=46or the PM core part:

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Acked-by: Kevin Hilman <khilman@baylibre.com>

=46or the AMD DRM driver, the changes look right too, but I'm not
confident enough about the intent of that to be sure.

Kevin
