From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] PM / OPP: compatible is an optional property
Date: Mon, 26 Sep 2016 10:25:39 +0530
Message-ID: <20160926045539.GI17336@vireshk-i7>
References: <be2c4fb0bb58f5b29facbc6f5aaf3dca13cf209e.1474450324.git.viresh.kumar@linaro.org>
 <483bea3c-a1b4-ce5d-e720-d69fc943ab50@codeaurora.org>
 <20160923051526.GB17336@vireshk-i7>
 <20160923195510.GA8699@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33600 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752087AbcIZEzo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Sep 2016 00:55:44 -0400
Received: by mail-pa0-f53.google.com with SMTP id hm5so58742663pac.0
        for <linux-pm@vger.kernel.org>; Sun, 25 Sep 2016 21:55:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160923195510.GA8699@rob-hp-laptop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org

On 23-09-16, 14:55, Rob Herring wrote:
> On Fri, Sep 23, 2016 at 10:45:26AM +0530, Viresh Kumar wrote:
> > On 22-09-16, 12:24, Stephen Boyd wrote:
> > > On 09/21/2016 02:32 AM, Viresh Kumar wrote:
> > > > It was never compulsory to have a compatible string in the OPP table.
> > > > Fix the documentation to mark it optional.
> > > >
> 
> NAK.
> 
> > > > Also update its description a bit.
> > > >
> > > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > > ---
> > > 
> > > Why? I'd prefer the compatible string to be required so we know what
> > > sort of node it is.
> 
> Agreed.
> 
> > Okay, the code doesn't have any checks for it then and that needs to be fixed.
> 
> Why? The kernel is not a DT validator.

Hmm.. I thought it should be checking if it can parse those bindings or not.
What if someone adds compatible property as "foo" for OPP node? Should the OPP
code even try to parse it?

> > Just for my clarity, for platforms with special OPP bindings and so a different
> > compatible string like: "operating-points-v2-XYZ", should the compatible string
> > contain both "operating-points-v2" and the above one? It would be easier to
> > check for "operating-points-v2" in that case from core code.
> 
> That would imply operating-points-v2-XYZ has extra properties or is 
> different in some way. If an OS only understanding operating-points-v2 
> will work, then yes it should have both. If not, then no.

Well, in this case that can't be done fully, so we should have only the -xyz
one. Got it, thanks.

-- 
viresh
