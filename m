From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 0/9] PM / OPP: Multiple regulator support
Date: Wed, 23 Nov 2016 09:16:57 +0530
Message-ID: <20161123034657.GB22335@vireshk-i7>
References: <cover.1477463128.git.viresh.kumar@linaro.org>
 <20161118030636.GA3110@vireshk-i7>
 <20161118104329.27xpm7cshfpxykqd@sirena.org.uk>
 <20161122034922.GC3070@vireshk-i7>
 <20161122184103.djm3jn67gshdtun4@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33289 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756157AbcKWDyO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Nov 2016 22:54:14 -0500
Received: by mail-pf0-f176.google.com with SMTP id d2so525897pfd.0
        for <linux-pm@vger.kernel.org>; Tue, 22 Nov 2016 19:54:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161122184103.djm3jn67gshdtun4@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com

On 22-11-16, 18:41, Mark Brown wrote:
> On Tue, Nov 22, 2016 at 09:19:22AM +0530, Viresh Kumar wrote:
> > "How do we know (from the DT) the order in which entries for multiple regulators
> > are present in the OPP table?"
> > 
> > And I am not sure if we can do that without having a property like:
> > 
> > +               supply-names = "vcc0", "vcc1", "vcc2";
> > 
> > in the OPP table or the consumer device. And surely it isn't a clean enough
> > solution and that's why this series relied on the code to get such details.
> > 
> > Does someone have an alternative? If NO, can we go ahead with this series as is?
> 
> I'm really not at all clear why this has to be in DT.  My understanding
> was that this is basically a helper library for more specific bindings
> which already have to hard code things like sequencing so surely they'd
> be specifying the ordering to be used when supplying data?

I am a bit confused and perhaps I am misreading your feedback.

Are you saying that:

"we don't need to identify which microVolts value in the OPP table corresponds
to which supply from the DT itself and we can do that with some hard coded
stuff" ?

If yes, then below is from an earlier email from you, which I feel is opposite
of what you are suggesting now.

On 09-11-16, 14:58, Mark Brown wrote:
> On Wed, Oct 26, 2016 at 12:02:56PM +0530, Viresh Kumar wrote:

> > The platform driver is responsible to identify the order and pass it on to the
> > OPP core. And the platform driver needs to have that hard coded.
>
> That *really* should be in the binding.  Honestly if the binding is this
> vague I'm not even clear that it's worth documenting these properties at
> this level, might be better to just put the documentation in the
> platform driver bindings.

-- 
viresh
