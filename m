From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 1/9] PM / OPP: Allow OPP table to be used for
 power-domains
Date: Mon, 17 Apr 2017 11:03:03 +0530
Message-ID: <20170417053303.GG28191@vireshk-i7>
References: <cover.1490001099.git.viresh.kumar@linaro.org>
 <e772e67a5445319bb8e0f312846ace666adc097f.1490001099.git.viresh.kumar@linaro.org>
 <468e756b-7112-4006-b31d-9fcf1c32673d@arm.com>
 <20170413055049.GN5910@vireshk-i7>
 <854e3f66-6f93-2b90-14a9-7eaea6a0b74c@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36206 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932360AbdDQFdH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Apr 2017 01:33:07 -0400
Received: by mail-pf0-f182.google.com with SMTP id 194so21980066pfv.3
        for <linux-pm@vger.kernel.org>; Sun, 16 Apr 2017 22:33:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <854e3f66-6f93-2b90-14a9-7eaea6a0b74c@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@linaro.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, devicetree@vger.kernel.org

On 13-04-17, 14:43, Sudeep Holla wrote:
> Interesting. My understand of power domain and in particular power
> domain performance was that it would control both. The abstract number
> you introduce would hide clocks and regulators.
> 
> But if the concept treats it just as yet another regulator, we do we
> need these at all. Why don't we relate this performance to regulator
> values and be done with it ?
> 
> Sorry if I am missing to understand something here. I would look this as
> replacement for both clocks and regulators, something similar to ACPI
> CPPC. If not, it looks unnecessary to me with the information I have got
> so far.

I kind of answered that in the other email.

Some background may be good here. So Qcom tried to solve all this with virtual
regulators, but the problem was that they need to talk in terms of integer
values (1, 2, 3..) and not voltages and so they can't use the regulator
framework straight away. And so we are doing all this.

-- 
viresh
