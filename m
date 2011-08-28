From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Subject: [PATCH 0/3] bq24022: Add support for bq2407x family
Date: Sun, 28 Aug 2011 15:07:34 +0200
Message-ID: <201108281507.35105.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: linux-pm@lists.linux-foundation.org, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: linux-pm@vger.kernel.org

The bq2407x family is quite similar to the bq24022 charger.
As suggested by MyungJoo Ham it should be possible to implement
support for it inside the bq24022 driver instead of adding a new one.

The first two patches fix small things Mark Brown identified in my
submission of a separate bq2407x driver that also exist in the bq24022
while the third implements the bq2407x specifics.

Heiko Stuebner (3):
  bq24022: Evaluate returns of gpio_direction_output-calls
  bq24022: Keep track of gpio states
  bq24022: Add support for the bq2407x family

 drivers/regulator/Kconfig         |    7 +-
 drivers/regulator/bq24022.c       |  138 ++++++++++++++++++++++++++++++-------
 include/linux/regulator/bq24022.h |    7 ++
 3 files changed, 125 insertions(+), 27 deletions(-)

-- 
1.7.2.3
