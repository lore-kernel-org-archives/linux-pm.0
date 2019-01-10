From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v5 1/7] Add support for XO 1.75 to OLPC battery driver
Date: Thu, 10 Jan 2019 18:39:58 +0100
Message-ID: <20190110174005.1202564-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, x86@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello!

This patch set modifies the OLPC battery driver so that it could eventual=
ly
be used on an Arm-based OLPC XO 1.75 machine once the Embedded Controlled
driver gets merged.

It has been split off from the EC driver patch set after four re-spins.

Tested on an OLPC XO 1. I don't have a XO 1.5, but it's similar enough.

[1/7] dt-bindings: olpc_battery: Add XO-1.5 battery
[2/7] x86, olpc: Use a correct version when making up a battery node
[3/7] power: supply: olpc_battery: Use DT to get battery version
[4/7] power: supply: olpc_battery: Move priv data to a struct
[5/7] power: supply: olpc_battery: Use devm_power_supply_register()
[6/7] power: supply: olpc_battery: Avoid using platform_info
[7/7] power: supply: olpc_battery: Add OLPC XO 1.75 support

Appart from the dt-bindings patch, the patches need to be applied in orde=
r.

Lubo
