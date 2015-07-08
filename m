From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v6 2/7] ACPI: Make ACPI processor driver more extensible
Date: Wed, 8 Jul 2015 17:46:45 -0400
Message-ID: <CAJ5Y-eZCWF8fsfwtJFAS9wyz8ttpGVTZKhoboCudLhUHw80qkg@mail.gmail.com>
References: <cover.1434398373.git.ashwin.chaugule@linaro.org>
	<9e352cbe2feac01158a21511bac5c544dc2f29e2.1434398373.git.ashwin.chaugule@linaro.org>
	<2138469.Io9yItSdst@vostro.rjw.lan>
	<CAJ5Y-eZBYb551T=kBdbjM4YQ1f_hwYBgkVk4wJsDHSib00XfrA@mail.gmail.com>
	<CAJZ5v0gKW7bR66trxvuhd_Gb=ZMBbec++u+V+T4mroCZMtO+vg@mail.gmail.com>
	<CAJ5Y-ebW3aCSSs4UQFLpLFSfo7d9zPVfigoROjN80uXzG1sZLw@mail.gmail.com>
	<CAJZ5v0h24-YAeqW79Se8kRr+_+RknwNfLwS_74-sN+W0_wBaZg@mail.gmail.com>
	<CAJ5Y-eYwnaDzyL78CyJDmo35CFTNoQrYfEcO3VYnpaZkSVPdcw@mail.gmail.com>
	<CAJ5Y-eaGmF6pRKuapzQo8ruMt0FX4kVrdyu-os6maVaS7WO-Pw@mail.gmail.com>
	<CAJZ5v0iGGgvzdcvAfS9ZiQTWMhqF9GWfZ7Fx6_rF1BGZmACpXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:35824 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbbGHVqq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2015 17:46:46 -0400
Received: by oihr66 with SMTP id r66so120259412oih.2
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2015 14:46:45 -0700 (PDT)
In-Reply-To: <CAJZ5v0iGGgvzdcvAfS9ZiQTWMhqF9GWfZ7Fx6_rF1BGZmACpXw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jaswinder Singh <jaswinder.singh@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Patch Tracking <patches@linaro.org>, linux acpi <linux-acpi@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>

On 8 July 2015 at 16:46, Rafael J. Wysocki <rafael@kernel.org> wrote:
> Hi Ashwin,

Hi,

> On Wed, Jul 8, 2015 at 10:28 PM, Ashwin Chaugule
> <ashwin.chaugule@linaro.org> wrote:
>> On 8 July 2015 at 16:05, Ashwin Chaugule <ashwin.chaugule@linaro.org=
> wrote:
>>> On 8 July 2015 at 15:55, Rafael J. Wysocki <rafael@kernel.org> wrot=
e:
>>>> Hi Ashwin,
>>>>
>>>> On Wed, Jul 8, 2015 at 9:16 PM, Ashwin Chaugule
>>>> <ashwin.chaugule@linaro.org> wrote:
>>>>> Hi Rafael,
>>>>>
>
> [cut]
>
>>>>
>>>> Also I'm still unsure what the connection between _CST and CPPC is=
=2E
>>>>
>>>
>>> There isnt. But I'm missing where I've implied the dependency?
>>
>> Perhaps the confusion is coming from the introduction of ACPI_CST in
>> this file. I could leave it as it is and just separate out the
>> ACPI_PSS bits. But I figured, while I'm at it, I'd introduce ACPI_CS=
T,
>> since we know the LPI stuff is coming up soon as a CST alternative
>> anyway. So if you prefer, I can drop the CST bits and maybe Sudeep c=
an
>> address that as part of his LPI patchset?
>
> Yes, please.  That would be much less confusing.

Deja Vu. :)

When I let processor_driver and processor_idle compile on ARM64, I get
a bunch of errors because processor_idle.c contains a lot of X86
specific defines. That is why I'd created the ACPI_CST option which
we'd enable only on X86.

I'm not entirely sure what these enums and functions should default
to, or what they should be on ARM specifically. Given that on ARM64
we're likely to use LPI as against CST, it seems the original approach
is better. Thoughts?

------8<------

rivers/acpi/processor_idle.c: In function =E2=80=98disabled_by_idle_boo=
t_param=E2=80=99:
drivers/acpi/processor_idle.c:73:9: error: =E2=80=98boot_option_idle_ov=
erride=E2=80=99
undeclared (first use in this function)
  return boot_option_idle_override =3D=3D IDLE_POLL ||
         ^
drivers/acpi/processor_idle.c:73:9: note: each undeclared identifier
is reported only once for each function it appears in
drivers/acpi/processor_idle.c:73:38: error: =E2=80=98IDLE_POLL=E2=80=99=
 undeclared
(first use in this function)
  return boot_option_idle_override =3D=3D IDLE_POLL ||
                                      ^
drivers/acpi/processor_idle.c:74:32: error: =E2=80=98IDLE_HALT=E2=80=99=
 undeclared
(first use in this function)
   boot_option_idle_override =3D=3D IDLE_HALT;
                                ^
drivers/acpi/processor_idle.c: In function =E2=80=98acpi_safe_halt=E2=80=
=99:
drivers/acpi/processor_idle.c:121:3: error: implicit declaration of
function =E2=80=98arch_safe_halt=E2=80=99 [-Werror=3Dimplicit-function-=
declaration]
   safe_halt();
   ^
drivers/acpi/processor_idle.c: In function =E2=80=98acpi_processor_get_=
power_info_cst=E2=80=99:
drivers/acpi/processor_idle.c:435:9: error:
=E2=80=98boot_option_idle_override=E2=80=99 undeclared (first use in th=
is function)
        (boot_option_idle_override =3D=3D IDLE_NOMWAIT)) {
         ^
drivers/acpi/processor_idle.c:435:38: error: =E2=80=98IDLE_NOMWAIT=E2=80=
=99 undeclared
(first use in this function)
        (boot_option_idle_override =3D=3D IDLE_NOMWAIT)) {
                                      ^
drivers/acpi/processor_idle.c: In function =E2=80=98acpi_idle_enter_bm=E2=
=80=99:
drivers/acpi/processor_idle.c:749:2: error: implicit declaration of
function =E2=80=98acpi_unlazy_tlb=E2=80=99 [-Werror=3Dimplicit-function=
-declaration]
  acpi_unlazy_tlb(smp_processor_id());
  ^
drivers/acpi/processor_idle.c: In function =E2=80=98acpi_processor_powe=
r_init=E2=80=99:
drivers/acpi/processor_idle.c:1072:3: error: implicit declaration of
function =E2=80=98acpi_processor_cstate_check=E2=80=99
[-Werror=3Dimplicit-function-declaration]
   max_cstate =3D acpi_processor_cstate_check(max_cstate);
   ^
drivers/acpi/processor_idle.c: In function =E2=80=98disabled_by_idle_bo=
ot_param=E2=80=99:
drivers/acpi/processor_idle.c:75:1: warning: control reaches end of
non-void function [-Wreturn-type]
 }
 ^
------8<------

Regards,
Ashwin.
