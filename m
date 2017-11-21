From: Phil Reid <preid@electromag.com.au>
Subject: [RFC 0/3] i2c: core: move smbus_alert into i2c-core
Date: Tue, 21 Nov 2017 12:04:55 +0800
Message-ID: <1511237098-33250-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-i2c-owner@vger.kernel.org>
Sender: linux-i2c-owner@vger.kernel.org
To: realmz6@gmail.com, wsa@the-dreams.de, sre@kernel.org, preid@electromag.com.au, benjamin.tissoires@redhat.com, adi-buildroot-devel@lists.sourceforge.net, linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org, jdelvare@suse.de
List-Id: linux-pm@vger.kernel.org

A part of the review of previous accepted series 
"Add sbs-manager with smbalert support" Wolfram suggested moving
the smbus_alert driver module into the i2c-core.

This is a proposed implementation of that move.

I've also rename Kconfig and file name to reflect that this only
relates the smbus alert feature.

I think I've compile tested all the possible permutations of compiling 
things as either builtin or module.
eg:
core Builtin, Driver Builin
core Builtin, Driver Module
core Module,  Driver Module



Phil Reid (3):
  i2c: smbus: move of_i2c_setup_smbus_alert declaration to i2c-core.h
  i2c: Kconfig: rename variable I2C_SMBUS to I2C_SMBUS_ALERT
  i2c: core: move smbus_alert module into i2c-core

 arch/blackfin/configs/BF527-TLL6527M_defconfig |   2 +-
 drivers/i2c/Kconfig                            |  14 +-
 drivers/i2c/Makefile                           |   2 +-
 drivers/i2c/busses/Kconfig                     |   8 +-
 drivers/i2c/i2c-core-base.c                    |   7 +
 drivers/i2c/i2c-core-smbus-alert.c             | 241 +++++++++++++++++++++++++
 drivers/i2c/i2c-core-smbus.c                   |  22 ---
 drivers/i2c/i2c-core.h                         |  22 +++
 drivers/i2c/i2c-smbus.c                        | 217 ----------------------
 drivers/power/supply/Kconfig                   |   2 +-
 include/linux/i2c-smbus.h                      |  10 -
 11 files changed, 282 insertions(+), 265 deletions(-)
 create mode 100644 drivers/i2c/i2c-core-smbus-alert.c
 delete mode 100644 drivers/i2c/i2c-smbus.c

-- 
1.8.3.1
