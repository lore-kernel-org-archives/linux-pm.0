From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 1/6] PM / QOS: Add default case to the switch
Date: Fri, 10 Feb 2017 11:30:30 +0530
Message-ID: <20170210060030.GA8498@vireshk-i7>
References: <cover.1486611268.git.viresh.kumar@linaro.org>
 <338b16e4c882634e30e4f4c011a9e9c52d134cbc.1486611268.git.viresh.kumar@linaro.org>
 <20170209142425.GC23373@xo-6d-61-c0.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35168 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750979AbdBJGBD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Feb 2017 01:01:03 -0500
Received: by mail-pf0-f181.google.com with SMTP id 202so3570252pfx.2
        for <linux-pm@vger.kernel.org>; Thu, 09 Feb 2017 22:00:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170209142425.GC23373@xo-6d-61-c0.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, khilman@baylibre.com, ulf.hansson@linaro.org, Len Brown <len.brown@intel.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, sboyd@codeaurora.org, nm@ti.com, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org

On 09-02-17, 15:24, Pavel Machek wrote:
> On Thu 2017-02-09 09:11:47, Viresh Kumar wrote:
> > The switch block handles all the QOS request types present today, but
> > starts giving compilation warnings as soon as a new type is added and
> > not handled in this.
> > 
> > To prevent against that, add the default case as well and do a WARN from
> > it.
> 
> I'd say compilation-time warning is better than hmm.... stacktrace and memory leak
> at runtime?

Of course we aren't going to allow a compilation warning for each and every
platform that compiles this file. How do you wish to fix the issue then ?

-- 
viresh
