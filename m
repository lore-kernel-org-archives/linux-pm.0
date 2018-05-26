From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] PM / hibernate: Fix oops at snapshot_write().
Date: Sat, 26 May 2018 09:59:36 +0900
Message-ID: <1527296376-3540-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, syzbot <syzbot+ae590932da6e45d6564d@syzkaller.appspotmail.com>
List-Id: linux-pm@vger.kernel.org

syzbot is reporting NULL pointer dereference at snapshot_write() [1].
This is because data->handle is zero-cleared by ioctl(SNAPSHOT_FREE).
Fix this by checking data_of(data->handle) != NULL before using it.

[1] https://syzkaller.appspot.com/bug?id=828a3c71bd344a6de8b6a31233d51a72099f27fd

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+ae590932da6e45d6564d@syzkaller.appspotmail.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
---
 kernel/power/user.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/power/user.c b/kernel/power/user.c
index 75c959d..abd2255 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -186,6 +186,11 @@ static ssize_t snapshot_write(struct file *filp, const char __user *buf,
 		res = PAGE_SIZE - pg_offp;
 	}
 
+	if (!data_of(data->handle)) {
+		res = -EINVAL;
+		goto unlock;
+	}
+
 	res = simple_write_to_buffer(data_of(data->handle), res, &pg_offp,
 			buf, count);
 	if (res > 0)
-- 
1.8.3.1
