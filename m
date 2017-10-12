From: Tom Saeger <tom.saeger@oracle.com>
Subject: [PATCH 6/8] Documentation: fix ref to power basic-pm-debugging
Date: Thu, 12 Oct 2017 15:24:05 -0500
Message-ID: <60409ff12ddfbb1e188215981ff0b5f0315fb4b5.1507838726.git.tom.saeger@oracle.com>
References: <cover.1507838726.git.tom.saeger@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1507838726.git.tom.saeger@oracle.com>
Sender: linux-doc-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Tom Saeger <tom.saeger@oracle.com>, linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Tom Saeger <tom.saeger@oracle.com>
---
 Documentation/power/interface.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/power/interface.txt b/Documentation/power/interface.txt
index 7dc75f48e8bd..27df7f98668a 100644
--- a/Documentation/power/interface.txt
+++ b/Documentation/power/interface.txt
@@ -43,7 +43,7 @@ The currently selected option is printed in square brackets.
 The 'platform' option is only available if the platform provides a special
 mechanism to put the system to sleep after creating a hibernation image (ACPI
 does that, for example).  The 'suspend' option is available if Suspend-to-RAM
-is supported.  Refer to Documentation/power/basic_pm_debugging.txt for the
+is supported.  Refer to Documentation/power/basic-pm-debugging.txt for the
 description of the 'test_resume' option.
 
 To select an option, write the string representing it to /sys/power/disk.
-- 
2.14.2

