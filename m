From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal/intel_powerclamp: fix __percpu declaration of
 worker_data
Date: Wed, 30 Jan 2019 21:42:18 +0800
Message-ID: <1548855738.2161.5.camel@intel.com>
References: <20190119161523.87999-1-luc.vanoostenryck@gmail.com>
         <20190130095917.7uxdxrjvtaeydcol@pathway.suse.cz>
         <1548855476.2161.2.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548855476.2161.2.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 三, 2019-01-30 at 21:37 +0800, Zhang Rui wrote:
> On 三, 2019-01-30 at 10:59 +0100, Petr Mladek wrote:
> > 
> > On Sat 2019-01-19 17:15:23, Luc Van Oostenryck wrote:
> > > 
> > > 
> > > This variable is declared as:
> > > 	static struct powerclamp_worker_data * __percpu worker_data;
> > > In other words, a percpu pointer to struct ...
> > > 
> > > But this variable not used like so but as a pointer to a percpu
> > > struct powerclamp_worker_data.
> > > 
> > > So fix the declaration as:
> > > 	static struct powerclamp_worker_data __percpu *worker_data;
> > > 
> > > This also quiets Sparse's warnings from __verify_pcpu_ptr(),
> > > like:
> > >   494:49: warning: incorrect type in initializer (different
> > > address
> > > spaces)
> > >   494:49:    expected void const [noderef] <asn:3> *__vpp_verify
> > >   494:49:    got struct powerclamp_worker_data *
> > > 
> > > Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> > > ---
> > >  drivers/thermal/intel/intel_powerclamp.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/thermal/intel/intel_powerclamp.c
> > > b/drivers/thermal/intel/intel_powerclamp.c
> > > index 7571f7c2e..c7cba20bd 100644
> > > --- a/drivers/thermal/intel/intel_powerclamp.c
> > > +++ b/drivers/thermal/intel/intel_powerclamp.c
> > > @@ -101,7 +101,7 @@ struct powerclamp_worker_data {
> > >  	bool clamping;
> > >  };
> > >  
> > > -static struct powerclamp_worker_data * __percpu worker_data;
> > > +static struct powerclamp_worker_data __percpu * worker_data;
> > Makes perfect sense. I wonder why I wrote it in the wrong order.
> > 
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> > 
> applied and queued for next -rc.
> 
well, just with a minor change to get rid of checkpatch warning.

ERROR: "foo * bar" should be "foo *bar"
#121: FILE: drivers/thermal/intel/intel_powerclamp.c:104:
+static struct powerclamp_worker_data __percpu * worker_data;

total: 1 errors, 0 warnings, 8 lines checked

thanks,
rui
> thanks,
> rui
> 
> > 
> > Best Regards,
> > Petr
