From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 09/12] PM / OPP: Move away from RCU locking
Date: Tue, 10 Jan 2017 09:58:58 +0530
Message-ID: <20170110042858.GD6332@vireshk-i7>
References: <cover.1481106919.git.viresh.kumar@linaro.org>
 <2141b49d888d7b60ff317256a559ab78c1448a03.1481106919.git.viresh.kumar@linaro.org>
 <20170109235727.GA17126@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33768 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751755AbdAJE3C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Jan 2017 23:29:02 -0500
Received: by mail-pf0-f178.google.com with SMTP id y143so18782643pfb.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Jan 2017 20:29:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170109235727.GA17126@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 09-01-17, 15:57, Stephen Boyd wrote:
> I suppose this is one thing RCU was being used for, marking OPPs
> available and then having these "getter" APIs fail if the OPPs go
> away. But that was never right because the OPP could have been
> made unavailable after this function returned and things still
> wouldn't work.

Right, it was all so confusing with RCUs in OPP library :)

-- 
viresh
