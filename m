From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 2/2] dt: power: st: Provide bindings for ST's OPPs
Date: Tue, 28 Jul 2015 13:17:09 +0530
Message-ID: <20150728074709.GA13710@linux>
References: <1438010430-5802-1-git-send-email-lee.jones@linaro.org>
 <1438010430-5802-2-git-send-email-lee.jones@linaro.org>
 <20150728022936.GB1229@linux>
 <20150728073439.GK21114@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:34712 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753927AbbG1HrO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2015 03:47:14 -0400
Received: by pdbbh15 with SMTP id bh15so66383868pdb.1
        for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2015 00:47:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150728073439.GK21114@x1>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: rob.herring@linaro.org, nm@ti.com, arnd.bergmann@linaro.org, sboyd@codeaurora.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com, sre@kernel.org, dbaryshkov@gmail.com

On 28-07-15, 08:34, Lee Jones wrote:
> I disagree.  For one, only 'opp-hz' is defined in ./opp.tx.  Secondly

There are other properties in op.txt like turbo, opp-suspend, latency,
etc.. which can be useful for your platform to. Its not used for now
is a different thing.

> it would be annoying to have to have to keep jumping between documents
> to obtain the whole picture.  Finally, generic bindings are repeated
> in platform/device specific documentation all the time.  Grep for
> 'clocks' or 'regulator-* or 'interrupts' or 'reg' or 'clock-frequency'

Yeah, I agree. I am not against that. What I meant to say was that its
an extension to opp-v2. So whatever is present in opp-v2 can be used
by ST's driver, without mentioning that here as well.

> (which IMHO I think you should have used instead of 'opp-hz', but
> that's by the by), or any number of other generic properties.

Hmm, probably yes. See I don't know everything :)

> > @Rob/Stephen: Please respond before it is late :)
> 
> No one knows this stuff better than you.  If you can't think of an
> already existing binding that could suit to portray our 'cuts' and
> 'substrate' information (with a similar way to support our "all cuts"
> and "all substrates" options, then there probably isn't one. ;)

Oh, I wasn't saying that there is an existing binding for supporting
your case. But if we want to move the cuts property to the generic
bindings so that others can use it. :)

-- 
viresh
