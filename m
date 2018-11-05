From: <Claudiu.Beznea@microchip.com>
Subject: [PATCH 0/4] power: reset: at91-poweroff: cleanups
Date: Mon, 5 Nov 2018 11:14:21 +0000
Message-ID: <1541416443-4321-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Claudiu.Beznea@microchip.com
List-Id: linux-pm@vger.kernel.org

Hi,

This series includes cleanups for at91-poweroff.c similar to the one did fo=
r
SAMA5D2 Xplained SHDWC on series at [1].

Changes were tested on SAMA5D3 Xplained, SAMA5D4 Xplained and AT91SAM9G35-E=
K
boards.

Thank you,
Claudiu Beznea

[1] https://www.spinics.net/lists/arm-kernel/msg673559.html

Claudiu Beznea (4):
  power: reset: at91-poweroff: use one poweroff function for
    at91-poweroff
  power: reset: at91-poweroff: move shdwc related data to one structure
  power: reset: at91-poweroff: check shdwc data structure at the
    beginning of probe
  power: reset: at91-poweroff: remove at91_ramc_of_match

 drivers/power/reset/at91-poweroff.c | 101 +++++++++++++++++++++-----------=
----
 1 file changed, 59 insertions(+), 42 deletions(-)

--=20
2.7.4
