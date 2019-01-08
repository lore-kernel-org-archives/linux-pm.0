From: <Claudiu.Beznea@microchip.com>
Subject: [PATCH 0/3] add support for power off check in suspend
Date: Tue, 8 Jan 2019 09:52:48 +0000
Message-ID: <1546941147-18410-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com, linux@armlinux.org.uk, lgirdwood@gmail.com, broonie@kernel.org, rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Claudiu.Beznea@microchip.com
List-Id: linux-pm@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Hi,

AT91 platforms support a power saving mode where SoC's power is cut off (we=
 call
it backup mode). The resume is done with the help of bootloaders. To be abl=
e to
suspend/resume Linux to/from this mode all the drivers suspend/resume callb=
acks
should save/restore the content of all the active registers. We have 2 prob=
lems
we are trying to solve:
- some of these drivers are shared with other non Microchip SoCs (e.g. macb
  driver) and we don't want to disturbe other users of corresponding IPs wi=
th
  all the register save/restore operations;
- the suspend/resume time for the rest of the power saving mode we are usin=
g
  could be improved if we would know in drivers the suspend mode the platfo=
rm
  is switched to.

A solution that would have been solve our problems was proposed in [1] but =
in
the end it wasn't accepted. It ended up with the introduction of
pm_suspend_target_state variable that could be used along with the changes =
in
this series.

While the discussion of [1] progressed it has been proposed (in [2]) to
implement a function that would tell if the platform's power would be cut o=
ff
at the end of the suspend procedure.

The patches in this series does as follows:
1/3 - add a new member to platform_suspend_ops that will tell if platform's
      power will be cut off at the end of the suspend procedure; drivers co=
uld
      use it via platform_off_in_suspend()
2/3 - add a new function to regulator's core that could be used to check if=
 a
      proper regulator has been configured (via DT) to be powered off in
      suspend. This is used on this series to check the CPU's regulator is
      properly configured in DT to be turned off in suspend.
3/3 - fill .off_in_suspend member of at91_pm_ops; the functionality in patc=
h 2/3
      is used to double check CPU's regulator would be turned off in suspen=
d.

Thank you,
Claudiu Beznea

[1] https://lkml.org/lkml/2017/6/22/938
[2] https://lkml.org/lkml/2017/7/16/457

Claudiu Beznea (3):
  PM / Suspend: Add support to check if platform's power is off in
    suspend
  regulator: core: add helper to check if regulator is disabled in
    suspend
  ARM: at91: pm: add support for .off_in_suspend

 arch/arm/mach-at91/pm.c            | 61 ++++++++++++++++++++++++++++++++++=
+---
 drivers/regulator/core.c           | 17 +++++++++++
 include/linux/regulator/consumer.h |  7 +++++
 include/linux/suspend.h            |  6 ++++
 kernel/power/suspend.c             | 13 ++++++++
 5 files changed, 100 insertions(+), 4 deletions(-)

--=20
2.7.4
