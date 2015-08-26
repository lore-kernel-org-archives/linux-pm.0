From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] thermal: cpu_cooling: Remove usage of devm functions
Date: Wed, 26 Aug 2015 18:44:02 +0530
Message-ID: <20150826131402.GN8784@linux>
References: <20150820161402.GA4951@localhost>
 <20150826124736.GA10956@e104805>
 <20150826125158.GM8784@linux>
 <20150826130921.GB10956@e104805>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150826130921.GB10956@e104805>
Sender: linux-kernel-owner@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: Vaishali Thakkar <vthakkar1994@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 26-08-15, 14:09, Javi Merino wrote:
> On Wed, Aug 26, 2015 at 01:51:58PM +0100, Viresh Kumar wrote:
> > On 26-08-15, 13:47, Javi Merino wrote:
> > > I missed this because I wasn't CCed :(  Thankfully, I'll be in
> > > MAINTAINERS for this soon.
> > 
> > Yeah, I need to resend that patch soon :)
> > 
> > > > -		devm_kfree(&cdev->device, load_cpu);
> > > 
> > > This introduces a memory leak.  Keep the kfree() here, you can't drop
> > > it.  Cheers,
> > > Javi
> > > 
> > > > -	}
> > > > -
> > > >  	*power = static_power + dynamic_power;
> > > >  	return 0;

So, the change I suggested on V1 removed this as well :) and Vaishali
missed it completely.

> > > > +
> > > > +free:
> > > > +	kfree(load_cpu);
> > 
> > Wouldn't this make that work ?
> 
> Nope, you're not reaching that code path from there.  Removing the
> "return 0" would work, but I don't like it, since we would be calling
> kfree() all the time, even when the trace is not enabled.  I'd rather
> leave the kfree() where it is.

Hmm..

-- 
viresh
