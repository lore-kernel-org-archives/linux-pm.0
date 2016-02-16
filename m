From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] PM / OPP: Initialize regulator pointer to an error value
Date: Tue, 16 Feb 2016 10:10:44 +0100
Message-ID: <2628515.OmmYzoeulx@wuerfel>
References: <1455544758-7718-1-git-send-email-jonathanh@nvidia.com> <20160216010059.GH6334@vireshk-i7> <20160216015616.GH18327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:57046 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754705AbcBPJLG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Feb 2016 04:11:06 -0500
In-Reply-To: <20160216015616.GH18327@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linaro-kernel@lists.linaro.org
Cc: Mark Brown <broonie@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>, Stephen Boyd <sboyd@codeaurora.org>

On Tuesday 16 February 2016 01:56:16 Mark Brown wrote:
> On Tue, Feb 16, 2016 at 06:30:59AM +0530, Viresh Kumar wrote:
> 
> > - And so I left the regulator pointer to NULL in OPP core.
> > - But then I realized that its not safe to call many regulator core
> >   APIs with NULL regulator, as those caused the crashes reported by
> >   multiple people now.
> > - clk APIs guarantee that they return early when NULL clk is passed to
> >   them.
> > - Do we need to do the same for regulator core as well ?
> 
> No, NULL is explicitly not something you can substitute in,
> essentially all the users are just not bothering to implement error
> checking and we don't want to encourage that.  The set of use cases
> where we legitimately have optional supplies is very small, much smaller
> than clocks, because it makes the electrical engineering a lot harder.
> 

I must have misinterpreted the idea behind that API as well then.

>From this function definition:

/*
 * Make sure client drivers will still build on systems with no software
 * controllable voltage or current regulators.
 */             
static inline struct regulator *__must_check regulator_get(struct device *dev,
        const char *id)
{       
        /* Nothing except the stubbed out regulator API should be
         * looking at the value except to check if it is an error
         * value. Drivers are free to handle NULL specifically by
         * skipping all regulator API calls, but they don't have to.
         * Drivers which don't, should make sure they properly handle
         * corner cases of the API, such as regulator_get_voltage()
         * returning 0.
         */             
        return NULL;
}

my reading was that the expected behavior in any driver was:

* call regulator_get()
* if IS_ERR(), fail device probe function, never use invalid
  pointer other than PTR_ERR()
* if NULL, and regulator is required, fail probe so we never
  use the regulator
* if NULL, and regulators are optional, continue with the NULL
  value.
* drivers never look into the regulator pointer, and only
  pass it into regulator APIs which can cope with the NULL
  value when CONFIG_REGULATOR is disabled.

That would be similar to what we have for clocks. Which part of
my interpretation is wrong?

	Arnd
