From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Thermal:about a BUG
Date: Thu, 21 Nov 2013 11:33:31 +0800
Message-ID: <1385004811.2379.28.camel@rzhang-lenovo>
References: <201311201707055318198@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:34856 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133Ab3KUDcQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 20 Nov 2013 22:32:16 -0500
In-Reply-To: <201311201707055318198@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "xulinuxkernel@gmail.com" <xulinuxkernel@gmail.com>
Cc: "eduardo.valentin" <eduardo.valentin@ti.com>, linux-pm <linux-pm@vger.kernel.org>

Hi,

thanks for reporting the problem.

On =E4=B8=89, 2013-11-20 at 17:07 +0800, xulinuxkernel@gmail.com wrote:
> =20
> Hi  all=20
> Recently I porting the thermal driver,I think there will be a bug
> following,I am Just not sure about it,
> In functon get_target_state (),
> ...
> case THERMAL_TREND_DROPPING:
> if (cur_state =3D=3D instance->lower) {
> if (!throttle)
> next_target =3D THERMAL_NO_TARGET;
> } else {
>     next_target =3D cur_state - 1;
>     if (next_target > instance->upper)
>         next_target =3D instance->upper;
> }
> break;
> case THERMAL_TREND_DROP_FULL:
> if (cur_state =3D=3D instance->lower) {
> if (!throttle)
>         next_target =3D THERMAL_NO_TARGET;
> } else
>     next_target =3D instance->lower;
> break;
> ..
> =20
> For case THERMAL_TREND_DROPPING
> if cur_state=3D0,instance->lower=3D2,
> so next_state =3D0xffffffff ,so next_target > instance->upper will be
> right,
> =20
> I think In this case will be wrong.
> and I think this will be okay.
> =20
> if (cur_state <=3D instance->lower) {
> if (!throttle)
> next_target =3D THERMAL_NO_TARGET;
> } else {
>     next_target =3D cur_state - 1;
>     if (next_target > instance->upper)
>         next_target =3D instance->upper;
> }

this should fix the problem for you, plus we may also needs this change
for THERMAL_TREND_DROPPING_FULL case.
But my question would be:
How could a cooling device be in a cooling state that is lower than the
lower limit of an active thermal_instance?
This seems like that the cooling device' cooling state is changed beyon=
d
thermal core, and I do not think the current code handles this situatio=
n
well. IMO, we need a bigger fix for this issue. Let me think about it
and reply to you later.

thanks,
rui



