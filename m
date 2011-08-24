From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 0/1] PM: omap_device fix for v3.1-rc
Date: Wed, 24 Aug 2011 16:43:56 -0700
Message-ID: <1314229437-31836-1-git-send-email-khilman__39740.3085641146$1314229558$gmane$org@ti.com>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

While this fix could go via the OMAP tree, since the original patch
causing the problem went via Rafael's tree (due to dependencies) I'm
submitting the fix to go via Rafael's tree as well.

Applies on v3.1-rc3.

Kevin Hilman (1):
  OMAP: omap_device: only override _noirq methods, not normal
    suspend/resume

 arch/arm/plat-omap/omap_device.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

-- 
1.7.6
