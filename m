From: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Subject: [PATCH 0/5][RFC] Encryption and authentication for hibernate snapshot image
Date: Wed, 12 Sep 2018 22:23:32 +0800
Message-ID: <20180912142337.21955-1-jlee@suse.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, Oliver Neukum <oneukum@suse.com>, Ryan Chen <yu.chen.surf@gmail.com>, David Howells <dhowells@redhat.com>, Giovanni Gherdovich <ggherdovich@suse.cz>
List-Id: linux-pm@vger.kernel.org

Hi,

This patchset is the implementation of encryption and authentication
for hibernate snapshot image. The image will be encrypted by AES and
authenticated by HMAC.

The hibernate function can be used to snapshot memory pages to an image,
then kernel restores the image to memory space in a appropriate time.
There have secrets in snapshot image and cracker may modifies it for
hacking system. Encryption and authentication of snapshot image can protect
the system.

Hibernate function requests the master key through key retention service.
The snapshot master key can be a trusted key or a user defined key. The
name of snapshot master key is fixed to "swsusp-kmk". User should loads
swsusp-kmk to kernel by keyctl tool before the hibernation resume.
e.g. The swsusp-kmk must be loaded before systemd-hibernate-resume

The TPM trusted key type is preferred to be the master key. But user
defined key can also be used for testing or when the platform doesn't
have TPM. User must be aware that the security of user key relies on
user space. If the root account be compromised, then the user key will
easy to be grabbed.

Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Chen Yu <yu.c.chen@intel.com>
Cc: Oliver Neukum <oneukum@suse.com>
Cc: Ryan Chen <yu.chen.surf@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Giovanni Gherdovich <ggherdovich@suse.cz>
Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>

Lee, Chun-Yi (5):
  PM / hibernate: Create snapshot keys handler
  PM / hibernate: Generate and verify signature for snapshot image
  PM / hibernate: Encrypt snapshot image
  PM / hibernate: Erase the snapshot master key in snapshot pages
  PM / hibernate: An option to request that snapshot image must be
    authenticated

 Documentation/admin-guide/kernel-parameters.txt |   6 +
 include/linux/kernel.h                          |   3 +-
 kernel/panic.c                                  |   1 +
 kernel/power/Kconfig                            |  25 +
 kernel/power/Makefile                           |   1 +
 kernel/power/hibernate.c                        |  62 ++-
 kernel/power/power.h                            |  59 +++
 kernel/power/snapshot.c                         | 576 +++++++++++++++++++++++-
 kernel/power/snapshot_key.c                     | 303 +++++++++++++
 kernel/power/swap.c                             |   6 +
 kernel/power/user.c                             |  12 +
 11 files changed, 1036 insertions(+), 18 deletions(-)
 create mode 100644 kernel/power/snapshot_key.c

-- 
2.13.6
