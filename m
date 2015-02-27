From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH v2 4/7] thermal: introduce the Power Allocator governor
Date: Fri, 27 Feb 2015 16:12:24 +0000
Message-ID: <20150227161224.GE2877@e104805>
References: <1424977233-15965-1-git-send-email-javi.merino@arm.com>
 <1424977233-15965-5-git-send-email-javi.merino@arm.com>
 <20150226203615.GB25495@developer.amazonguestwifi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150226203615.GB25495@developer.amazonguestwifi.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: "rui.zhang@intel.com" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Punit Agrawal <Punit.Agrawal@arm.com>, "broonie@kernel.org" <broonie@kernel.org>, "tixy@linaro.org" <tixy@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 26, 2015 at 08:36:16PM +0000, Eduardo Valentin wrote:
> Javi,
> 
> Replying in v2.
> 
> On Thu, Feb 26, 2015 at 07:00:30PM +0000, Javi Merino wrote:
> 
> <big cut>
> 
> > +
> > +/**
> > + * divvy_up_power() - divvy the allocated power between the actors
> > + * @req_power:	each actor's requested power
> > + * @max_power:	each actor's maximum available power
> > + * @num_actors:	size of the @req_power, @max_power and @granted_power's array
> > + * @total_req_power: sum of @req_power
> > + * @power_range:	total allocated power
> > + * @granted_power:	output array: each actor's granted power
> > + *
> > + * This function divides the total allocated power (@power_range)
> > + * fairly between the actors.  It first tries to give each actor a
> > + * share of the @power_range according to how much power it requested
> > + * compared to the rest of the actors.  For example, if only one actor
> > + * requests power, then it receives all the @power_range.  If
> > + * three actors each requests 1mW, each receives a third of the
> > + * @power_range.
> > + *
> > + * If any actor received more than their maximum power, then that
> > + * surplus is re-divvied among the actors based on how far they are
> > + * from their respective maximums.
> > + *
> > + * Granted power for each actor is written to @granted_power, which
> > + * should've been allocated by the calling function.
> > + */
> > +static void divvy_up_power(u32 *req_power, u32 *max_power, int num_actors,
> > +			   u32 total_req_power, u32 power_range,
> > +			   u32 *granted_power)
> > +{
> > +	u32 extra_power, capped_extra_power, extra_actor_power[num_actors];
> 
> Just now I noticed this variable-size array. I know the number of actors
> are constant, and in average it should be less than 10 in magnitude, but
> I don't believe variable-sized arrays are a good practice in kernel.
> 
> Even though I don't see this one as a treat, can we avoid it?

I can turn it into a devm_kcalloc() and merge it with the other
three allocations that happen earlier.  I'll do that for v3.

Cheers,
Javi
