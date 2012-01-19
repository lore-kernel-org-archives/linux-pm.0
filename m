From: Amit Kachhap <amit.kachhap@linaro.org>
Subject: Re: [RFC PATCH 0/2] thermal: Add generic cpu cooling devices
 according to thermal framework
Date: Thu, 19 Jan 2012 14:47:31 +0530
Message-ID: <CAK44p22LmkGVo0W5eoT5Ms57pkP7PbWoxNS2c8bnx=1FhBvamA@mail.gmail.com>
References: <1323789196-4942-1-git-send-email-amit.kachhap@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1323789196-4942-1-git-send-email-amit.kachhap@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, mjg59@srcf.ucam.org, linux-acpi@vger.kernel.org, lenb@kernel.org, rui.zhang@intel.com, linaro-dev@lists.linaro.org, amit.kachhap@linaro.org, patches@linaro.org
List-Id: linux-pm@vger.kernel.org

On 13 December 2011 20:43, Amit Daniel Kachhap <amit.kachhap@linaro.org=
> wrote:
> PATCH 1) =A0[thermal: Add a new trip type to use cooling device insta=
nce number]
> This patch adds a new trip type THERMAL_TRIP_STATE_ACTIVE which passe=
s
> cooling device instance number and may be helpful for cpufreq cooling=
 devices
> to take the correct cooling action.
>
> PATCH 2) =A0[thermal: Add generic cpu cooling implementation]
> This patch adds generic cpu cooling low level implementation through =
frequency
> clipping and cpu hotplug. In future, other cpu related cooling device=
s may be
> added here. An ACPI version of this already exists(drivers/acpi/proce=
ssor_thermal.c).
> But this will be useful for platforms like ARM using the generic ther=
mal interface
> along with the generic cpu cooling devices. The cooling device regist=
ration API's
> return cooling device pointers which can be easily binded with the th=
ermal zone
> trip points.
>

Any comments on these patches? I submitted them quite long back.

Regards,
Amit D

>
> Amit Daniel Kachhap (2):
> =A0thermal: Add a new trip type to use cooling device instance number
> =A0thermal: Add generic cpu cooling implementation
>
> =A0Documentation/thermal/cpu-cooling-api.txt | =A0 52 +++++
> =A0Documentation/thermal/sysfs-api.txt =A0 =A0 =A0 | =A0 =A04 +-
> =A0drivers/thermal/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
11 +
> =A0drivers/thermal/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A01 +
> =A0drivers/thermal/cpu_cooling.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0302 +++=
++++++++++++++++++++++++++
> =A0drivers/thermal/thermal_sys.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 27 +++=
-
> =A0include/linux/cpu_cooling.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 45 +=
++++
> =A0include/linux/thermal.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A01 +
> =A08 files changed, 440 insertions(+), 3 deletions(-)
> =A0create mode 100644 Documentation/thermal/cpu-cooling-api.txt
> =A0create mode 100644 drivers/thermal/cpu_cooling.c
> =A0create mode 100644 include/linux/cpu_cooling.h
>
