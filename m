From: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
Subject: [PATCH/RFC 0/3] thermal: rcar_gen3_thermal: Apply shared interrupts
 for thermal sensors
Date: Sun, 19 Jun 2016 11:12:33 +0700
Message-ID: <57661BB1.3060401@rvc.renesas.com>
References: <57661211.7010900@rvc.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57661211.7010900@rvc.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <damm+renesas@opensource.se>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Thao Phuong Le. Nguyen" <thao.nguyen.yb@rvc.renesas.com>, "Hien Duy. Dang" <hien.dang.eb@rvc.renesas.com>, Toru Oishi <toru.oishi.zj@rvc.renesas.com>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Gaku Inami <gaku.inami.xw@bp.renesas.com>, "Khiem Trong. Nguyen" <khiem.nguyen.xt@rvc.renesas.com>, Catalin Marinas <catalin.marinas@arm.com>, Simon Horman <horms@ve>
List-Id: linux-pm@vger.kernel.org

This patchset intents to improve thermal driver operation in interrupt mode,
which has been introduced in [1].

The original idea is using 1 interrupt for each thermal sensor, to detect both up
and down temperature. It caused issue when the temperature is changing rapidly.

The new idea is about using shared interrupt I/F for all three sensors.
Two interrupts will be set to detect temperature up and down. When interrupt occurs,
the temperature will be updated in all 3 sensors, if the temperature value is changed. 

All comments are welcome.

[1]
[PATCH 0/4] thermal: rcar_gen3_thermal: Add R-Car Gen3 thermal support
https://www.spinics.net/lists/kernel/msg2282663.html

--
Gaku Inami (3):
  thermal: rcar_gen3_thermal: Modify the shared irq with initialization
  thermal: rcar_gen3_thermal: Modify the way to detect the interrupts
  arm64: dts: r8a7795: Support shared irq for thermal sensors

 arch/arm64/boot/dts/renesas/r8a7795.dtsi |  9 ++--
 drivers/thermal/rcar_gen3_thermal.c      | 89 ++++++++++++++++++++------------
 2 files changed, 63 insertions(+), 35 deletions(-)

-- 
1.9.1
