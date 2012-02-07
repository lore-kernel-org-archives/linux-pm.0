From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 0/2] PM / QoS: unconditionally build the feature
Date: Tue,  7 Feb 2012 09:34:04 +0100
Message-ID: <1328603646-2714-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Mark Gross <markgross@thegnar.org>, Venkatesh Pallipadi <venki@google.com>
Cc: Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

The PM QoS features depend on CONFIG_PM which depends on
PM_SLEEP || PM_RUNTIME. This breaks CPU C-states with kernels
not having these CONFIGs.
    
Those patches allow the features in all cases.

Based on 3.3-rc1 from mainline.
Tested on OMAP3 Beagleboard, with CONFIG_PM.
Compile tested using the i386 defconfig, with and without CONFIG_PM.


Jean Pihet (2):
  PM / QoS: unconditionally build the feature
  PM / QoS: unconditionally build the per-device constraints feature

 drivers/base/power/Makefile |    3 +-
 include/linux/pm_qos.h      |   66 -------------------------------------------
 kernel/power/Makefile       |    3 +-
 3 files changed, 4 insertions(+), 68 deletions(-)

-- 
1.7.5.4
