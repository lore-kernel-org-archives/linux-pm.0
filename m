From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v3] i2c: let I2C masters ignore their children for PM
Date: Tue, 12 Apr 2016 09:57:35 +0200
Message-ID: <1460447855-18050-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:35094 "EHLO
	mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932216AbcDLH5n (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Apr 2016 03:57:43 -0400
Received: by mail-lf0-f53.google.com with SMTP id c126so13695458lfb.2
        for <linux-pm@vger.kernel.org>; Tue, 12 Apr 2016 00:57:42 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

When using a certain I2C device with runtime PM enabled on
a certain I2C bus adaper the following happens:

struct amba_device *foo
   \
   struct i2c_adapter *bar
      \
      struct i2c_client *baz

The AMBA device foo has its device PM struct set to ignore
children with pm_suspend_ignore_children(&foo->dev, true).
This makes runtime PM work just fine locally in the driver:
the fact that devices on the bus are suspended or resumed
individually does not affect its operation, and the hardware
does not power up unless transferring messages.

However this child ignorance property is not inherited into
the struct i2c_adapter *bar.

On system suspend things will work fine.

On system resume the following annoying phenomenon occurs:

- In the pm_runtime_force_resume() path of
  struct i2c_client *baz, pm_runtime_set_active(&baz->dev); is
  eventually called.

- This becomes __pm_runtime_set_status(&baz->dev, RPM_ACTIVE);

- __pm_runtime_set_status() detects that RPM state is changed,
  and checks whether the parent is:
  not active (RPM_ACTIVE) and not ignoring its children
  If this happens it concludes something is wrong, because
  a parent that is not ignoring its children must be active
  before any children activate.

- Since the struct i2c_adapter *bar does not ignore
  its children, the PM core thinks that it must indeed go
  online before its children, the check bails out with
  -EBUSY, i.e. the i2c_client *baz thinks it can't work
  because it's parent is not online, and it respects its
  parent.

- In the driver the .resume() callback returns -EBUSY from
  the runtime_force_resume() call as per above. This leaves
  the device in a suspended state, leading to bad behaviour
  later when the device is used. The following debug
  print is made with an extra printg patch but illustrates
  the problem:

[   17.040832] bh1780 2-0029: parent (i2c-2) is not active
               parent->power.ignore_children = 0
[   17.040832] bh1780 2-0029: pm_runtime_force_resume:
               pm_runtime_set_active() failed (-16)
[   17.040863] dpm_run_callback():
               pm_runtime_force_resume+0x0/0x88 returns -16
[   17.040863] PM: Device 2-0029 failed to resume: error -16

Fix this by letting all struct i2c_adapter:s ignore their
children: i2c children have no business doing keeping
their parents awake: they are completely autonomous
devices that just use their parent to talk, a usecase
which must be power managed in the host on a per-message
basis.

Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Move the pm_suspend_ignore_children() call before the
  pm_runtime_enable() call.
ChangeLog v1->v2:
- Change subject from
  "let I2C masters inherit suspend child ignorance"
  to
  "let I2C masters ignore their children for PM"
- Use the big hammer and do the sensible thing:
  mark all i2c adapters as ignoring their children
  when it comes to power management.
---
 drivers/i2c/i2c-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 0f2f8484e8ec..7083785a232c 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1565,6 +1565,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	dev_dbg(&adap->dev, "adapter [%s] registered\n", adap->name);
 
 	pm_runtime_no_callbacks(&adap->dev);
+	pm_suspend_ignore_children(&adap->dev, true);
 	pm_runtime_enable(&adap->dev);
 
 #ifdef CONFIG_I2C_COMPAT
-- 
2.4.3

