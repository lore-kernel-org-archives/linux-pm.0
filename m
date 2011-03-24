From: Len Brown <lenb@kernel.org>
Subject: [PATCH] APM: delete APM in Linux-2.6.40
Date: Thu, 24 Mar 2011 03:39:07 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1103240336590.4529__4195.50146111778$1300952491$gmane$org@x980>
References: <alpine.LFD.2.02.1103232321070.3848@x980>
	<20110324154505.934a56a0.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <20110324154505.934a56a0.sfr@canb.auug.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/feature-removal-schedule.txt |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index b3f35e5..2a03c46 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -619,3 +619,11 @@ Why:	The original implementation of memsw feature enabled by
 Who:	Michal Hocko <mhocko@suse.cz>
 
 ----------------------------
+
+What:	CONFIG_APM
+When:	2.6.40
+Why:	Microsoft deleted APM from Windows as of Vista in in 2006.
+	It now seems more than safe that the latest Linux Kernel be APM-free.
+	The vintage laptops supporting APM are now difficult to find,
+	making it problatic to maintain this code.
+Who:	Len Brown <len.brown@intel.com>
-- 
1.7.4.1.343.ga91df
