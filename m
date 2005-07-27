From: Pavel Machek <pavel@ucw.cz>
Subject: Re: sysdev suspend/resume
Date: Wed, 27 Jul 2005 11:07:48 +0200
Message-ID: <20050727090748.GB4270@elf.ucw.cz>
References: <1122356554.5479.4.camel@linux-hp.sh.intel.com>
	<20050726101409.GA1950@openzaurus.ucw.cz>
	<1122454220.7414.3.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============27883032339718516=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1122454220.7414.3.camel@linux-hp.sh.intel.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============27883032339718516==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > The return value of sysdev's suspend/resume methods is ignored, is this
> > > intended (it should not fail?) or just a bug? I'd like to abort the
> > > suspend process if one device fails.
> > 
> > I guess patch would be accepted... but please make sure you test those
> > error paths, and printk name of failing driver.
> It's a challenge to me, so many loops :). Below patch is a little ugly,
> but should cover all error paths.

It is indeed quite ugly. Could we get SYSDEV_RESUME inline function
instead of ugly macro?

> diff -puN drivers/base/sys.c~sysdev drivers/base/sys.c
> --- linux-2.6.13-rc3/drivers/base/sys.c~sysdev	2005-07-27 10:49:52.831538832 +0800
> +++ linux-2.6.13-rc3-root/drivers/base/sys.c	2005-07-27 16:25:49.154312008 +0800
> @@ -288,6 +288,22 @@ void sysdev_shutdown(void)
>  	up(&sysdev_drivers_lock);
>  }
>  
> +#define SYSDEV_RESUME(cls, dev, drv)			\
> +	/* First, call the class-specific one */ 	\
> +	if (cls->resume)				\
> +		cls->resume(dev);			\
> +							\
> +	/* Call auxillary drivers next. */ 		\
> +	list_for_each_entry(drv, &cls->drivers, entry) {\
> +		if (drv->resume) 			\
> +			drv->resume(dev); 		\
> +	}						\
> +							\
> +	/* Call global drivers. */			\
> +	list_for_each_entry(drv, &sysdev_drivers, entry) {\
> +		if (drv->resume)			\
> +			drv->resume(dev);		\
> +	}

Are you sure you are resuming already-resumed devices?

>  /**
>   *	sysdev_suspend - Suspend all system devices.
> @@ -305,38 +321,93 @@ void sysdev_shutdown(void)
>  int sysdev_suspend(pm_message_t state)
>  {
>  	struct sysdev_class * cls;
> +	struct sys_device *sysdev, *err_dev;
> +	struct sysdev_driver *drv, *err_drv;
> +	int	ret;
	~~~~~~~~~~~~
	use space not tab here. I see you got that habit from ACPI,
but it is just wrong.

> +cls_driver:
> +	drv = NULL;
> +	printk(KERN_ERR "Clss suspend failed for %s\n",
			 ~~~~

Mssng vwls.

								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.

--===============27883032339718516==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============27883032339718516==--
