From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH] PM: docs: sleep-states: Fix a typo ("includig")
Date: Wed, 25 Apr 2018 12:07:03 +0200
Message-ID: <20180425100715.17235-1-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, Jonathan Corbet <corbet@lwn.net>, Lukas Wunner <lukas@wunner.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-doc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 Documentation/admin-guide/pm/sleep-states.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/pm/sleep-states.rst b/Documentation/admin-guide/pm/sleep-states.rst
index 1e5c0f00cb2f..dbf5acd49f35 100644
--- a/Documentation/admin-guide/pm/sleep-states.rst
+++ b/Documentation/admin-guide/pm/sleep-states.rst
@@ -15,7 +15,7 @@ Sleep States That Can Be Supported
 ==================================
 
 Depending on its configuration and the capabilities of the platform it runs on,
-the Linux kernel can support up to four system sleep states, includig
+the Linux kernel can support up to four system sleep states, including
 hibernation and up to three variants of system suspend.  The sleep states that
 can be supported by the kernel are listed below.
 
-- 
2.17.0
