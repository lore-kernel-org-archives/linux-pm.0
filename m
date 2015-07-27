From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 05/10] opp: Add support to parse "operating-points-v2"
 bindings
Date: Mon, 27 Jul 2015 08:32:39 +0530
Message-ID: <20150727030239.GG19944@linux>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
 <1b5a393f2162752cbb773956dff15739e7525a1d.1434369079.git.viresh.kumar@linaro.org>
 <2910042.ys2zsBBKt2@amdc1976>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:34591 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755249AbbG0DCo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 26 Jul 2015 23:02:44 -0400
Received: by pdbbh15 with SMTP id bh15so43646123pdb.1
        for <linux-pm@vger.kernel.org>; Sun, 26 Jul 2015 20:02:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2910042.ys2zsBBKt2@amdc1976>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, mturquette@baylibre.com
Cc: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, broonie@kernel.org, sboyd@codeaurora.org, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com

On 08-07-15, 15:41, Bartlomiej Zolnierkiewicz wrote:
> Isn't using u32 for storing frequency (in Hz) too small by today's
> standards?
> 
> [ Please note that the old v1 binding uses kHz not Hz. ]

I have thought about this a bit more and I am somewhat confused. Yes I
agree that u32 isn't big enough for frequencies in Hz, i.e. Max value
of 4294967295 ~ 4.29 GHz.

But the bigger problem lies with the clk API that we have today. It
declares clk-rate as a unsigned-long which is 32 bits on a 32 bit
machine and 64 bits on a 64 bit machine. And every single piece of
code reading "clock-frequency" DT property, reads it as a 32 bit value
as we reserve only a single cell for it.

Now, if we wanna change that, we need to start changing from the
clk-API itself and that's not gonna be a small task and I would leave
it to Mike/Stephen for obvious reasons :)

So, I will keep this code in sync with rest of the kernel and lets see
what Mike has to say.

-- 
viresh
