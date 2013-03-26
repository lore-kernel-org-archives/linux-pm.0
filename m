From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 01/15] timer: move enum definition out of ifdef section
Date: Tue, 26 Mar 2013 10:55:43 +0100
Message-ID: <5151709F.1030207@linaro.org>
References: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org> <1364234140-514-2-git-send-email-daniel.lezcano@linaro.org> <515125DB.2040806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:64931 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759630Ab3CZJzn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Mar 2013 05:55:43 -0400
Received: by mail-wi0-f171.google.com with SMTP id hn17so479095wib.4
        for <linux-pm@vger.kernel.org>; Tue, 26 Mar 2013 02:55:42 -0700 (PDT)
In-Reply-To: <515125DB.2040806@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: rjw@sisk.pl, tglx@linutronix.de, andrew@lunn.ch, linaro-kernel@lists.linaro.org, magnus.damm@gmail.com, ben-linux@fluff.org, linux-pm@vger.kernel.org, nsekhar@ti.com, patches@linaro.org, rob.herring@calxeda.com, linux@arm.linux.org.uk, kevin.hilman@linaro.org, horms@verge.net.au, jason@lakedaemon.net, kernel@pengutronix.de, kgene.kim@samsung.com, plagnioj@jcrosoft.com, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, lenb@kernel.org

On 03/26/2013 05:36 AM, Santosh Shilimkar wrote:
> On Monday 25 March 2013 11:25 PM, Daniel Lezcano wrote:
>> The next patch will setup automatically the broadcast timer for
>> the different cpuidle driver when one idle state stops its timer.
>> This will be part of the generic code.
>>
>> But some ARM boards, like s3c64xx, uses cpuidle but without the
>> CONFIG_GENERIC_CLOCKEVENTS_BUILD set. Hence the cpuidle framework
>> will be compiled with the code supposed to be generic, that is
>> with clockevents_notify and the different enum, but will fail to
>> compile because the enum is not defined.
>>
>> Also the function clockevents_notify is a noop macro, this is fine
>> except the usual code is:
>>
>> 	int cpu =3D smp_processor_id();
>> 	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ON, &cpu);
>>
>> and that raises a warning telling the variable 'cpu' is not used.
>>
>> Move the clock_event_nofitiers enum definition out of the
>> CONFIG_GENERIC_CLOCKEVENTS_BUILD section to prevent a compilation
>> error when these are used in the code.
>>
>> Change the clockevents_notify macro to a static inline noop function
>> to prevent a compilation warning.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>=20
> So why can't s3c64xx enable "CONFIG_GENERIC_CLOCKEVENTS_BUILD" if the=
y
> wants to use broadcast notfiers ? May be am missing something.

They won't use broadcast notifiers but the cpuidle code
'drivers/cpuidle/cpuidle.c' has a generic code using it. It does not
compile because an enum definition is inside the block
CONFIG_GENERIC_CLOCKEVENTS_BUILD.

=2E..
       if (drv->states[next_state].flags & CPUIDLE_FLAG_TIMER_STOP)
                clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER,
                                   &dev->cpu);
=2E..

clockevents_notify will be a noop (this is ok), but
CLOCK_EVT_NOTIFY_BROADCAST_ENTER won't be defined, so error at compile =
time.


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

