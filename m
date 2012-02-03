From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [RFC PATCH 0/2] thermal: Add generic cpu cooling devices
 according to thermal framework
Date: Fri, 03 Feb 2012 15:12:27 +0800
Message-ID: <1328253147.20438.19.camel@rui.sh.intel.com>
References: <1323789196-4942-1-git-send-email-amit.kachhap@linaro.org>
	 <CAK44p22LmkGVo0W5eoT5Ms57pkP7PbWoxNS2c8bnx=1FhBvamA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAK44p22LmkGVo0W5eoT5Ms57pkP7PbWoxNS2c8bnx=1FhBvamA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Amit Kachhap <amit.kachhap@linaro.org>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mjg59@srcf.ucam.org, linux-acpi@vger.kernel.org, lenb@kernel.org, linaro-dev@lists.linaro.org, patches@linaro.org
List-Id: linux-pm@vger.kernel.org

Hi, sorry for the late response.

On =E5=9B=9B, 2012-01-19 at 14:47 +0530, Amit Kachhap wrote:
> On 13 December 2011 20:43, Amit Daniel Kachhap <amit.kachhap@linaro.o=
rg> wrote:
> > PATCH 1)  [thermal: Add a new trip type to use cooling device insta=
nce number]
> > This patch adds a new trip type THERMAL_TRIP_STATE_ACTIVE which pas=
ses
> > cooling device instance number and may be helpful for cpufreq cooli=
ng devices
> > to take the correct cooling action.
> >
Sorry, I'm still not quite clear about how this will be used.
Say, processor has P0~P3, then we need to register a thermal zone with
three STATE_ACTIVE trip points, like the picture shown below?

processor in full speed, i.e. P0
----------------------------=20
state active trip point 1
----------------------------
processor in P1
----------------------------
state active trip point 2
----------------------------
processor in P2
----------------------------
state active trip point 3
----------------------------
processor in P3

> > PATCH 2)  [thermal: Add generic cpu cooling implementation]
> > This patch adds generic cpu cooling low level implementation throug=
h frequency
> > clipping and cpu hotplug. In future, other cpu related cooling devi=
ces may be
> > added here. An ACPI version of this already exists(drivers/acpi/pro=
cessor_thermal.c).
> > But this will be useful for platforms like ARM using the generic th=
ermal interface
> > along with the generic cpu cooling devices. The cooling device regi=
stration API's
> > return cooling device pointers which can be easily binded with the =
thermal zone
> > trip points.
> >
It seems that we can convert the ACPI processor thermal driver to follo=
w
this generic cpu cooling implementation, right?

thanks,
rui
>=20
> Any comments on these patches? I submitted them quite long back.
>=20
> Regards,
> Amit D
>=20
> >
> > Amit Daniel Kachhap (2):
> >  thermal: Add a new trip type to use cooling device instance number
> >  thermal: Add generic cpu cooling implementation
> >
> >  Documentation/thermal/cpu-cooling-api.txt |   52 +++++
> >  Documentation/thermal/sysfs-api.txt       |    4 +-
> >  drivers/thermal/Kconfig                   |   11 +
> >  drivers/thermal/Makefile                  |    1 +
> >  drivers/thermal/cpu_cooling.c             |  302 +++++++++++++++++=
++++++++++++
> >  drivers/thermal/thermal_sys.c             |   27 +++-
> >  include/linux/cpu_cooling.h               |   45 +++++
> >  include/linux/thermal.h                   |    1 +
> >  8 files changed, 440 insertions(+), 3 deletions(-)
> >  create mode 100644 Documentation/thermal/cpu-cooling-api.txt
> >  create mode 100644 drivers/thermal/cpu_cooling.c
> >  create mode 100644 include/linux/cpu_cooling.h
> >


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
