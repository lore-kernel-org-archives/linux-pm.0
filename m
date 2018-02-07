From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v5 1/4] cpu_pm: add syscore_suspend error handling
Date: Wed, 7 Feb 2018 14:01:56 -0800
Message-ID: <20180207220155.GA106856@ban.mtv.corp.google.com>
References: <20180207014117.62611-1-dbasehore@chromium.org>
 <20180207014117.62611-2-dbasehore@chromium.org>
 <04ebd1d9-b45b-df87-d59e-1a3df97f3371@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <04ebd1d9-b45b-df87-d59e-1a3df97f3371@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Derek Basehore <dbasehore@chromium.org>, linux-kernel@vger.kernel.org, Soby.Mathew@arm.com, sudeep.holla@arm.com, devicetree@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, tglx@linutronix.de
List-Id: linux-pm@vger.kernel.org

Hi Marc,

On Wed, Feb 07, 2018 at 08:57:27AM +0000, Marc Zyngier wrote:
> On 07/02/18 01:41, Derek Basehore wrote:
> > If cpu_cluster_pm_enter() fails, cpu_pm_exit() should be called. This
> > will put the CPU in the correct state to resume from the failure.
> > 
> > Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> > ---
> >  kernel/cpu_pm.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
> > index 67b02e138a47..03bcc0751a51 100644
> > --- a/kernel/cpu_pm.c
> > +++ b/kernel/cpu_pm.c
> > @@ -186,6 +186,9 @@ static int cpu_pm_suspend(void)
> >  		return ret;
> >  
> >  	ret = cpu_cluster_pm_enter();
> > +	if (ret)
> > +		cpu_pm_exit();
> > +
> >  	return ret;
> >  }
> >  
> > 
> 
> It is unclear to me why we need this patch as part of the ITS series. I
> probably fixes something for you, but I don't see the connection with
> the other patches.

Ths bug was noticed (by inspection) along with earlier versions of this
series, when Derek was still adding new cpu_pm callbacks, and new
failure modes within the existing callbacks. It's a proper fix to my
knowledge, but I believe it no longer has any particular relevance to
this series, since we're not really touching cpu_pm in this series any
more.

Brian
