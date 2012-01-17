From: Len Brown <lenb@kernel.org>
Subject: [PATCH 46/50] ACPI: kernel-parameters.txt : Add intel_idle.max_cstate
Date: Tue, 17 Jan 2012 07:21:38 -0500
Message-ID: <b4ddcb39236bceec7ebc842ae777390fe0f0af08.1326802230.git.len.brown@intel.com>
References: <1326802902-21583-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1326802902-21583-1-git-send-email-lenb@kernel.org>
In-reply-to: <553575f1ae048aa44682b46b3c51929a0b3ad337.1326802228.git.len.brown@intel.com>
References: <553575f1ae048aa44682b46b3c51929a0b3ad337.1326802228.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Masanari Iida <standby24x7@gmail.com>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Masanari Iida <standby24x7@gmail.com>

Add missing intel_idle.max_cstate in kernel-parameters.txt

Signed-off-by Masanari Iida <standby24x7@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/kernel-parameters.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 81c287f..c6a56d8 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1035,6 +1035,11 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			By default, super page will be supported if Intel IOMMU
 			has the capability. With this option, super page will
 			not be supported.
+
+	intel_idle.max_cstate=	[KNL,HW,ACPI,X86]
+			0	disables intel_idle and fall back on acpi_idle.
+			1 to 6	specify maximum depth of C-state.
+
 	intremap=	[X86-64, Intel-IOMMU]
 			on	enable Interrupt Remapping (default)
 			off	disable Interrupt Remapping
-- 
1.7.9.rc1
