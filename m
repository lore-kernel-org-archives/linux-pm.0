From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/14] mrst pmu: update comment
Date: Sun, 06 Nov 2011 23:11:52 -0500
Message-ID: <22f4521d664030e417f41953e922f61c65f2e189.1320636776.git.len.brown@intel.com>
References: <1320639124-16178-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1320639124-16178-1-git-send-email-lenb@kernel.org>
In-reply-to: <aeae1e92daec5a38b40ad12598b97501b675a381.1320636776.git.len.brown@intel.com>
References: <aeae1e92daec5a38b40ad12598b97501b675a381.1320636776.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

referenced MeeGo, in particular, but really means Linux, in general.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/platform/mrst/pmu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/x86/platform/mrst/pmu.c b/arch/x86/platform/mrst/pmu.c
index 9281da7..c0ac06d 100644
--- a/arch/x86/platform/mrst/pmu.c
+++ b/arch/x86/platform/mrst/pmu.c
@@ -70,7 +70,7 @@ static struct mrst_device mrst_devs[] = {
 /* 24 */ { 0x4110, 0 },			/* Lincroft */
 };
 
-/* n.b. We ignore PCI-id 0x815 in LSS9 b/c MeeGo has no driver for it */
+/* n.b. We ignore PCI-id 0x815 in LSS9 b/c Linux has no driver for it */
 static u16 mrst_lss9_pci_ids[] = {0x080a, 0x0814, 0};
 static u16 mrst_lss10_pci_ids[] = {0x0800, 0x0801, 0x0802, 0x0803,
 					0x0804, 0x0805, 0x080f, 0};
-- 
1.7.7.rc0.72.g4b5ea
