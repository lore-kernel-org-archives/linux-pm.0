From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 05/10] opp: Add support to parse "operating-points-v2"
 bindings
Date: Tue, 28 Jul 2015 16:03:16 -0700
Message-ID: <55B80A34.1010805@codeaurora.org>
References: <cover.1434369079.git.viresh.kumar@linaro.org> <1b5a393f2162752cbb773956dff15739e7525a1d.1434369079.git.viresh.kumar@linaro.org> <2910042.ys2zsBBKt2@amdc1976> <20150727030239.GG19944@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:41210 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbbG1XDT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2015 19:03:19 -0400
In-Reply-To: <20150727030239.GG19944@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, mturquette@baylibre.com, Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, broonie@kernel.org, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com

On 07/26/2015 08:02 PM, Viresh Kumar wrote:
> On 08-07-15, 15:41, Bartlomiej Zolnierkiewicz wrote:
>> Isn't using u32 for storing frequency (in Hz) too small by today's
>> standards?
>>
>> [ Please note that the old v1 binding uses kHz not Hz. ]
> I have thought about this a bit more and I am somewhat confused. Yes I
> agree that u32 isn't big enough for frequencies in Hz, i.e. Max value
> of 4294967295 ~ 4.29 GHz.
>
> But the bigger problem lies with the clk API that we have today. It
> declares clk-rate as a unsigned-long which is 32 bits on a 32 bit
> machine and 64 bits on a 64 bit machine. And every single piece of
> code reading "clock-frequency" DT property, reads it as a 32 bit value
> as we reserve only a single cell for it.
>
> Now, if we wanna change that, we need to start changing from the
> clk-API itself and that's not gonna be a small task and I would leave
> it to Mike/Stephen for obvious reasons :)
>
> So, I will keep this code in sync with rest of the kernel and lets see
> what Mike has to say.
>

There is talk about moving to 64 bits for the frequency in the clk API.
It's not actively being developed though and I'm not sure when we'll get
there. From a DT perspective though, I don't see why it would be bad to
have two cells instead of one cell for the frequency here. It would
allow up to 64 bits of frequency so that when we change the clk API we
won't need to do anything in the OPP bindings to handle it. Just because
we have problems in the kernel doesn't mean we should put the same
problems into DT.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

