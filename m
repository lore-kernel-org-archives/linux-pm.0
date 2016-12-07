From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 01/10] PM / OPP: Fix memory leak while adding duplicate
 OPPs
Date: Wed, 7 Dec 2016 08:53:15 +0530
Message-ID: <20161207032315.GC31255@vireshk-i7>
References: <cover.1481015522.git.viresh.kumar@linaro.org>
 <d4addab7750d63731d8e8562e2600fa8c987f53a.1481015522.git.viresh.kumar@linaro.org>
 <20161207010924.GF4388@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34485 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752017AbcLGDcL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Dec 2016 22:32:11 -0500
Received: by mail-pf0-f180.google.com with SMTP id c4so74284908pfb.1
        for <linux-pm@vger.kernel.org>; Tue, 06 Dec 2016 19:32:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161207010924.GF4388@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 06-12-16, 17:09, Stephen Boyd wrote:
> > @@ -1186,8 +1192,12 @@ int _opp_add_v1(struct device *dev, unsigned long freq, long u_volt,
> >  	new_opp->dynamic = dynamic;
> >  
> >  	ret = _opp_add(dev, new_opp, opp_table);
> > -	if (ret)
> > +	if (ret) {
> > +		/* Don't return error for duplicate OPPs */
> 
> Yes, but why?

Will update the comment over _opp_add() to describe that.

-- 
viresh
