From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: cpuidle governors
Date: Thu, 07 Nov 2013 14:54:42 +0100
Message-ID: <527B9BA2.4060100@linaro.org>
References: <1383831870.4370.382.camel@chaos.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:42089 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956Ab3KGNyp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Nov 2013 08:54:45 -0500
Received: by mail-we0-f176.google.com with SMTP id w62so551983wes.35
        for <linux-pm@vger.kernel.org>; Thu, 07 Nov 2013 05:54:44 -0800 (PST)
In-Reply-To: <1383831870.4370.382.camel@chaos.site>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>, linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On 11/07/2013 02:44 PM, Jean Delvare wrote:
> Hi all,
>
> I had to work on cpuidle recently and there are two things which caus=
ed
> me trouble and I'd like to discuss.
>
> 1* Is there no documentation about how the available governors (menu =
and
> ladder) work? I found good documentation of the general architecture =
and
> API in Documentation/cpuidle, but I am missing a description of the
> internal logic of each available governor (just like
> Documentation/cpu-freq/governors.txt for cpufreq.)

IMO, the code review and the header description in the menu.c file is=20
the best way to understand how the governor works. For very specific=20
questions, try asking in the mailing list.

> Also, the
> documentation says that "the kernel picks the best governor based on
> governor ratings" but that's pretty vague. An explanation of how the
> governors are rated would be good to have. Could this be added?

Yeah, actually they are rated but depending on the system configuration=
=20
one fit better than the other one. Tickless system =3D> menu governor,=20
Periodic system =3D> ladder governor. Using a tickless system with the=20
ladder governor is less efficient from a power saving POV.

> 2* Is there no way to specify/force the cpuidle governor at boot time=
? I
> found the cpuidle_sysfs_switch parameter and then I can change the
> governor in sysfs, but this seems overly complicated (and apparently
> discouraged) in a production environment. Wouldn't it be easier to
> implement a cpuidle.governor=3Dxxx boot parameter? That way we don't =
have
> to deal with run-time changes, but the user can still force a specifi=
c
> governor.

Yes, that may make sense.

Thanks
   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

