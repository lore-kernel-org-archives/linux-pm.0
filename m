From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 5/6] clk: pxa: transfer CPU clock setting from
 pxa2xx-cpufreq
Date: Thu, 20 Oct 2016 09:14:58 +0530
Message-ID: <20161020034458.GE11766@vireshk-i7>
References: <1476130149-31834-1-git-send-email-robert.jarzmik@free.fr>
 <1476130149-31834-6-git-send-email-robert.jarzmik@free.fr>
 <87zim23zw3.fsf@belgarion.home>
 <20161018234855.GO8871@codeaurora.org>
 <877f943xjk.fsf@belgarion.home>
 <20161019205128.GE8871@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35663 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932571AbcJTDpD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Oct 2016 23:45:03 -0400
Received: by mail-pf0-f172.google.com with SMTP id s8so27525371pfj.2
        for <linux-pm@vger.kernel.org>; Wed, 19 Oct 2016 20:45:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20161019205128.GE8871@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>, Michael Turquette <mturquette@baylibre.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On 19-10-16, 13:51, Stephen Boyd wrote:
> On 10/19, Robert Jarzmik wrote:
> > Stephen Boyd <sboyd@codeaurora.org> writes:
> > 
> > > On 10/18, Robert Jarzmik wrote:
> > >> Robert Jarzmik <robert.jarzmik@free.fr> writes:
> > >> Hi Michael and Stephen,
> > >> 
> > >> I'm planing on sending a v2 next week with minor corrections, mostly in the data
> > >> tables (pxa25x_freqs and pxa27x_freqs), as testing prooved some values were wrong.
> > >> 
> > >> If you want me modify this serie, will you have time to review for next week or
> > >> should I delay the v2 posting ?
> > >> 
> > >
> > > No need to delay. clk patches look fine with a quick glance. It
> > > would be really neat if we could make cpufreq-dt work without DT.
> > > What's blocking that? OPP tables?
> > 
> > Heu I'm not the author of cpufreq-dt, so I'm not the best to answer.
> > To answer the question "without DT", it depends if you mean "with ACPI" or "with
> > platform_data" or something else.
> 
> I mean platform_data mostly. Do you use ACPI with the clk driver?

I would like to see sample code for that, as I am not sure what all changes
would be required in cpufreq-dt in that case. Yes it is more dependent on the
OPP framework than DT right now.

My first impression is that it should be doable..

-- 
viresh
