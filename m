From: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Subject: [PATCH 2/2] PM / Sleep: Check the file capability when writing wake lock interface
Date: Sun, 30 Dec 2018 21:28:56 +0800
Message-ID: <20181230132856.24095-3-jlee@suse.com>
References: <20181230132856.24095-1-jlee@suse.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181230132856.24095-1-jlee@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, Randy Dunlap <rdunlap@infradead.org>, Joe Perches <joe@perches.com>, Bart Van Assche <bvanassche@acm.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>, Chen Yu <yu.c.chen@intel.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-pm@vger.kernel.org

The wake lock/unlock sysfs interfaces check that the writer must has
CAP_BLOCK_SUSPEND capability. But the checking logic can be bypassed
by opening sysfs file within an unprivileged process and then writing
the file within a privileged process. The tricking way has been exposed
by Andy Lutomirski in CVE-2013-1959.

Here is an example that it's a simplified version from CVE-2013-1959
to bypass the capability checking of wake_lock sysfs:

int main(int argc, char* argv[])
{
        int fd, ret = 0;

        fd = open("/sys/power/wake_lock", O_RDWR);
        if (fd < 0)
                err(1, "open wake_lock");

        if (dup2(fd, 1) != 1)
                err(1, "dup2");
        sleep(1);
        execl("./string", "string");

        return ret;
}

The string is a privileged program that it can be used to write
string to wake_lock interface. The main unprivileged process opens
the sysfs interface and overwrites stdout. So the privileged
process will write to wake_lock.

This patch implemented the callback of file capable checking hook
in kobject attribute level. It will check the opener's capability.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Chen Yu <yu.c.chen@intel.com>
Cc: Giovanni Gherdovich <ggherdovich@suse.cz>
Cc: Jann Horn <jannh@google.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Joe Perches <joe@perches.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 kernel/power/main.c     | 14 ++++++++++++++
 kernel/power/wakelock.c |  6 ------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index 98e76cad128b..265199efedc1 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -661,6 +661,11 @@ static ssize_t wake_lock_store(struct kobject *kobj,
 	return error ? error : n;
 }
 
+static bool wake_lock_store_file_capable(const struct file *file)
+{
+	return file_ns_capable(file, &init_user_ns, CAP_BLOCK_SUSPEND);
+}
+
 power_attr(wake_lock);
 
 static ssize_t wake_unlock_show(struct kobject *kobj,
@@ -678,6 +683,11 @@ static ssize_t wake_unlock_store(struct kobject *kobj,
 	return error ? error : n;
 }
 
+static bool wake_unlock_store_file_capable(const struct file *file)
+{
+	return file_ns_capable(file, &init_user_ns, CAP_BLOCK_SUSPEND);
+}
+
 power_attr(wake_unlock);
 
 #endif /* CONFIG_PM_WAKELOCKS */
@@ -803,6 +813,10 @@ static int __init pm_init(void)
 	power_kobj = kobject_create_and_add("power", NULL);
 	if (!power_kobj)
 		return -ENOMEM;
+#ifdef CONFIG_PM_WAKELOCKS
+	wake_lock_attr.store_file_capable = wake_lock_store_file_capable;
+	wake_unlock_attr.store_file_capable = wake_unlock_store_file_capable;
+#endif
 	error = sysfs_create_group(power_kobj, &attr_group);
 	if (error)
 		return error;
diff --git a/kernel/power/wakelock.c b/kernel/power/wakelock.c
index 4210152e56f0..52a4cfe55eb5 100644
--- a/kernel/power/wakelock.c
+++ b/kernel/power/wakelock.c
@@ -205,9 +205,6 @@ int pm_wake_lock(const char *buf)
 	size_t len;
 	int ret = 0;
 
-	if (!capable(CAP_BLOCK_SUSPEND))
-		return -EPERM;
-
 	while (*str && !isspace(*str))
 		str++;
 
@@ -251,9 +248,6 @@ int pm_wake_unlock(const char *buf)
 	size_t len;
 	int ret = 0;
 
-	if (!capable(CAP_BLOCK_SUSPEND))
-		return -EPERM;
-
 	len = strlen(buf);
 	if (!len)
 		return -EINVAL;
-- 
2.13.6
