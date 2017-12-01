From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / runtime: Drop children check from __pm_runtime_set_status()
Date: Fri, 1 Dec 2017 10:22:18 +0100
Message-ID: <CAPDyKFr8D4jL2vwO5tdBJnNVP=DoAD6H_K=4SQbu7rFAZFd3Xg@mail.gmail.com>
References: <1713438.irjm9MTSvo@aspire.rjw.lan> <CAMuHMdV4LV2Uzh2oGdaPiS4W4dfsZ-pn3rGcJNiZLStfo39How@mail.gmail.com>
 <TY1PR06MB09928D43D4E5E5752A6A604ED83A0@TY1PR06MB0992.apcprd06.prod.outlook.com>
 <CAPDyKFoF0WMSTuK4AAyDzerpVpnfEq=Hn1n9kDJM0fYMkFL_wA@mail.gmail.com>
 <TY1PR06MB09924E4F66C6FCF131EE71CFD83B0@TY1PR06MB0992.apcprd06.prod.outlook.com>
 <CAPDyKFoG2-mVGDtzPyg2FDVbXnsWGy543craKqeBVE_awKpf8Q@mail.gmail.com>
 <CAMuHMdViD3vqzits=th52+01d5y3p5iwbAg0jbUBcoGvYfULuA@mail.gmail.com>
 <CAPDyKFpRrQr3LRXH_CoLSYe2a=2PnUqvuNWUYSuh0wm+rBJ0dw@mail.gmail.com> <TY1PR06MB09928B145D35E52444F8D462D8380@TY1PR06MB0992.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:40742 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751236AbdLAJWU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Dec 2017 04:22:20 -0500
Received: by mail-io0-f169.google.com with SMTP id d21so10564440ioe.7
        for <linux-pm@vger.kernel.org>; Fri, 01 Dec 2017 01:22:20 -0800 (PST)
In-Reply-To: <TY1PR06MB09928B145D35E52444F8D462D8380@TY1PR06MB0992.apcprd06.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, USB list <linux-usb@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>

+ Kishon

