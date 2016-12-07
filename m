From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 02/10] PM / OPP: Remove useless TODO
Date: Wed, 7 Dec 2016 08:54:21 +0530
Message-ID: <20161207032421.GD31255@vireshk-i7>
References: <cover.1481015522.git.viresh.kumar@linaro.org>
 <1256ea9415bf9e6a4cf71b5b22e544e5b542a056.1481015522.git.viresh.kumar@linaro.org>
 <20161207011008.GG4388@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:33986 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752618AbcLGDaZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Dec 2016 22:30:25 -0500
Received: by mail-pg0-f43.google.com with SMTP id x23so156585940pgx.1
        for <linux-pm@vger.kernel.org>; Tue, 06 Dec 2016 19:30:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161207011008.GG4388@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 06-12-16, 17:10, Stephen Boyd wrote:
> On 12/06, Viresh Kumar wrote:
> > This TODO doesn't make sense anymore as we have all the information in a
> > single OPP table. Remove it.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> 
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> 
> Was this for multiple phandles style of binding that we never
> merged?

Yes, for something like slow and fast OPP tables. We solved that
problem in a different way.

-- 
viresh
