From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 0/17] Add support for OLPC XO 1.75 Embedded Controller
Date: Fri, 16 Nov 2018 17:23:46 +0100
Message-ID: <20181116162403.49854-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, James Cameron <quozl@laptop.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org, devel@driverdev.osuosl.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi everyone!

This is a second spin of the patch set that adds support for the Embedded
Controller on an OLPC XO 1.75 machine.

OLPC XO 1.75 is a MMP2 based ARM laptop. It plugs into the existing OLPC
platform infrastructure, currently used by the x86 based models.
The slave mode support for MMP2's SPI controller that the EC is hooked to
is now in spi.git's for-4.21 branch.

The v1 received a fair number of comments. I've attempted to address all =
of
them, either by fixing things or responding to the v1 review.  See the
change logs in the individual patches for details.

If I've overlooked something then I apologize -- I haven't dealt with
a patch set as big as this and I'm struggling to incorporate the
feedback in an organized manner. Advice from the more experienced folks
around here are welcome.

Tested to work on an OLPC XO 1.75 and also tested not to break x86
support with an OLPC XO 1 machine. I don't have a XO 1.5, but it's
unlikely this breaks it when XO 1 works.

Lubo
