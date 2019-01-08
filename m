From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v4 00/15] Add support for OLPC XO 1.75 Embedded Controller
Date: Tue,  8 Jan 2019 18:58:03 +0100
Message-ID: <20190108175818.705110-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, Russell King <linux@armlinux.org.uk>
Cc: James Cameron <quozl@laptop.org>, Mark Rutland <mark.rutland@arm.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello!

This is a fourth spin of the patch set that adds support for the
Embedded Controller on an OLPC XO 1.75 machine.

It hopefully incorporated all feedback received previously and also
fixes the kbuild test bot failures. The failed builds were generally
caused by configurations where the EC driver was built as module.

It turned out that the patch that turned the OLPC EC common code into
a module was not the brightest idea. I now dropped it and modified the
04/15 to not require it.

Also, the 01/15 patch has been added to allow the module to provide a
reboot handler. Patch 15/15 depends on it.

Tested to work on an OLPC XO 1.75 and also tested not to break x86
support with an OLPC XO 1 machine. I don't have a XO 1.5, but it's
unlikely this breaks it when XO 1 works.

[01/15] ARM: export arm_pm_restart()
[02/15] dt-bindings: olpc,xo1.75-ec: Add OLPC XO-1.75 EC bindings
[03/15] Platform: OLPC: Remove an unused include
[04/15] Platform: OLPC: Add XO-1.75 EC driver
[05/15] Platform: OLPC: Avoid a warning if the EC didn't register yet
[06/15] Platform: OLPC: Move EC-specific functionality out from x86
[07/15] Platform: OLPC: Use BIT() and GENMASK() for event masks
[08/15] Platform: OLPC: add a regulator for the DCON
[09/15] dt-bindings: olpc_battery: Add XO-1.5 battery
[10/15] x86, olpc: Use a correct version when making up a battery node
[11/15] power: supply: olpc_battery: Use DT to get battery version
[12/15] power: supply: olpc_battery: Move priv data to a struct
[13/15] power: supply: olpc_battery: Use devm_power_supply_register()
[14/15] power: supply: olpc_battery: Avoid using platform_info
[15/15] power: supply: olpc_battery: Add OLPC XO 1.75 support

Lubo
