From: gaurav jindal <gauravjindal1104@gmail.com>
Subject: Re: [PATCH]cpuidle: preventive check in cpuidle_select against crash
Date: Thu, 4 Jan 2018 23:39:07 +0530
Message-ID: <20180104180907.GA4305@mail.google.com>
References: <20171226072626.GA4153@gaurav.jindal>
 <CAJZ5v0jH=DqUSFT8yAt+M=_N0Qn-ou0dPmqK7DwG5S22jZ1R+A@mail.gmail.com>
 <20171229184522.GA3423@gaurav.jindal>
 <2321585.UHgzd7LiPO@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34111 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750959AbeADSJM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jan 2018 13:09:12 -0500
Content-Disposition: inline
In-Reply-To: <2321585.UHgzd7LiPO@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Jan 03, 2018 at 12:16:26PM +0100, Rafael J. Wysocki wrote:
> On Friday, December 29, 2017 7:45:22 PM CET gaurav jindal wrote:
> > On Wed, Dec 27, 2017 at 03:30:02AM +0100, Rafael J. Wysocki wrote:
> > > On Wed, Dec 27, 2017 at 2:57 AM, gaurav jindal
> > > <gauravjindal1104@gmail.com> wrote:
> > > > On Wed, Dec 27, 2017 at 01:42:58AM +0100, Rafael J. Wysocki wrote:
> > > >> On Tue, Dec 26, 2017 at 8:26 AM, gaurav jindal
> > > >> <gauravjindal1104@gmail.com> wrote:
> > > >> > When selecting the idle state using cpuidle_select, there is no
> > > >> > check on cpuidle_curr_governor. In cpuidle_switch_governor,
> > > >> > cpuidle_currr_governor can be set to NULL to specify "disabled".
> > > >>
> > > >> How exactly?
> > > >
> > > > In cpuidle_switch_governor:
> > > >
> > > > /**
> > > >  * cpuidle_switch_governor - changes the governor
> > > >  * @gov: the new target governor
> > > >  *
> > > >  * NOTE: "gov" can be NULL to specify disabled
> > > >  * Must be called with cpuidle_lock acquired.
> > > >  */
> > > > int cpuidle_switch_governor(struct cpuidle_governor *gov)
> > > > {
> > > >         struct cpuidle_device *dev;
> > > >
> > > >         if (gov == cpuidle_curr_governor)
> > > >                 return 0;
> > > >
> > > >         cpuidle_uninstall_idle_handler();
> > > >
> > > >         if (cpuidle_curr_governor) {
> > > >                 list_for_each_entry(dev, &cpuidle_detected_devices, device_list)
> > > >                         cpuidle_disable_device(dev);
> > > >         }
> > > >
> > > >         cpuidle_curr_governor = gov;
> > > >
> > > > This allows to set the cpuidle_switch_governor as NULL. Although there is no
> > > > current code flow leading here, but it has a potential for bug in future. So
> > > > may be better to have prevention.
> > > 
> > > Or maybe not.
> > > 
> > > Why don't you make cpuidle_switch_governor() check the argument
> > > against NULL instead?
> > 
> > If we check gov (argument passed in  cpuidle_switch_governor())against
> > NULL in cpuidle_switch_governor, can be a problem in a case where it 
> > is called as
> > cpuidle_switch_governor(NULL);
> > 
> > If cpuidle_curr_governor is not NULL, first the device is disabled.
> > 
> > if (cpuidle_curr_governor) {
> > 	list_for_each_entry(dev, &cpuidle_detected_devices, device_list)
> > 	cpuidle_disable_device(dev);
> > }
> > 
> > after this cpuidle_curr_governor is set to gov, which is NULL in this case.
> > 
> > cpuidle_curr_governor = gov;
> > /* if is not updated by inserting a check, it will have an oudated value*/
> > 
> > Now, if gov is not NULL (which it is in this case), cpuidle device is enabled
> > 
> > if (gov) {
> > 	list_for_each_entry(dev, &cpuidle_detected_devices, device_list)
> > 	cpuidle_enable_device(dev);
> > 	cpuidle_install_idle_handler();
> > 	printk(KERN_INFO "cpuidle: using governor %s\n", gov->name);
> > }
> > If we check for gov against NULL in this function, it will produce
> > dangling pointers and resource leaks.
> 
> I didn't recommend you to introduce bugs.
> 
I did not intend to do so. I am really sorry it got expressed in that way :(.
> Just return -EINVAL if gov is NULL before checking if gov is equal to
> cpuidle_curr_governor.
> 
Okay 
> Thanks,
> Rafael
> 

this patch checks if the new governor is NULL before updating the
cupidle_curr_governor.

Signed-off-by: gaurav jindal<gauravjindal1104@gmail.com>

---

diff --git a/drivers/cpuidle/governor.c b/drivers/cpuidle/governor.c
index 4e78263..5d359af 100644
--- a/drivers/cpuidle/governor.c
+++ b/drivers/cpuidle/governor.c
@@ -36,14 +36,15 @@ static struct cpuidle_governor * __cpuidle_find_governor(const char *str)
 /**
  * cpuidle_switch_governor - changes the governor
  * @gov: the new target governor
- *
- * NOTE: "gov" can be NULL to specify disabled
  * Must be called with cpuidle_lock acquired.
  */
 int cpuidle_switch_governor(struct cpuidle_governor *gov)
 {
 	struct cpuidle_device *dev;
 
+	if (!gov)
+		return -EINVAL;
+
 	if (gov == cpuidle_curr_governor)
 		return 0;