On 30 November 2017 at 13:51, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Hi,
>
>> From: Ulf Hansson, Sent: Wednesday, November 29, 2017 6:59 PM
>>
>> On 29 November 2017 at 10:43, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> > Hi Ulf,
> <snip>
>> Okay, so the problem remains no matter which solution for wakeup you
>> pick in genpd.
>
> Yes. Today I could reproduce this issue without usb host driver.
> - The renesas_usb3 usb peripheral driver has generic phy handling.
>   (The peripheral driver uses different generic phy driver (phy-rcar-gen3-usb3.c) though.)
>  --> If I used the current renesas_usb3 (this means doesn't call phy_power_{on,off}(),
>      the issue didn't happen.
>  --> If I added phy_power_{on,off}() calling, the issue happened.
>   --> So, I'm thinking the APIs are related to the issue.

Yes.

>
> - The generic phy APIs are in drivers/phy/phy-core.c.
>  --> The phy-rcar-gen3-usb[23] drivers call only pm_runtime_enable() before devm_phy_create().
>   --> The phy-core will call pm_runtime_{get_sync,put}() in phy_{init,exit,power_{on,off}}.
>    --> So, IIUC, both devices of phy-<dev_name>.<id> and <dev_name> will be handled by runtime PM APIs.
>  --> The runtime PM implementation of phy-core seems good to me. But...?


I have digested the information that you and Geert provided, thanks!

So, my conclusions so far is:

The phy core is using runtime PM reference counting at
phy_power_on|off(). Although it does that on the phy core device,
which is a child device of the phy provider device.

Because phy_power_off() is called during system suspend from phy
consumer drivers like usb, the phy core device (child) and the phy
provider device (parent) will never become runtime suspended (because
the PM core has invoked pm_runtime_get_no_resume() for all device in
the device prepare phase).

Then, when genpd calls pm_runtime_force_suspend() at the suspend noirq
phase for the phy provider device, the call to
pm_runtime_set_suspended() in there, triggers the earlier error
message, which is because the child (phy core device) is still runtime
resumed.

>
>> Then this seems to point to that the driver may be misbehaving in some
>> way. I can help to check what is going on.
>
> I guess so. But, I don't find yet...

I think the below patch will help, although I am not sure if that is
sufficient as a long term fix.

Can you please try and see if it solves the problems?

From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 1 Dec 2017 09:07:54 +0100
Subject: [PATCH] phy: core: Move runtime PM reference counting to be done on
 the parent

This is temporary hack, do not merge!

The runtime PM deployment in the phy core is a bit unnecessary complicated,
due to enabling runtime PM for the phy device. Moreover it causes problems
for parent devices (phy providers) when dealing with system wide PM.

Therefore, move the runtime PM reference counting to be done on the phy's
parent device and drop to enable runtime PM for the phy device altogether.
This simplifies for the phy provider driver, to deal with system wide PM,
in case it also cares about keeping the runtime PM status of the device in
sync with the state of the HW.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/phy/phy-core.c | 35 +++++++++--------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index b4964b0..837e50d 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -217,15 +217,12 @@ EXPORT_SYMBOL_GPL(phy_pm_runtime_forbid);

 int phy_init(struct phy *phy)
 {
-       int ret;
+       int ret = 0;

        if (!phy)
                return 0;

-       ret = phy_pm_runtime_get_sync(phy);
-       if (ret < 0 && ret != -ENOTSUPP)
-               return ret;
-       ret = 0; /* Override possible ret == -ENOTSUPP */
+       pm_runtime_get_sync(phy->dev.parent);

        mutex_lock(&phy->mutex);
        if (phy->init_count == 0 && phy->ops->init) {
@@ -239,22 +236,19 @@ int phy_init(struct phy *phy)

 out:
        mutex_unlock(&phy->mutex);
-       phy_pm_runtime_put(phy);
+       pm_runtime_put(phy->dev.parent);
        return ret;
 }
 EXPORT_SYMBOL_GPL(phy_init);

 int phy_exit(struct phy *phy)
 {
-       int ret;
+       int ret = 0;

        if (!phy)
                return 0;

-       ret = phy_pm_runtime_get_sync(phy);
-       if (ret < 0 && ret != -ENOTSUPP)
-               return ret;
-       ret = 0; /* Override possible ret == -ENOTSUPP */
+       pm_runtime_get_sync(phy->dev.parent);

        mutex_lock(&phy->mutex);
        if (phy->init_count == 1 && phy->ops->exit) {
@@ -268,7 +262,7 @@ int phy_exit(struct phy *phy)

 out:
        mutex_unlock(&phy->mutex);
-       phy_pm_runtime_put(phy);
+       pm_runtime_put(phy->dev.parent);
        return ret;
 }
 EXPORT_SYMBOL_GPL(phy_exit);
@@ -286,11 +280,7 @@ int phy_power_on(struct phy *phy)
                        goto out;
        }

-       ret = phy_pm_runtime_get_sync(phy);
-       if (ret < 0 && ret != -ENOTSUPP)
-               goto err_pm_sync;
-
-       ret = 0; /* Override possible ret == -ENOTSUPP */
+       pm_runtime_get_sync(phy->dev.parent);

        mutex_lock(&phy->mutex);
        if (phy->power_count == 0 && phy->ops->power_on) {
@@ -306,8 +296,7 @@ int phy_power_on(struct phy *phy)

 err_pwr_on:
        mutex_unlock(&phy->mutex);
-       phy_pm_runtime_put_sync(phy);
-err_pm_sync:
+       pm_runtime_put(phy->dev.parent);
        if (phy->pwr)
                regulator_disable(phy->pwr);
 out:
@@ -333,7 +322,7 @@ int phy_power_off(struct phy *phy)
        }
        --phy->power_count;
        mutex_unlock(&phy->mutex);
-       phy_pm_runtime_put(phy);
+       pm_runtime_put(phy->dev.parent);

        if (phy->pwr)
                regulator_disable(phy->pwr);
@@ -774,11 +763,6 @@ struct phy *phy_create(struct device *dev, struct
device_node *node,
        if (ret)
                goto put_dev;

-       if (pm_runtime_enabled(dev)) {
-               pm_runtime_enable(&phy->dev);
-               pm_runtime_no_callbacks(&phy->dev);
-       }
-
        return phy;

 put_dev:
@@ -831,7 +815,6 @@ EXPORT_SYMBOL_GPL(devm_phy_create);
  */
 void phy_destroy(struct phy *phy)
 {
-       pm_runtime_disable(&phy->dev);
        device_unregister(&phy->dev);
 }
 EXPORT_SYMBOL_GPL(phy_destroy);
-- 
2.7.4

Kind regards
Uffe
