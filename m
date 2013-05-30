From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: [PATCH] PM: Add pm_ops_ptr() macro
Date: Thu, 30 May 2013 15:54:20 +0200
Message-ID: <4119506.fLP8mVnrTk@vostro.rjw.lan>
References: <000201ce453f$5ce4fc90$16aef5b0$@samsung.com> <20130503092311.GA13832@amd.pavel.ucw.cz> <20130530105644.GA3595@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130530105644.GA3595@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Len Brown' <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, 'Andrew Morton' <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Thursday, May 30, 2013 12:56:45 PM Wolfram Sang wrote:
> On Fri, May 03, 2013 at 11:23:11AM +0200, Pavel Machek wrote:
> > Hi!
> > 
> > > > Add pm_ops_ptr() macro that allows the .pm entry in the driver structures
> > > > to be assigned without having an #define xxx NULL for the case that PM is
> > > > not enabled.
> > > > 
> > > > Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > > 
> > > I've queued this up as v3.11 material.
> > 
> > > > --- a/drivers/i2c/busses/i2c-s3c2410.c
> > > > +++ b/drivers/i2c/busses/i2c-s3c2410.c
> > > > @@ -1218,7 +1218,6 @@ static int s3c24xx_i2c_resume(struct device *dev)
> > > >  }
> > > >  #endif
> > > >  
> > > > -#ifdef CONFIG_PM
> > > >  static const struct dev_pm_ops s3c24xx_i2c_dev_pm_ops = {
> > > >  #ifdef CONFIG_PM_SLEEP
> > > >  	.suspend_noirq = s3c24xx_i2c_suspend_noirq,
> > > > @@ -1226,11 +1225,6 @@ static const struct dev_pm_ops s3c24xx_i2c_dev_pm_ops = {
> > > >  #endif
> > > >  };
> > > >  
> > > > -#define S3C24XX_DEV_PM_OPS (&s3c24xx_i2c_dev_pm_ops)
> > > > -#else
> > > > -#define S3C24XX_DEV_PM_OPS NULL
> > > > -#endif
> > > > -
> > > >  /* device driver for platform bus bits */
> > 
> > Will not this enlarge .data by sizeof(struct dev_pm_ops)?
> 
> Same question here. Is it the preferred way now to use this new macro
> although having the cost of having an empty dev_pm_ops?

No, it isn't, but if someone wants to use it, I don't really care that much.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
