From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 0/9] PM / OPP: Multiple regulator support
Date: Thu, 24 Nov 2016 10:37:24 +0530
Message-ID: <20161124050724.GD9376@vireshk-i7>
References: <cover.1477463128.git.viresh.kumar@linaro.org>
 <20161118030636.GA3110@vireshk-i7>
 <20161118104329.27xpm7cshfpxykqd@sirena.org.uk>
 <20161122034922.GC3070@vireshk-i7>
 <20161122184103.djm3jn67gshdtun4@sirena.org.uk>
 <20161123034657.GB22335@vireshk-i7>
 <20161123122959.r262pkvhx4zj6c7p@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:36725 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbcKXFH2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Nov 2016 00:07:28 -0500
Received: by mail-pg0-f43.google.com with SMTP id f188so14024617pgc.3
        for <linux-pm@vger.kernel.org>; Wed, 23 Nov 2016 21:07:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161123122959.r262pkvhx4zj6c7p@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com

Hi Mark,

On 23-11-16, 12:29, Mark Brown wrote:
> On Wed, Nov 23, 2016 at 09:16:57AM +0530, Viresh Kumar wrote:
> > Are you saying that:
> 
> > "we don't need to identify which microVolts value in the OPP table corresponds
> > to which supply from the DT itself and we can do that with some hard coded
> > stuff" ?
> 
> No, of course not.  That would be completely incoherent, there would be
> no way for anything to use the data if the values can just be in any
> random order.

With the current implementation in this patchset, the order in which entries are
present in the OPP node is _assumed_ to be known to the platform specific code,
which will pass it on to the OPP core with some callbacks. So the order will not
be completely random.

> > If yes, then below is from an earlier email from you, which I feel is opposite
> > of what you are suggesting now.
> 
> > > That *really* should be in the binding.  Honestly if the binding is this
> > > vague I'm not even clear that it's worth documenting these properties at
> > > this level, might be better to just put the documentation in the
> > > platform driver bindings.
> 
> The "platform driver bindings" bit of this is very important here.  This
> is a generic binding that is going to be used by platform specific
> drivers (as I understand it).

There is no platform specific binding here.

For example in case of a single regulator for the device (CPU), the platform
specific DT file contains the CPU nodes (using generic bindings) and an OPP
table node (again generic bindings only). The OPP core reads both these nodes
for the device and constructs the OPP table.

Now in case of multiple regulators for the device, as you already know, the only
unanswered detail (apart from the order in which the regulators need to be
programmed) is to link which entries in the OPP table are for which regulator.

We can either get this information from DT (somehow) or hardcode it in platform
specific code. This patch provided infrastructure for the later one.

If we indeed want to get this information from the DT then there are two
options:

- Create platform specific binding:

  foo-platform,supply-names = "vcc0", "vcc1", "vcc2";

- Create common binding that can be used by all platforms:

  supply-names = "vcc0", "vcc1", "vcc2";


Such bindings will end up either in the consumer device node (like CPU0 node) or
in the OPP table itself. I am personally inclined towards the common
supply-names bindings, otherwise every user platform will end up creating very
similar bindings.

> I would therefore expect that these
> things can be described in the platform specific bindings.
> 
> Please, take a step back and think about what what the binding means and
> how it's going to be used.  Not only is this a DT binding and therefore
> an ABI it's also a generic binding that's going to affect a lot of
> systems probably for a long time.  This means it is really important to
> think things through and make sure we understand what they're doing.
> When working on kernel internal code it's relatively easy to fix things
> if we realize later that they don't work well so it's easier to just
> work quickly but when we're making ABIs that's not possible.

I agree and I completely understand your concerns here and it is surely very
important to get the bindings right as they will last for very long.

But I am still unsure about what's the best way of doing this. The new bindings
are rejected by almost everyone as they contain some of the information already
contained in the consumer node while the regulators are defined.

-- 
viresh
