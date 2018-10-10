From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 0/15] Add support for OLPC XO 1.75 Embedded Controller
Date: Wed, 10 Oct 2018 19:22:45 +0200
Message-ID: <20181010172300.317643-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, James Cameron <quozl@laptop.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org, devel@driverdev.osuosl.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi.

This patchset adds support for the Embedded Controller on an OLPC XO
1.75 machine. OLPC XO 1.75 is a MMP2 based ARM laptop. It plugs into
the existing OLPC platform infrastructure, currently used by the x86
based models.

The EC operates in SPI master mode, meaning the SOC is the SPI slave. It
uses extra handshake signal to signal readiness of SOC to accept data
from EC and to initiate a transaction if SOC wishes to submit data.

The SPI slave support for MMP2 was submitted separately:
https://lore.kernel.org/lkml/20181010170936.316862-1-lkundrak@v3.sk/T/#t

THe "power: supply: olpc_battery: correct the temperature" patch was
already sent out separately, but I'm including it because the last
commit of the set depends on it.

Tested to work on an OLPC XO 1.75 and also tested not to break x86
support with an OLPC XO 1 machine. I don't have a XO 1.5, but it's
unlikely this breaks it when XO 1 works.

Thanks in advance for reviews and feedback of any kind.

Lubo
