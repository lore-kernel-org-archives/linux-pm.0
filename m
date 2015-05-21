From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V5 1/3] OPP: Redefine bindings to overcome shortcomings
Date: Thu, 21 May 2015 11:16:02 +0530
Message-ID: <20150521054602.GE22904@linux>
References: <cover.1432091956.git.viresh.kumar@linaro.org>
 <51a2603050f7993643fea9e5dcd2dba7a5a3fe23.1432091956.git.viresh.kumar@linaro.org>
 <555D6CC8.9050201@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:36166 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586AbbEUFqH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 May 2015 01:46:07 -0400
Received: by pdfh10 with SMTP id h10so95783418pdf.3
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2015 22:46:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <555D6CC8.9050201@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, arnd.bergmann@linaro.org, broonie@kernel.org, mike.turquette@linaro.org, sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, grant.likely@linaro.org, olof@lixom.net, Sudeep.Holla@arm.com, devicetree@vger.kernel.org, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com

On 21-05-15, 00:27, Nishanth Menon wrote:
> > +This describes the OPPs belonging to a device. This node can have following
> > +properties:
> > +
> > +Required properties:
> > +- compatible: Allow OPPs to express their compatibility. It should be:
> > +  "operating-points-v2".
> > +
> > +- OPP nodes: One or more OPP nodes describing voltage-current-frequency
> > +  combinations. Their name isn't significant but their phandle can be used to
> > +  reference an OPP.
> 
> What if this was generated data (say using an overlay)?

Sorry I am not aware of this, can you explain a bit how this is done ?
Are you talking about something like fdtput here ?

> does it have to
> be "required" or just "optional" :)

This has to be required (by the parser, kernel in our case).

> > +Required properties:
> > +- opp-hz: Frequency in Hz
> 
> I am just being nit picky -> should we keep Heinrich Hertz respected[2]
> and name it opp-Hz ? No strong opinions either way.

Documentation/devicetree/booting-without-of.txt:

4) Note about node and property names and character set
-------------------------------------------------------

While Open Firmware provides more flexible usage of 8859-1, this
specification enforces more strict rules. Nodes and properties should
be comprised only of ASCII characters 'a' to 'z', '0' to
'9', ',', '.', '_', '+', '#', '?', and '-'. Node names additionally
allow uppercase characters 'A' to 'Z' (property names should be
lowercase. The fact that vendors like Apple don't respect this rule is
irrelevant here). Additionally, node and property names should always
begin with a character in the range 'a' to 'z' (or 'A' to 'Z' for node
names).

> 
> different angle: How about just target-freq-Hz? just drop the "opp"
> prefix for properties of an OPP node? No strong feelings here. (some
> folks did have variations of a few Hz based on clock tree - example with
> a crystal frequency of 19.2MHz you'd probably get 1001MHz exact, with a
> 26MHz crystal, you'd get 1000MHz -> ofcourse round-rate is supposed to
> help with that... but anyways.. why not say we are trying to indicate
> target frequency? I do recollect during initial days of OPP
> (pre-dt-adoption days) folks did complain about this - we kinda worked
> around this with round-rated handling - but we might as well anticipate it.

Rob suggested opp- prefix and it looks good to me, lets see what
others have to say :)

> Thanks for adding the examples - My customer support team especially
> will appreciate having such examples ;).

I can understand that :)

> I agree with Mike[1] here -> why not move clocks and supply to cpu0_opp?
> "
> It seems wrong to me that the clock and supply data is owned by the cpu
> node, and not the opp descriptor. Everything about the opp transition
> should belong to a provider node. Then the cpu simply needs to consume
> that via a phandle.
> "
> 
> I am not sure if we discussed that point further OR if we kinda got
> hooked on to the "should it be in kernel" point of debate in V4.

I did send a reply to that, but no one replied after that. Probably
you want to reply on that ?

Thanks for your detailed review.

-- 
viresh
