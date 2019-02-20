From: <michael.kao@mediatek.com>
Subject: [PATCH v2,0/7] Add Mediatek thermal dirver for mt8183
Date: Wed, 20 Feb 2019 20:31:26 +0800
Message-ID: <1550665893-22561-1-git-send-email-michael.kao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patchset supports for mt8183 chip to mtk_thermal.c.
MT8183 has six temperature sensors and two thermal
controllers. It has different calibration coefficent with
past project, and doesn't need to select bank.
As a result, we add the common architecture for scalability.

change in v2:
1.Add fix tag of commit message to PATCH 1/7.
2.Change memery declaration of controller_base to PATCH 4/7.
3.Add module author to PATCH 7/7.

Michael Kao (7):
	  thermal: mediatek: fix register index error
	    thermal: mediatek: add common index of vts settings.
	    thermal: mediatek: add calibration item
	    thermal: mediatek: add thermal controller offset
	    thermal: mediatek: add flag for bank selection
	    dt-bindings: thermal: add binding document for mt8183 thermal
	      controller
	    thermal: mediatek: add support for MT8183

	   .../bindings/thermal/mediatek-thermal.txt          |   1 +
	    drivers/thermal/mtk_thermal.c                      | 316 +++++++++++++++++----
	     2 files changed, 258 insertions(+), 59 deletions(-)
