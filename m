From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Discussion] Performance levels of power domains
Date: Wed, 26 Oct 2016 16:46:42 +0530
Message-ID: <20161026111642.GM9162@vireshk-i7>
References: <CAKohpokwTOZbbRP4XRV1jPoQ=gKxD2UKBYSXcZe8iBgDnr9-BQ@mail.gmail.com>
 <af9ab13a-6f77-5abe-e17f-c7dd6efa6d7e@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36296 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933106AbcJZLQq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Oct 2016 07:16:46 -0400
Received: by mail-pf0-f175.google.com with SMTP id e6so138214781pfk.3
        for <linux-pm@vger.kernel.org>; Wed, 26 Oct 2016 04:16:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <af9ab13a-6f77-5abe-e17f-c7dd6efa6d7e@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Brown <broonie@kernel.org>, "Nayak, Rajendra" <rnayak@codeaurora.org>, Georgi Djakov <georgi.djakov@linaro.org>

On 26-10-16, 12:09, Sudeep Holla wrote:
> Just out of curiosity, what's the protocol used to communicate with this
> M3.

I will let Qcom guys answer this :)

> This is what we already have on Vexpress TC2 and Juno. Currently M3
> provides the information of voltage and frequency for each OPP, but that
> may change as it's not always constant.

Yeah, I do remember that. But it was always in terms of voltages and
so this thing is different here.

> That's interesting and this is where it's different and gets complex
> than what we have today. Do you have more details on this ?

I have written everything that I knew about it :)

> I am mainly interested as there are efforts to standardize these
> communication with M3 and there's WIP protocol development[1]. It would
> be good to see if this user-case is also considered.

What do you mean by that ?

> And yes I am
> interested in the problem you have explained below but just can't my
> head around it as I can't fully visualize such systems.

:)

-- 
viresh
