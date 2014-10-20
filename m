From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: [RFC Patch 0/4] mfd: AXP20x: Add power supply sub-driver
Date: Mon, 20 Oct 2014 22:19:59 +0200
Message-ID: <20141020221959.2f312906@neptune.home>
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
To: linux-sunxi@googlegroups.com, maxime.ripard@free-electrons.com, linux-arm-kernel@lists.infradead.org, lee.jones@linaro.org, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org
Cc: Olliver Schinagl <oliver+list@schinagl.nl>
List-Id: linux-pm@vger.kernel.org

This series adds a power-supply driver to cover backup/RTC battery
charger, VBUS/OTG power in, AC power in and battery charger features
supported by AXP20x PMIC.

The DT bindings documentation patch depends on the following patch
from Carlo Caione:
  http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/267604.html

Note, the reporting of some of the power supply interrupts might need
to be changed to dev_debug instead of dev_info.

For the DT bindings names they might need prefixing in which case
the corresponding prefix declaration patch from Carlo would be needed
as well:
  http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/267606.html


Changes since initial posting on linux-sunxi:
 - A few typo fixes in strings/comments
 - Patch splitting

Bruno
