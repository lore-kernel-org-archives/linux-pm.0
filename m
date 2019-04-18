From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v7 00/10] Add support for XO 1.75 to OLPC battery driver
Date: Thu, 18 Apr 2019 16:46:45 +0200
Message-ID: <20190418144655.18758-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Darren Hart <dvhart@infradead.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, x86@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello,

This patch set modifies the OLPC battery driver so that it could eventual=
ly
be used on an Arm-based OLPC XO 1.75 machine.

Compared to the previous version, it addresses review comments for the
x86 platform parts from Thomas Gleixner. Details in individual patches'
change logs.

I've failed to version the previous iteration of the set that should've
been "v6" for the change logs to make sense. Sorry for that.

Thank you,
Lubo
