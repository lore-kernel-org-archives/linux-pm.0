From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [Discussion] Performance levels of power domains
Date: Wed, 26 Oct 2016 12:09:40 +0100
Message-ID: <af9ab13a-6f77-5abe-e17f-c7dd6efa6d7e@arm.com>
References: <CAKohpokwTOZbbRP4XRV1jPoQ=gKxD2UKBYSXcZe8iBgDnr9-BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37570 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755821AbcJZLJn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 26 Oct 2016 07:09:43 -0400
In-Reply-To: <CAKohpokwTOZbbRP4XRV1jPoQ=gKxD2UKBYSXcZe8iBgDnr9-BQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Brown <broonie@kernel.org>, "Nayak, Rajendra" <rnayak@codeaurora.org>, Georgi Djakov <georgi.djakov@linaro.org>



On 26/10/16 11:52, Viresh Kumar wrote:
> Hi Guys,
>
> I wanted to involve you guys to get a discussion going
> for a problem we want to solve, and so this mail.
>
>
> Platform details:
>
> Some of the Qualcom SoCs have the option to configure
> the performance level of their Power Domains. The performance
> levels are identified by integer values (lets say 0-9, 0 being the lowest).
>
> Another M3 core handles the *real* voltage scaling based on the input
> received (from software) in terms of these performance levels. The M3
> core translates the levels into a range of voltages (corners) and selects
> the right one by itself.
>

Just out of curiosity, what's the protocol used to communicate with this
M3. This is what we already have on Vexpress TC2 and Juno. Currently M3
provides the information of voltage and frequency for each OPP, but that
may change as it's not always constant.

> Software needs to provide the performance level for the entire domain
> to the M3 core and so software also needs to handle performance requests
> from all the devices that lie in the domain X and find a Performance Level P,
> which can satisfy all the devices (normally the highest requrested level).
>

That's interesting and this is where it's different and gets complex
than what we have today. Do you have more details on this ?

I am mainly interested as there are efforts to standardize these
communication with M3 and there's WIP protocol development[1]. It would
be good to see if this user-case is also considered. And yes I am
interested in the problem you have explained below but just can't my
head around it as I can't fully visualize such systems.

-- 
Regards,
Sudeep

[1] 
http://s3.amazonaws.com/connect.linaro.org/las16/Presentations/Tuesday/LAS16-200%20--%20%20SCMI%20-%20System%20Management%20and%20Control%20Interface.pdf
