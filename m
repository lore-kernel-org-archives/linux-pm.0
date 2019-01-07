From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v3 00/16] Add support for OLPC XO 1.75 Embedded Controller
Date: Mon,  7 Jan 2019 19:34:23 +0100
Message-ID: <20190107183439.50626-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org
Cc: James Cameron <quozl@laptop.org>, Mark Rutland <mark.rutland@arm.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, x86@kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello!

This is a third spin of the patch set that adds support for the Embedded
Controller on an OLPC XO 1.75 machine.

The previous patch set got feedback from Darren Hart, Sebastian Reichel a=
nd
Andy Shevchenko which I'm very thankful for. It hopefully incorporates fi=
xes
for all issues that were pointed out. Details in individual patches.

Tested to work on an OLPC XO 1.75 and also tested not to break x86
support with an OLPC XO 1 machine. I don't have a XO 1.5, but it's
unlikely this breaks it when XO 1 works.

Thank you
Lubo
