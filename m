From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/3] thermal: core: Fix some error handling code in 'thermal_zone_device_register()'
Date: Sun, 16 Jul 2017 08:58:19 +0200
Message-ID: <cover.1500187753.git.christophe.jaillet@wanadoo.fr>
Return-path: <kernel-janitors-owner@vger.kernel.org>
Sender: kernel-janitors-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
List-Id: linux-pm@vger.kernel.org

These 3 patches are all related to error handling in
'thermal_zone_device_register()'. I've splitted them in 3 because each
fixes or cleans something different. They could also be merged together
because they are all related to the same few lines of code.

The 1st one fixes in memory leak.
The 2nd reorders code in the error handling path to have it more logical.
The 3rd simplifies the code.

Not 100% sure, but the 2nd one could also avoid an OOPS because we
try to unregister something that has never been registered.

Christophe JAILLET (3):
  thermal: core: Fix a memory leak in 'thermal_zone_device_register()'
    error handling path
  thermal: core: Reorder 'thermal_zone_device_register()' error handling
    code
  thermal: core: Avoid code duplication in
    'thermal_zone_device_register()'

 drivers/thermal/thermal_core.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

-- 
2.11.0

