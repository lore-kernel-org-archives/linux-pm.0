From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: [RFC Patch 4/4] mfd: AXP20x: Add backup battery DTS entry for
 Cubietruck
Date: Mon, 20 Oct 2014 22:33:31 +0200
Message-ID: <20141020223331.4e2a5b78@neptune.home>
References: <20141020215954.7f1d5502@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20141020215954.7f1d5502@neptune.home>
References: <20141020221959.2f312906@neptune.home>
In-Reply-To: <20141020221959.2f312906@neptune.home>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-sunxi@googlegroups.com, maxime.ripard@free-electrons.com, linux-arm-kernel@lists.infradead.org, lee.jones@linaro.org, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org
Cc: Olliver Schinagl <oliver+list@schinagl.nl>
List-Id: linux-pm@vger.kernel.org


---
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts       |    4 +
 1 files changed, 2 insertions(+), 0 deletion(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index a6c1a3c..efb65fb 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -125,6 +125,8 @@
 
 				interrupt-controller;
 				#interrupt-cells = <1>;
+
+				backup = <3000000 200>;
 			};
 		};
 
-- 
2.0.4
