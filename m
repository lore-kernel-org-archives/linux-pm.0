From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH v1 4/7] thermal: introduce the Power Allocator governor
Date: Wed, 25 Feb 2015 14:48:49 +0000
Message-ID: <20150225144849.GA2904@e104805>
References: <1422464438-16761-1-git-send-email-javi.merino@arm.com>
 <1422464438-16761-5-git-send-email-javi.merino@arm.com>
 <20150224182124.GB3448@developer.amazonguestwifi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150224182124.GB3448@developer.amazonguestwifi.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Punit Agrawal <Punit.Agrawal@arm.com>, "broonie@kernel.org" <broonie@kernel.org>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi Eduardo,

On Tue, Feb 24, 2015 at 06:21:26PM +0000, Eduardo Valentin wrote:
> On Wed, Jan 28, 2015 at 05:00:35PM +0000, Javi Merino wrote:
> > +
> > +k_d
> > +---
> > +
> > +`k_d` configures the PID loop's derivative term constant.  It's
> > +recommended to leave it as the default: 0.
> > +
> 
> I know we are considering K_d = 0. However, ...
> 
> <yet another big cut>
> 
> > +	/*
> > +	 * Calculate the derivative term
> > +	 *
> > +	 * We do err - prev_err, so with a positive k_d, a decreasing
> > +	 * error (i.e. driving closer to the line) results in less
> > +	 * power being applied, slowing down the controller)
> > +	 */
> > +	d = mul_frac(tz->tzp->k_d, err - params->prev_err);
> 
> 
> ... Shouldn't the above d component consider the rate of changes over time of the error?
> 
> I would expect you should do:
> d = k_d * (dE / dt)
> 
> or
> 
> d = K_d * ((err - params->prev_err) / sampling_period)
> 
> in plain C:
> 
> +	d = mul_frac(tz->tzp->k_d, err - params->prev_err);
> +	d /= tz->passive_polling; /* might require fixed point division */

Could do.  To be honest, both k_d and passive_polling are constants so
I don't think you get anything by doing this other than the added
complexity of the fixed point division.  As you said, the default k_d
is 0, so I'm not strongly against it.

Cheers,
Javi
