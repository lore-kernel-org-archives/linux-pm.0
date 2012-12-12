From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle - remove the power_specified field in the driver
Date: Wed, 12 Dec 2012 21:00:53 +0100
Message-ID: <50C8E275.9050308@linaro.org>
References: <1355325801-1317-1-git-send-email-daniel.lezcano@linaro.org> <CAODwPW81fXDNMTvG8juR6iAGFeDV9PXE-65Wp+dAE-mcKYU2nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:49164 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754985Ab2LLUBD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Dec 2012 15:01:03 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so618386bkw.19
        for <linux-pm@vger.kernel.org>; Wed, 12 Dec 2012 12:01:01 -0800 (PST)
In-Reply-To: <CAODwPW81fXDNMTvG8juR6iAGFeDV9PXE-65Wp+dAE-mcKYU2nw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Julius Werner <jwerner@chromium.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Francesco Lavra <francescolavra.fl@gmail.com>, linux-pm@vger.kernel.org, Deepthi Dharwar <deepthi@linux.vnet.ibm.com>, Trinabh Gupta <g.trinabh@gmail.com>, Lists Linaro-dev <linaro-dev@lists.linaro.org>, len.brown@intel.com, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Sameer Nanda <snanda@chromium.org>

On 12/12/2012 07:50 PM, Julius Werner wrote:
> Thanks again for making this happen, Daniel. I like this version,
> except for the small nitpick that I still think it would make sense t=
o
> also turn the loop in menu.c around. How about something like this:
>=20
>        for (i =3D drv->state_count - 1; i >=3D CPUIDLE_DRIVER_STATE_S=
TART; i++) {
>                 struct cpuidle_state *s =3D &drv->states[i];
>                 if (!s->disable && s->exit_latency <=3D latency_req &=
&
>                     s->target_residency <=3D data->predicted_us &&
>                     s->exit_latency * multiplier <=3D data->predicted=
_us) {
>                         data->last_state_idx =3D i;
>                         data->exit_us =3D s->exit_latency;
>                         break;
>                 }
>         }

Actually I was planning to do that in a separate patch.


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

