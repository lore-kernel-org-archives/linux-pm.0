From: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Subject: [PATCH 0/2] [RFC] sysfs: Add hook for checking the file capability of opener
Date: Sun, 30 Dec 2018 21:28:54 +0800
Message-ID: <20181230132856.24095-1-jlee@suse.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, Randy Dunlap <rdunlap@infradead.org>, Joe Perches <joe@perches.com>, Bart Van Assche <bvanassche@acm.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>, Chen Yu <yu.c.chen@intel.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-pm@vger.kernel.org

There have some discussion in the following mail loop about checking
capability in sysfs write handler:
    https://lkml.org/lkml/2018/9/13/978

Sometimes we check the capability in sysfs implementation by using
capable function. But the checking can be bypassed by opening sysfs
file within an unprivileged process then writing the file within a
privileged process. The tricking way has been exposed by Andy Lutomirski
for CVE-2013-1959.

Because the sysfs_ops does not forward the file descriptor to the
show/store callback, there doesn't have chance to check the capability
of file's opener. This patch adds the hook to sysfs_ops that allows
different implementation in object and attribute levels for checking
file capable before accessing sysfs interfaces.

The callback function of kobject sysfs_ops is the first implementation
of new hook. It casts attribute to kobj_attribute then calls the file
capability callback function of attribute level. The same logic can
be implemented in other sysfs file types, like: device, driver and
bus type. 

The capability checking logic in wake_lock/wake_unlock sysfs interface
is the first example for kobject. It will check the opener's capability.

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

Lee, Chun-Yi (2):
  sysfs: Add hook for checking the file capable
  PM / Sleep: Checking the file capability when writing wak lock
    interface

 fs/sysfs/file.c         |  8 ++++++++
 include/linux/kobject.h |  2 ++
 include/linux/sysfs.h   |  2 ++
 kernel/power/main.c     | 14 ++++++++++++++
 kernel/power/wakelock.c |  6 ------
 lib/kobject.c           | 26 ++++++++++++++++++++++++++
 6 files changed, 52 insertions(+), 6 deletions(-)

-- 
2.13.6
