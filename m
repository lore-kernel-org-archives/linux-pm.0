From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH v1 4/7] thermal: introduce the Power Allocator governor
Date: Thu, 26 Feb 2015 17:52:53 +0000
Message-ID: <20150226175253.GA9883@e104805>
References: <1422464438-16761-1-git-send-email-javi.merino@arm.com>
 <1422464438-16761-5-git-send-email-javi.merino@arm.com>
 <20150224182124.GB3448@developer.amazonguestwifi.org>
 <20150225144849.GA2904@e104805>
 <20150225190037.GH2306@developer.amazonguestwifi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41483 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753479AbbBZRw6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 26 Feb 2015 12:52:58 -0500
Content-Disposition: inline
In-Reply-To: <20150225190037.GH2306@developer.amazonguestwifi.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Punit Agrawal <Punit.Agrawal@arm.com>, "broonie@kernel.org" <broonie@kernel.org>, Zhang Rui <rui.zhang@intel.com>

On Wed, Feb 25, 2015 at 07:00:38PM +0000, Eduardo Valentin wrote:
> On Wed, Feb 25, 2015 at 02:48:49PM +0000, Javi Merino wrote:
> > Hi Eduardo,
> > 
> > On Tue, Feb 24, 2015 at 06:21:26PM +0000, Eduardo Valentin wrote:
> > > On Wed, Jan 28, 2015 at 05:00:35PM +0000, Javi Merino wrote:
> > > > +
> > > > +k_d
> > > > +---
> > > > +
> > > > +`k_d` configures the PID loop's derivative term constant.  It's
> > > > +recommended to leave it as the default: 0.
> > > > +
> > > 
> > > I know we are considering K_d = 0. However, ...
> > > 
> > > <yet another big cut>
> > > 
> > > > +	/*
> > > > +	 * Calculate the derivative term
> > > > +	 *
> > > > +	 * We do err - prev_err, so with a positive k_d, a decreasing
> > > > +	 * error (i.e. driving closer to the line) results in less
> > > > +	 * power being applied, slowing down the controller)
> > > > +	 */
> > > > +	d = mul_frac(tz->tzp->k_d, err - params->prev_err);
> > > 
> > > 
> > > ... Shouldn't the above d component consider the rate of changes over time of the error?
> > > 
> > > I would expect you should do:
> > > d = k_d * (dE / dt)
> > > 
> > > or
> > > 
> > > d = K_d * ((err - params->prev_err) / sampling_period)
> > > 
> > > in plain C:
> > > 
> > > +	d = mul_frac(tz->tzp->k_d, err - params->prev_err);
> > > +	d /= tz->passive_polling; /* might require fixed point division */
> > 
> > Could do.  To be honest, both k_d and passive_polling are constants so
> 
> Yes, I agree that they are constants. But if you deploy the thermal zone
> with different sampling period on different devices, then the behavior
> will change.
> 
> > I don't think you get anything by doing this other than the added
> > complexity of the fixed point division.  As you said, the default k_d
> > is 0, so I'm not strongly against it.
> 
> OK. Then I would prefer to add the division, as it makes the code aligned
> to the concept.

Fair enough, I've added it to the code.  We will send a v2 later today
if all regressions pass.

Cheers,
Javi
