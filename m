From: Len Brown <lenb@kernel.org>
Subject: [PATCH 63/76] Update documentation for parameter *notrigger* in
 einj.txt
Date: Fri, 30 Mar 2012 06:14:06 -0400
Message-ID: <6ef19ab7fa1535d35006535dba6c407dad2d845c.1333101989.git.len.brown@intel.com>
References: <1333102459-23750-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1333102459-23750-1-git-send-email-lenb@kernel.org>
In-reply-to: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
References: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Chen Gong <gong.chen@linux.intel.com>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Chen Gong <gong.chen@linux.intel.com>

Add description of parameter notrigger in the einj.txt.
One can utilize this new parameter to do some SRAR injection
test. Pay attention, the operation is highly depended on the
BIOS implementation. If no proper BIOS supports it, even if
enabling this parameter, expected result will not happen.

v2:
  Update the documentation suggested by Tony

Suggested-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Chen Gong <gong.chen@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/acpi/apei/einj.txt |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/acpi/apei/einj.txt b/Documentation/acpi/apei/einj.txt
index e7cc363..e20b6da 100644
--- a/Documentation/acpi/apei/einj.txt
+++ b/Documentation/acpi/apei/einj.txt
@@ -53,6 +53,14 @@ directory apei/einj. The following files are provided.
   This file is used to set the second error parameter value. Effect of
   parameter depends on error_type specified.
 
+- notrigger
+  The EINJ mechanism is a two step process. First inject the error, then
+  perform some actions to trigger it. Setting "notrigger" to 1 skips the
+  trigger phase, which *may* allow the user to cause the error in some other
+  context by a simple access to the cpu, memory location, or device that is
+  the target of the error injection. Whether this actually works depends
+  on what operations the BIOS actually includes in the trigger phase.
+
 BIOS versions based in the ACPI 4.0 specification have limited options
 to control where the errors are injected.  Your BIOS may support an
 extension (enabled with the param_extension=1 module parameter, or
-- 
1.7.10.rc2.19.gfae9d
