From: Amit Kachhap <amit.kachhap@linaro.org>
Subject: Re: [RFC PATCH 0/2] thermal: Add generic cpu cooling devices
 according to thermal framework
Date: Fri, 3 Feb 2012 17:43:46 +0530
Message-ID: <CAK44p238f5g5zEga-Tz3Nmf0W7y8p-2mgWU2qrjnxWozbx-APA@mail.gmail.com>
References: <1323789196-4942-1-git-send-email-amit.kachhap@linaro.org>
	<CAK44p22LmkGVo0W5eoT5Ms57pkP7PbWoxNS2c8bnx=1FhBvamA@mail.gmail.com>
	<1328253147.20438.19.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1328253147.20438.19.camel@rui.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mjg59@srcf.ucam.org, linux-acpi@vger.kernel.org, lenb@kernel.org, linaro-dev@lists.linaro.org, patches@linaro.org
List-Id: linux-pm@vger.kernel.org

On 3 February 2012 12:42, Zhang Rui <rui.zhang@intel.com> wrote:
> Hi, sorry for the late response.
>
> On =E5=9B=9B, 2012-01-19 at 14:47 +0530, Amit Kachhap wrote:
>> On 13 December 2011 20:43, Amit Daniel Kachhap <amit.kachhap@linaro.=
org> wrote:
>> > PATCH 1) =C2=A0[thermal: Add a new trip type to use cooling device=
 instance number]
>> > This patch adds a new trip type THERMAL_TRIP_STATE_ACTIVE which pa=
sses
>> > cooling device instance number and may be helpful for cpufreq cool=
ing devices
>> > to take the correct cooling action.
>> >
> Sorry, I'm still not quite clear about how this will be used.
> Say, processor has P0~P3, then we need to register a thermal zone wit=
h
> three STATE_ACTIVE trip points, like the picture shown below?
>
> processor in full speed, i.e. P0
> ----------------------------
> state active trip point 1
> ----------------------------
> processor in P1
> ----------------------------
> state active trip point 2
> ----------------------------
> processor in P2
> ----------------------------
> state active trip point 3
> ----------------------------
> processor in P3
>

Thanks for the review. Your representation of the 3 PSTATES and trip
points are correct. Also remember the case that we have registered one
cpufreq cooling device and binded 3 instance of it with the 3 trip
points. So in the current patch set_cur_state will pass the instance
id also which will help in moving to the current P state.

This same behaviour is achieved through PASSIVE state but it iterates
through all the P states. so the current patch avoids the iteration
and goes to a single state directly.

>> > PATCH 2) =C2=A0[thermal: Add generic cpu cooling implementation]
>> > This patch adds generic cpu cooling low level implementation throu=
gh frequency
>> > clipping and cpu hotplug. In future, other cpu related cooling dev=
ices may be
>> > added here. An ACPI version of this already exists(drivers/acpi/pr=
ocessor_thermal.c).
>> > But this will be useful for platforms like ARM using the generic t=
hermal interface
>> > along with the generic cpu cooling devices. The cooling device reg=
istration API's
>> > return cooling device pointers which can be easily binded with the=
 thermal zone
>> > trip points.
>> >
> It seems that we can convert the ACPI processor thermal driver to fol=
low
> this generic cpu cooling implementation, right?
I am not sure if we can convert the processor thermal driver because
it performs other cpu cooling like throttling, idle etc and then ACPI
abstraction on top of it. I am thinking of exporting the generic low
level cooling implementation like this patch is doing from
processor_thermal.c file so that it can be usable with non-acpi
interface.
What is your opinion about it?

Thanks,
Amit Daniel
>
> thanks,
> rui
>>
>> Any comments on these patches? I submitted them quite long back.
>>
>> Regards,
>> Amit D
>>
>> >
>> > Amit Daniel Kachhap (2):
>> > =C2=A0thermal: Add a new trip type to use cooling device instance =
number
>> > =C2=A0thermal: Add generic cpu cooling implementation
>> >
>> > =C2=A0Documentation/thermal/cpu-cooling-api.txt | =C2=A0 52 +++++
>> > =C2=A0Documentation/thermal/sysfs-api.txt =C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 =C2=A04 +-
>> > =C2=A0drivers/thermal/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 11 +
>> > =C2=A0drivers/thermal/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A01 +
>> > =C2=A0drivers/thermal/cpu_cooling.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | =C2=A0302 +++++++++++++++++++++++++++++
>> > =C2=A0drivers/thermal/thermal_sys.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 27 +++-
>> > =C2=A0include/linux/cpu_cooling.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | =C2=A0 45 +++++
>> > =C2=A0include/linux/thermal.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A01 +
>> > =C2=A08 files changed, 440 insertions(+), 3 deletions(-)
>> > =C2=A0create mode 100644 Documentation/thermal/cpu-cooling-api.txt
>> > =C2=A0create mode 100644 drivers/thermal/cpu_cooling.c
>> > =C2=A0create mode 100644 include/linux/cpu_cooling.h
>> >
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
