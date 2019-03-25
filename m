From: Matthew Garrett <matthewgarrett@google.com>
Subject: [PATCH 09/27] uswsusp: Disable when the kernel is locked down
Date: Mon, 25 Mar 2019 15:09:36 -0700
Message-ID: <20190325220954.29054-10-matthewgarrett@google.com>
References: <20190325220954.29054-1-matthewgarrett@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325220954.29054-1-matthewgarrett@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jmorris@namei.org
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, Matthew Garrett <mjg59@srcf.ucam.org>, James Morris <james.l.morris@oracle.com>, linux-pm@vger.kernel.org, pavel@ucw.cz, rjw@rjwysocki.net, Matthew Garrett <matthewgarrett@google.com>
List-Id: linux-pm@vger.kernel.org

From: Matthew Garrett <mjg59@srcf.ucam.org>

uswsusp allows a user process to dump and then restore kernel state, which
makes it possible to modify the running kernel.  Disable this if the kernel
is locked down.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: James Morris <james.l.morris@oracle.com>
cc: linux-pm@vger.kernel.org
Cc: pavel@ucw.cz
Cc: rjw@rjwysocki.net
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 kernel/power/user.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/power/user.c b/kernel/power/user.c
index 2d8b60a3c86b..0305d513c274 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -52,6 +52,9 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 	if (!hibernation_available())
 		return -EPERM;
 
+	if (kernel_is_locked_down("/dev/snapshot"))
+		return -EPERM;
+
 	lock_system_sleep();
 
 	if (!atomic_add_unless(&snapshot_device_available, -1, 0)) {
-- 
2.21.0.392.gf8f6787159e-goog
