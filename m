From: Sachin Kamat <spk.linux@gmail.com>
Subject: Re: [PATCH 1/1] cpuidle: big_little: Fix build error
Date: Mon, 28 Jul 2014 11:51:09 +0530
Message-ID: <CAK5sBcFiEaK_zvifq24gQ9uPLOF_mtQo4n9R7_fBnk82gL8qQA@mail.gmail.com>
References: <1406523539-23823-1-git-send-email-sachin.kamat@samsung.com>
	<53D5EB46.7070606@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:45338 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbaG1GVL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Jul 2014 02:21:11 -0400
Received: by mail-lb0-f179.google.com with SMTP id v6so5372904lbi.38
        for <linux-pm@vger.kernel.org>; Sun, 27 Jul 2014 23:21:09 -0700 (PDT)
In-Reply-To: <53D5EB46.7070606@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>

Hi Daniel,

On Mon, Jul 28, 2014 at 11:48 AM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 07/28/2014 06:58 AM, Sachin Kamat wrote:
>>
>> big_little CPU idle driver references functions defined in MCPM driv=
er.
>> Thus make it depend on MCPM to avoid the following errors:
>>
>> drivers/built-in.o: In function `bl_enter_powerdown':
>> drivers/cpuidle/cpuidle-big_little.c:134: undefined reference to
>> `mcpm_cpu_powered_up'
>> drivers/built-in.o: In function `bl_powerdown_finisher':
>> drivers/cpuidle/cpuidle-big_little.c:104: undefined reference to
>> `mcpm_set_entry_vector'
>> drivers/cpuidle/cpuidle-big_little.c:111: undefined reference to
>> `mcpm_cpu_suspend'
>> make: *** [vmlinux] Error 1
>>
>> Reported-by: Andreas F=C3=A4rber <afaerber@suse.de>
>> Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
>> ---
>>   drivers/cpuidle/Kconfig.arm | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.a=
rm
>> index 33fc0ff..38cff69 100644
>> --- a/drivers/cpuidle/Kconfig.arm
>> +++ b/drivers/cpuidle/Kconfig.arm
>> @@ -4,6 +4,7 @@
>>   config ARM_BIG_LITTLE_CPUIDLE
>>         bool "Support for ARM big.LITTLE processors"
>>         depends on ARCH_VEXPRESS_TC2_PM || ARCH_EXYNOS
>> +       depends on MCPM
>>         select ARM_CPU_SUSPEND
>>         select CPU_IDLE_MULTIPLE_DRIVERS
>>         help
>
>
> Hi Sachin,
>
> thanks for the fix. Arnd sent the same fix a couple of weeks ago.

Oh great. Perhaps it hasn't hit the linux-next tree yet.


--=20
Regards,
Sachin.
