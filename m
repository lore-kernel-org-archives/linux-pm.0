From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] PM / OPP: Initialize regulator pointer to an error value
Date: Tue, 16 Feb 2016 16:12:39 +0100
Message-ID: <10492578.n5ZTGbvbYE@wuerfel>
References: <1455544758-7718-1-git-send-email-jonathanh@nvidia.com> <2628515.OmmYzoeulx@wuerfel> <20160216131108.GK18327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:60967 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932640AbcBPPNC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Feb 2016 10:13:02 -0500
In-Reply-To: <20160216131108.GK18327@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linaro-kernel@lists.linaro.org
Cc: Mark Brown <broonie@kernel.org>, Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>, Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>

On Tuesday 16 February 2016 13:11:08 Mark Brown wrote:
> On Tue, Feb 16, 2016 at 10:10:44AM +0100, Arnd Bergmann wrote:
> > On Tuesday 16 February 2016 01:56:16 Mark Brown wrote:
> 
> > > No, NULL is explicitly not something you can substitute in,
> > > essentially all the users are just not bothering to implement error
> > > checking and we don't want to encourage that.  The set of use cases
> > > where we legitimately have optional supplies is very small, much smaller
> > > than clocks, because it makes the electrical engineering a lot harder.
> 
> > I must have misinterpreted the idea behind that API as well then.
> 
> > From this function definition:
> 
> > static inline struct regulator *__must_check regulator_get(struct device *dev,
> >         const char *id)
> > {       
> >         /* Nothing except the stubbed out regulator API should be
> >          * looking at the value except to check if it is an error
> >          * value. Drivers are free to handle NULL specifically by
> >          * skipping all regulator API calls, but they don't have to.
> >          * Drivers which don't, should make sure they properly handle
> >          * corner cases of the API, such as regulator_get_voltage()
> >          * returning 0.
> >          */             
> >         return NULL;
> > }
> 
> This is the stubbed regulator API which is only ever used with the stub
> regulator API, it uses NULL to give a non-error pointer it can return to
> well written callers so they don't know they are running with the stubs.
> We are explicitly using NULL because callers should treat it as a valid
> regulator.

Right, that is what I understood.

> > my reading was that the expected behavior in any driver was:
> 
> > * call regulator_get()
> > * if IS_ERR(), fail device probe function, never use invalid
> >   pointer other than PTR_ERR()
> > * if NULL, and regulator is required, fail probe so we never
> >   use the regulator
> 
> No, drivers should never look at the value of the pointer other than to
> check it for error.  If there is a problem of any kind an error will be
> returned.
>
> > * if NULL, and regulators are optional, continue with the NULL
> >   value.
> 
> No, we always return an error pointer if we fail to get a regulator.
> The difference with optional regulators is in how we handle the
> situation where we have full constraints and a regulator is not mapped
> in, normally we assume there must be one with no software control but we
> need to work around buggy bindings as the device would be non-functional
> without power.

Sorry, I should not have said "optional" here, which has a specific
meaning in the API. I meant a driver that can work with either
CONFIG_REGULATOR enabled or disabled (which is something slightly
different).

I guess a driver needing to know whether regulators are built-in
should check 'if (IS_ENABLED(CONFIG_REGULATOR))' rather than
checking the return code for NULL.

	Arnd
