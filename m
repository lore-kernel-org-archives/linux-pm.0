From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: of_property_count_u32_elems() can return errors
Date: Tue, 22 Sep 2015 09:35:05 -0700
Message-ID: <20150922163505.GF24314@linux>
References: <46a47430b8d65f509d47fe3ad1264c6b23086d61.1442508974.git.viresh.kumar@linaro.org>
 <20150917181328.GQ23081@codeaurora.org>
 <20150919032113.GA24314@linux>
 <20150919222219.GE23081@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33671 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758598AbbIVQfH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2015 12:35:07 -0400
Received: by pacex6 with SMTP id ex6so13676515pac.0
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2015 09:35:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150919222219.GE23081@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On 19-09-15, 15:22, Stephen Boyd wrote:
> On 09/18, Viresh Kumar wrote:
> > On 17-09-15, 11:13, Stephen Boyd wrote:
> > > > +	count = of_property_count_u32_elems(opp->np, "opp-microvolt");
> > > > +	if (count < 0) {
> > > 
> > > We can't test count for -EINVAL to detect the missing property
> > > because -EINVAL is also returned on a non-multiple of u32 length
> > > property? Maybe we shouldn't worry about that case and turn
> > > -EINVAL into 0.
> > 
> > So you are saying that we go ahead without regulators if a incorrect
> > values are present in opp-microvolt? i.e. even if the length property
> > was invalid, we return 0 from this function.
> > 
> > The problem here is that we will try changing the frequency without
> > changing the regulator in that case, and it might not be safe for the
> > platform, isn't it?
> > 
> 
> Do we care if a platform has changed the length of the property
> to something that isn't a multiple of u32? That sounds very rare,
> that's all. I agree it's a bug.

Hmm, okay.. I got it now.

Maybe we can update of_property_count_u32_elems() to return zero in
that case, but that might not be the appropriate return value.

It *can* be confused against the case where the user has written an
empty property. But even in that case we are returning -ENODATA
instead of 0 :)

-- 
viresh
