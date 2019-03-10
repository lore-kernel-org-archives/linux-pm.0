From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 00/10] Add support for XO 1.75 to OLPC battery driver
Date: Sun, 10 Mar 2019 17:24:09 +0100
Message-ID: <20190310162419.11861-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Darren Hart <dvhart@infradead.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, x86@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello!

This patch set modifies the OLPC battery driver so that it could eventual=
ly
be used on an Arm-based OLPC XO 1.75 machine.

Compared to the previous version, it splits the x86 platform patch into
three so that it's hopefully easier to review.

Patch 10/10 ("power: supply: olpc_battery: Have the framework register
sysfs files for us") is new. The review comments are addressed, details
in individual patches.

Thank you,
Lubo
