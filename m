From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 0/3][RFC] Introduce the in-kernel hibernation encryption
Date: Wed, 20 Jun 2018 17:39:37 +0800
Message-ID: <cover.1529486870.git.yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc: "Lee, Chun-Yi" <jlee@suse.com>, Borislav Petkov <bp@alien8.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi,
As security becomes more and more important, we add the in-kernel
encryption support for hibernation.

This prototype is a trial version to implement the hibernation
encryption in the kernel, so that the users do not have to rely
on third-party tools to encrypt the hibernation image. The only
dependency on user space is that, the user space should provide
a valid key derived from passphrase to the kernel for image encryption.

There was a discussion on the mailing list on whether this key should
be derived in kernel or in user space. And it turns out to be generating
the key by user space is more acceptable[1]. So this patch set is divided
into two parts:
1. The hibernation snapshot encryption in kernel space,
2. the key derivation implementation in user space.

Please refer to each patch for detail, and feel free to comment on
this, thanks.

[1] https://www.spinics.net/lists/linux-crypto/msg33145.html

Chen Yu (3):
  PM / Hibernate: Add helper functions for hibernation encryption
  PM / Hibernate: Encrypt the snapshot pages before submitted to the
    block device
  tools: create power/crypto utility

 MAINTAINERS                           |   8 +
 kernel/power/Kconfig                  |  13 +
 kernel/power/Makefile                 |   1 +
 kernel/power/crypto_hibernation.c     | 405 ++++++++++++++++++++++++++++++
 kernel/power/power.h                  |  38 +++
 kernel/power/swap.c                   | 215 +++++++++++++++-
 tools/power/crypto/Makefile           |  26 ++
 tools/power/crypto/crypto_hibernate.c | 447 ++++++++++++++++++++++++++++++++++
 8 files changed, 1142 insertions(+), 11 deletions(-)
 create mode 100644 kernel/power/crypto_hibernation.c
 create mode 100644 tools/power/crypto/Makefile
 create mode 100644 tools/power/crypto/crypto_hibernate.c

-- 
2.7.4
