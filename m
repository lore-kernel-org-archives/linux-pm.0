From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/4] intel_idle: stop using driver_data for static flags
Date: Fri, 01 Feb 2013 23:16:37 +0100
Message-ID: <510C3EC5.3060709@linaro.org>
References: <1359691896-23567-1-git-send-email-lenb@kernel.org> <9a38405338d7464c852c4524465f84f8a2ac22fb.1359691799.git.len.brown@intel.com> <510B8059.5040609@linaro.org> <510C0C22.4000801@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:57269 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757849Ab3BAWQi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Feb 2013 17:16:38 -0500
Received: by mail-we0-f177.google.com with SMTP id d7so3327348wer.36
        for <linux-pm@vger.kernel.org>; Fri, 01 Feb 2013 14:16:37 -0800 (PST)
In-Reply-To: <510C0C22.4000801@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 02/01/2013 07:40 PM, Len Brown wrote:
> On 02/01/2013 03:44 AM, Daniel Lezcano wrote:
>> On 02/01/2013 05:11 AM, Len Brown wrote:
>>> From: Len Brown <len.brown@intel.com>
>>>
>>> The commit, 4202735e8ab6ecfb0381631a0d0b58fefe0bd4e2
>>> (cpuidle: Split cpuidle_state structure and move per-cpu statistics=
 fields)
>>> observed that the MWAIT flags for Cn on every processor to date wer=
e the
>>> same, and created get_driver_data() to supply them.
>>>
>>> Unfortunately, that assumption is false, going forward.
>>> So here we restore the MWAIT flags to the cpuidle_state table.
>>> However, instead restoring the old "driver_data" field,
>>> we put the flags into the existing "flags" field,
>>> where they probalby should have lived all along.
>>
>> Removing the driver_data is a good thing but I am not sure it is the
>> case by moving the MWAIT flags to the cpuidle_state's flags field. W=
e
>> are mixing arch specific flags with a generic code.
>>
>> This is prone to errors because new flags could appear for the cpuid=
le
>> core code and could collide with the arch specific flags.
>>
>> Wouldn't make sense to add a private field in the struct cpuidle_sta=
te
>> structure to let the driver/arch specific to store whatever is neede=
d ?
>>
>> struct cpuidle_state {
>>
>> 	...
>> 	unsigned long private;
>> 	...
>>
>> }
>=20
> The top half of the flags are reserved for the driver,
> as noted by the definition of CPUIDLE_DRIVER_FLAGS_MASK
> with the generic flag definitions:
>=20
> #define CPUIDLE_FLAG_TIME_VALID (0x01) /* is residency time measurabl=
e? */
> #define CPUIDLE_FLAG_COUPLED    (0x02) /* state applies to multiple c=
pus */
>=20
> #define CPUIDLE_DRIVER_FLAGS_MASK (0xFFFF0000)
>=20
> intel_idle already uses a driver-specific flag:
>=20
> #define CPUIDLE_FLAG_TLB_FLUSHED        0x10000
>=20
> This patch just uses 4 more bits along with that one.

Ok. In this case it would make sense to move this flag out of the
generic core code to the intel_idle.c file ? and move the [dec/en]codin=
g
macro flags_2_MWAIT_EAX and MWAIT_EAX_2_flags (with a more appropriate
name for a generic code) to the cpuidle.h file ?

  -- Daniel



> Sure, if we run out of space, we can add an additional field.
> But I don't see an immediate need for it.
>=20
> thanks,
> Len Brown
> Intel Open Source Technology Center
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

