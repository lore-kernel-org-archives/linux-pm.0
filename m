From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 4/6] PM / domain: Register for PM QOS performance
 notifier
Date: Wed, 22 Feb 2017 08:55:48 +0530
Message-ID: <20170222032548.GZ21911@vireshk-i7>
References: <cover.1486611268.git.viresh.kumar@linaro.org>
 <a973289cb908a391533a4b940af671beb2e8ace4.1486611268.git.viresh.kumar@linaro.org>
 <m27f4o4bl9.fsf@baylibre.com>
 <20170220050138.GO21911@vireshk-i7>
 <CAPDyKFqsJsXqR--EL-srPTLLZXxHLYJMGWhTor+YJCO1XxjmQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35868 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753807AbdBVDZw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Feb 2017 22:25:52 -0500
Received: by mail-pg0-f51.google.com with SMTP id s67so34856344pgb.3
        for <linux-pm@vger.kernel.org>; Tue, 21 Feb 2017 19:25:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAPDyKFqsJsXqR--EL-srPTLLZXxHLYJMGWhTor+YJCO1XxjmQA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@baylibre.com>, Rafael Wysocki <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>

On 21-02-17, 16:28, Ulf Hansson wrote:
> A genpd PM domain can have several parents (or to use the genpd
> terminology, masters).
> 
> This is different from allowing a device to be attached to more than
> one PM domains, which is what I think you are referring to. That isn't
> supported.

Thanks for clarifying. Got it now.

-- 
viresh
