From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC/RFT 00/10] i2c: move handling of suspended adapters to the core
Date: Mon, 10 Dec 2018 22:02:58 +0100
Message-ID: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
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
To: linux-i2c@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Finally, here is the implementation Hans and I agreed on. Plus, all potential
users I could spot already converted. Renesas R-Car driver was added on top.
This series was tested on a Renesas Lager board (R-Car H2). I had to hack some
error cases into the code to verify the workings. I couldn't create an error
case otherwise, this is why further testing with more complex setups is very
welcome.

For my taste, there is still too much boilerplate code for drivers left. Plus,
it is also too easy to put it too early or too late. But I haven't come up with
a better idea yet. And it is time to get this somehow forward.

Please comment, review, test... a branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/i2c/core-pm-helpers

Thanks,

   Wolfram

Wolfram Sang (10):
  i2c: add 'is_suspended' flag for i2c adapters
  i2c: reject new transfers when adapters are suspended
  i2c: synquacer: remove unused is_suspended flag
  i2c: brcmstb: use core helper to mark adapter suspended
  i2c: zx2967: use core helper to mark adapter suspended
  i2c: sprd: don't use pdev as variable name for struct device *
  i2c: sprd: use core helper to mark adapter suspended
  i2c: exynos5: use core helper to mark adapter suspended
  i2c: s3c2410: use core helper to mark adapter suspended
  i2c: rcar: add suspend/resume support

 drivers/i2c/busses/i2c-brcmstb.c   | 13 ++-----------
 drivers/i2c/busses/i2c-exynos5.c   | 11 ++---------
 drivers/i2c/busses/i2c-rcar.c      | 25 +++++++++++++++++++++++++
 drivers/i2c/busses/i2c-s3c2410.c   |  8 ++------
 drivers/i2c/busses/i2c-sprd.c      | 34 ++++++++++++----------------------
 drivers/i2c/busses/i2c-synquacer.c |  5 -----
 drivers/i2c/busses/i2c-zx2967.c    |  8 ++------
 drivers/i2c/i2c-core-base.c        |  3 +++
 include/linux/i2c.h                |  9 +++++++++
 9 files changed, 57 insertions(+), 59 deletions(-)

-- 
2.11.0
