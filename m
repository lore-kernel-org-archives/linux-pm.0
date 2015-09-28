From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH 2/3] Thermal: handle thermal zone device properly during
 system sleep
Date: Mon, 28 Sep 2015 18:48:26 +0100
Message-ID: <20150928174826.GD2823@e104805>
References: <1443332915-13988-1-git-send-email-yu.c.chen@intel.com>
 <20150928142847.GA8796@e104805>
 <36DF59CE26D8EE47B0655C516E9CE64026F22613@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <36DF59CE26D8EE47B0655C516E9CE64026F22613@SHSMSX101.ccr.corp.intel.com>
Sender: stable-owner@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "edubezval@gmail.com" <edubezval@gmail.com>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Sep 28, 2015 at 06:36:33PM +0100, Chen, Yu C wrote:
> Hi, Javi
> 
> > -----Original Message-----
> > From: Javi Merino [mailto:javi.merino@arm.com]
> > Sent: Monday, September 28, 2015 10:29 PM
> > To: Chen, Yu C
> > Cc: linux-pm@vger.kernel.org; edubezval@gmail.com; Zhang, Rui; linux-
> > kernel@vger.kernel.org; stable@vger.kernel.org
> > Subject: Re: [PATCH 2/3] Thermal: handle thermal zone device properly
> > during system sleep
> > 
> > On Sun, Sep 27, 2015 at 06:48:35AM +0100, Chen Yu wrote:
> > > From: Zhang Rui <rui.zhang@intel.com>
> > >
> > >
> > > +	register_pm_notifier(&thermal_pm_nb);
> > 
> > What if register_pm_notifier() fails?  It can't fail now, but that may in the
> > future.  If we fail to register thermal when we can't register the genetlink
> > family, maybe we should also fail to register thermal if we fail to register the
> > pm notifier, don't you think?
> > 
> This pm notifier is mainly used for suspending situation, but it's not so 'critical' 
> to terminate the initialization of thermal core if it failed, IMO. 

In that case, just print a warning.

Cheers,
Javi

> Hi, Rui, what do you think? Thx
> 
> Best Regards,
> Yu
