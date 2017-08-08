From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/3 v2] thermal: core: Fix some error handling code in 'thermal_zone_device_register()'
Date: Tue,  8 Aug 2017 16:39:51 +0200
Message-ID: <cover.1502201798.git.christophe.jaillet@wanadoo.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
List-Id: linux-pm@vger.kernel.org

These patches fix some issue in the error handling path in
'thermal_zone_device_register()'

The first patch adds some new helper function in order to ease the resource
management.
Maybe using devm_ variant could also be a better choise to free manage
these resources. As it would be a bigger change, I've not looked at it at
all at the moment.
Also, note that this patch triggers a checkpatch warning about missing
identifier name in function definition. I've left it as is to keep the
style of the .h file.

The 2nd patch makes use of the new helper function.

The 3rd patch reorders the error handling path of
'thermal_zone_device_register()' in order to avoid the leaks.

*** These patches have been compiled tested only. ***

I also unsure about the right place for 'ida_simple_remove' in patch 3/3.


v1 -> v2:
    - add some helper functions in order to release some resources more
      easily
    - split the error handling path into 2. One before a successful call to
      'device_register()', and one after


Christophe JAILLET (3):
  thermal: core: Add some new helper functions to free resources
  thermal: core: Use the new 'thermal_zone_destroy_device_groups()'
    helper function
  thermal: core: Fix resources release in error paths in
    thermal_zone_device_register()

 drivers/thermal/thermal_core.c  | 29 ++++++++++++++---------------
 drivers/thermal/thermal_core.h  |  1 +
 drivers/thermal/thermal_sysfs.c | 29 +++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 15 deletions(-)

-- 
2.11.0
