From: gaurav jindal <gauravjindal1104@gmail.com>
Subject: Re: [PATCH] drivers: cpuidle: Fix checkpatch error and warnings
Date: Fri, 8 Sep 2017 19:06:58 +0530
Message-ID: <20170908133658.GA7727@kernel>
References: <20170907102325.GA6427@kernel>
 <1504780406.7546.19.camel@perches.com>
 <20170907124010.GB6427@kernel>
 <CAJZ5v0jUcC7e3R_fRrPuKCaCmi3ZQwKWBJTmC7zN09QaErQXrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jUcC7e3R_fRrPuKCaCmi3ZQwKWBJTmC7zN09QaErQXrw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Joe Perches <joe@perches.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Todd Poynor <toddpoynor@google.com>
List-Id: linux-pm@vger.kernel.org

This patch fixes the below checkpatch errors and warnings in
drivers/cpuidle/cpuidle.c


WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
#343: FILE: drivers/cpuidle/cpuidle.c:343:
+EXPORT_SYMBOL_GPL(cpuidle_pause_and_lock);

WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
#354: FILE: drivers/cpuidle/cpuidle.c:354:
+EXPORT_SYMBOL_GPL(cpuidle_resume_and_unlock);

ERROR: do not use assignment in if condition
#402: FILE: drivers/cpuidle/cpuidle.c:402:
+	if (cpuidle_curr_governor->enable &&

WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
#419: FILE: drivers/cpuidle/cpuidle.c:419:
+EXPORT_SYMBOL_GPL(cpuidle_enable_device);

WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
#447: FILE: drivers/cpuidle/cpuidle.c:447:
+EXPORT_SYMBOL_GPL(cpuidle_disable_device);

WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
#537: FILE: drivers/cpuidle/cpuidle.c:537:
+EXPORT_SYMBOL_GPL(cpuidle_register_device);

WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
#561: FILE: drivers/cpuidle/cpuidle.c:561:
+EXPORT_SYMBOL_GPL(cpuidle_unregister_device);

Signed-off-by: gaurav jindal<gauravjindal1104@gmail.com>

---

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 60bb64f..f2be6dd 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -339,7 +339,6 @@ void cpuidle_pause_and_lock(void)
 	mutex_lock(&cpuidle_lock);
 	cpuidle_uninstall_idle_handler();
 }
-
 EXPORT_SYMBOL_GPL(cpuidle_pause_and_lock);

 /**
@@ -350,7 +349,6 @@ void cpuidle_resume_and_unlock(void)
 	cpuidle_install_idle_handler();
 	mutex_unlock(&cpuidle_lock);
 }
-
 EXPORT_SYMBOL_GPL(cpuidle_resume_and_unlock);

 /* Currently used in suspend/resume path to suspend cpuidle */
@@ -399,9 +397,11 @@ int cpuidle_enable_device(struct cpuidle_device *dev)
 	if (ret)
 		return ret;

-	if (cpuidle_curr_governor->enable &&
-	    (ret = cpuidle_curr_governor->enable(drv, dev)))
-		goto fail_sysfs;
+	if (cpuidle_curr_governor->enable) {
+		ret = cpuidle_curr_governor->enable(drv, dev);
+		if (ret)
+			goto fail_sysfs;
+	}

 	smp_wmb();

@@ -415,7 +415,6 @@ int cpuidle_enable_device(struct cpuidle_device *dev)

 	return ret;
 }
-
 EXPORT_SYMBOL_GPL(cpuidle_enable_device);

@@ -443,7 +442,6 @@ void cpuidle_disable_device(struct cpuidle_device *dev)
 	cpuidle_remove_device_sysfs(dev);
 	enabled_devices--;
 }
-
 EXPORT_SYMBOL_GPL(cpuidle_disable_device);

static void __cpuidle_unregister_device(struct cpuidle_device *dev)
@@ -533,7 +531,6 @@ int cpuidle_register_device(struct cpuidle_device *dev)
 	__cpuidle_unregister_device(dev);
 	goto out_unlock;
 }
-
 EXPORT_SYMBOL_GPL(cpuidle_register_device);

/**
@@ -557,7 +554,6 @@ void cpuidle_unregister_device(struct cpuidle_device *dev)

 	cpuidle_resume_and_unlock();
 }
-
 EXPORT_SYMBOL_GPL(cpuidle_unregister_device);

 /**
On Fri, Sep 08, 2017 at 01:18:49AM +0200, Rafael J. Wysocki wrote:
> On Thu, Sep 7, 2017 at 2:40 PM, gaurav jindal
> <gauravjindal1104@gmail.com> wrote:
> > this patch fixes the below checkpatch errors and warnings in
> > drivers/cpuidle/cpuidle.c
> >
> > WARNING: line over 80 characters
> > #311: FILE: drivers/cpuidle/cpuidle.c:311:
> > +               /* Make sure all changes finished before we switch to new idle */
> >
> > WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> > #343: FILE: drivers/cpuidle/cpuidle.c:343:
> > +EXPORT_SYMBOL_GPL(cpuidle_pause_and_lock);
> >
> > WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> > #354: FILE: drivers/cpuidle/cpuidle.c:354:
> > +EXPORT_SYMBOL_GPL(cpuidle_resume_and_unlock);
> >
> > ERROR: do not use assignment in if condition
> > #402: FILE: drivers/cpuidle/cpuidle.c:402:
> > +       if (cpuidle_curr_governor->enable &&
> >
> > WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> > #419: FILE: drivers/cpuidle/cpuidle.c:419:
> > +EXPORT_SYMBOL_GPL(cpuidle_enable_device);
> >
> > WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> > #447: FILE: drivers/cpuidle/cpuidle.c:447:
> > +EXPORT_SYMBOL_GPL(cpuidle_disable_device);
> >
> > WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> > #537: FILE: drivers/cpuidle/cpuidle.c:537:
> > +EXPORT_SYMBOL_GPL(cpuidle_register_device);
> >
> > WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> > #561: FILE: drivers/cpuidle/cpuidle.c:561:
> > +EXPORT_SYMBOL_GPL(cpuidle_unregister_device);
> >
> > Signed-off-by:gaurav jindal<gauravjindal1104@gmail.com>
> >
> > ---
> >
> > diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> > index 60bb64f..a42148e 100644
> > --- a/drivers/cpuidle/cpuidle.c
> > +++ b/drivers/cpuidle/cpuidle.c
> > @@ -308,7 +308,10 @@ void cpuidle_reflect(struct cpuidle_device *dev, int index)
> >  void cpuidle_install_idle_handler(void)
> >  {
> >         if (enabled_devices) {
> > -               /* Make sure all changes finished before we switch to new idle */
> > +               /*
> > +                * Make sure all changes finished before we switch to
> > +                * new idle
> > +                */
> >                 smp_wmb();
> >                 initialized = 1;
> >         }
> 
> Don't do this.
> 
> The rest is fine by me.
