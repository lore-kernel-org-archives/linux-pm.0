From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 0/9] cpuidle: rework device state count handling
Date: Thu, 26 Sep 2013 12:40:17 +0200
Message-ID: <52440F11.8010706@linaro.org>
References: <1377008627-32691-1-git-send-email-b.zolnierkie@samsung.com> <98588621.30oeP6cEfZ@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:42878 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755712Ab3IZKkX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Sep 2013 06:40:23 -0400
Received: by mail-we0-f177.google.com with SMTP id t60so921637wes.36
        for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2013 03:40:21 -0700 (PDT)
In-Reply-To: <98588621.30oeP6cEfZ@amdc1032>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: rjw@sisk.pl, linux-pm@vger.kernel.org, kyungmin.park@samsung.com

On 09/23/2013 06:05 PM, Bartlomiej Zolnierkiewicz wrote:
>
> Hi Daniel,
>
> Did you have a chance to take a look at this patchset?
>
> Could it be queued for 3.13 (unfortunately it is probably too late fo=
r 3.12)?

Thanks for the head up, I will review it.

Unfortunately this patchset did not get any acked-by from the different=
=20
maintainers. Furthermore I believe it would be up to Rafael to take the=
m.

   -- Daniel

> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
>
> On Tuesday, August 20, 2013 04:23:38 PM Bartlomiej Zolnierkiewicz wro=
te:
>> Hi,
>>
>> Some cpuidle drivers assume that cpuidle core will handle cases wher=
e
>> device->state_count is smaller than driver->state_count, unfortunate=
ly
>> currently this is untrue (device->state_count is used only for handl=
ing
>> cpuidle state sysfs entries and driver->state_count is used for all
>> other cases) and will not be fixed in the future as device->state_co=
unt
>> is planned to be removed [1].
>>
>> This patchset fixes such drivers (ARM EXYNOS cpuidle driver and ACPI
>> cpuidle driver), removes superflous device->state_count initializati=
on
>> from drivers for which device->state_count equals driver->state_coun=
t
>> (POWERPC pseries cpuidle driver and intel_idle driver) and finally
>> removes state_count field from struct cpuidle_device.
>>
>> Additionaly (while at it) this patchset fixes C1E promotion disable
>> quirk handling (in intel_idle driver) and converts cpuidle drivers c=
ode
>> to use the common cpuidle_[un]register() routines (in POWERPC pserie=
s
>> cpuidle driver and intel_idle driver).
>>
>> [1] http://permalink.gmane.org/gmane.linux.power-management.general/=
36908
>>
>> Best regards,
>> --
>> Bartlomiej Zolnierkiewicz
>> Samsung R&D Institute Poland
>> Samsung Electronics
>>
>>
>> Bartlomiej Zolnierkiewicz (9):
>>    ARM: EXYNOS: cpuidle: fix AFTR mode check
>>    POWERPC: pseries: cpuidle: remove superfluous dev->state_count
>>      initialization
>>    POWERPC: pseries: cpuidle: use the common cpuidle_[un]register()
>>      routines
>>    ACPI / cpuidle: fix max idle state handling with hotplug CPU supp=
ort
>>    ACPI / cpuidle: remove dev->state_count setting
>>    intel_idle: do C1E promotion disable quirk for hotplugged CPUs
>>    intel_idle: remove superfluous dev->state_count initialization
>>    intel_idle: use the common cpuidle_[un]register() routines
>>    cpuidle: remove state_count field from struct cpuidle_device
>>
>>   arch/arm/mach-exynos/cpuidle.c                  |   8 +-
>>   arch/powerpc/platforms/pseries/processor_idle.c |  59 +---------
>>   drivers/acpi/processor_idle.c                   |  29 +++--
>>   drivers/cpuidle/cpuidle.c                       |   3 -
>>   drivers/cpuidle/sysfs.c                         |   5 +-
>>   drivers/idle/intel_idle.c                       | 140 +++++-------=
------------
>>   include/linux/cpuidle.h                         |   1 -
>>   7 files changed, 51 insertions(+), 194 deletions(-)
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

