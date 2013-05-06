From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: Fix dev_pm_put_subsys_data() to not call kfree() while holding device power lock
Date: Mon, 06 May 2013 14:07:21 +0200
Message-ID: <1882177.s6zpHZ6crc@vostro.rjw.lan>
References: <1367614010.8452.2.camel@lorien> <20130504125116.GA13770@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130504125116.GA13770@amd.pavel.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Shuah Khan <shuah.kh@samsung.com>, "len.brown@intel.com" <len.brown@intel.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "shuahkhan@gmail.com" <shuahkhan@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Saturday, May 04, 2013 02:51:16 PM Pavel Machek wrote:
> Hi!
> 
> > dev_pm_put_subsys_data() calls kfree() while holding device power lock, when
> > the reference count is 0. Fix it to call kfree() after releasing the lock.
> > 
> > Signed-off-by: Shuah Khan <shuah.kh@samsung.com>
> > ---
> >  drivers/base/power/common.c |    6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> w> diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
> > index 39c3252..da05fe2 100644
> > --- a/drivers/base/power/common.c
> > +++ b/drivers/base/power/common.c
> > @@ -73,13 +73,17 @@ int dev_pm_put_subsys_data(struct device *dev)
> >  
> >  	if (--psd->refcount == 0) {
> >  		dev->power.subsys_data = NULL;
> > -		kfree(psd);
> >  		ret = 1;
> >  	}
> >  
> >   out:
> >  	spin_unlock_irq(&dev->power.lock);
> >  
> > +	if (ret == 1) {
> > +		/* kfree() verifies that its argument is nonzero. */
> > +		kfree(psd);
> > +	}
> > +
> >  	return ret;
> >  }
> 
> Wow, that function is fragile. It returns 0/1/-EINVAL, while being
> documented for 0/1...

Oh, it generally should return 1 for !psd.

> Patch does not look obviously wrong, but maybe 
> 
> @@ -73,13 +73,17 @@ int dev_pm_put_subsys_data(struct device *dev)
>  
>  	if (--psd->refcount == 0) {
>  		dev->power.subsys_data = NULL;
> +		spin_unlock_irq(&dev->power.lock);
> -		kfree(psd);
> - 		ret = 1;
> +		return 1;
>  	}
> 
> Would be cleaner.

What about this:

---
 drivers/base/power/common.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/base/power/common.c
===================================================================
--- linux-pm.orig/drivers/base/power/common.c
+++ linux-pm/drivers/base/power/common.c
@@ -61,24 +61,24 @@ EXPORT_SYMBOL_GPL(dev_pm_get_subsys_data
 int dev_pm_put_subsys_data(struct device *dev)
 {
 	struct pm_subsys_data *psd;
-	int ret = 0;
+	int ret = 1;
 
 	spin_lock_irq(&dev->power.lock);
 
 	psd = dev_to_psd(dev);
-	if (!psd) {
-		ret = -EINVAL;
+	if (!psd)
 		goto out;
-	}
 
 	if (--psd->refcount == 0) {
 		dev->power.subsys_data = NULL;
-		kfree(psd);
-		ret = 1;
+	} else {
+		psd = NULL;
+		ret = 0;
 	}
 
  out:
 	spin_unlock_irq(&dev->power.lock);
+	kfree(psd);
 
 	return ret;
 }


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
