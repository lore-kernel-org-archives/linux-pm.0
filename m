From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Discussion] Performance levels of power domains
Date: Thu, 27 Oct 2016 09:16:38 +0530
Message-ID: <20161027034638.GA10423@vireshk-i7>
References: <CAKohpokwTOZbbRP4XRV1jPoQ=gKxD2UKBYSXcZe8iBgDnr9-BQ@mail.gmail.com>
 <7hvawfq6kh.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36747 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932887AbcJ0Dqm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Oct 2016 23:46:42 -0400
Received: by mail-pf0-f172.google.com with SMTP id e6so8616054pfk.3
        for <linux-pm@vger.kernel.org>; Wed, 26 Oct 2016 20:46:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7hvawfq6kh.fsf@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Vincent Guittot <vincent.guittot@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, "Nayak, Rajendra" <rnayak@codeaurora.org>, Georgi Djakov <georgi.djakov@linaro.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Mark Brown <broonie@kernel.org>

On 26-10-16, 12:00, Kevin Hilman wrote:
> Yes.  As I've suggested to qcom/linaro folks (off-list discussions), I

No one told me this story :)

> think extending genpd to handle performance states is a logical
> extension.  Otherwise, you will be (re)inventing something that looks an
> awful lot like genpd anyways.

I completely agree. Runtime PM and genpd look to be the perfect
placeholder for such stuff. I actually tried to convince Ulf yesterday
on this and he wasn't sure if it will ever get accepted upstream and
that's when I started this thread :)

> The other related framework is per-device PM QoS which could be used to
> set constraints on specific devices, and the genpd governors would then
> be responsible for looking at the constraints and changing states as
> needed.

I am not sure if genpd governors are also background governors like
cpufreq, but we need to make sure that the voltage is raised after the
function requesting a change returns, so that the clk rate can be
increased then.

-- 
viresh
