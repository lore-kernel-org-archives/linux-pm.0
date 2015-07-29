From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 05/10] opp: Add support to parse "operating-points-v2"
 bindings
Date: Wed, 29 Jul 2015 12:23:51 +0530
Message-ID: <20150729065351.GA2502@linux>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
 <1b5a393f2162752cbb773956dff15739e7525a1d.1434369079.git.viresh.kumar@linaro.org>
 <2910042.ys2zsBBKt2@amdc1976>
 <20150727030239.GG19944@linux>
 <55B80A34.1010805@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:33532 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752813AbbG2Gx6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2015 02:53:58 -0400
Received: by pdbnt7 with SMTP id nt7so708130pdb.0
        for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2015 23:53:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55B80A34.1010805@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, mturquette@baylibre.com, Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, broonie@kernel.org, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com

On 28-07-15, 16:03, Stephen Boyd wrote:
> There is talk about moving to 64 bits for the frequency in the clk API.
> It's not actively being developed though and I'm not sure when we'll get
> there. From a DT perspective though, I don't see why it would be bad to
> have two cells instead of one cell for the frequency here. It would
> allow up to 64 bits of frequency so that when we change the clk API we
> won't need to do anything in the OPP bindings to handle it. Just because
> we have problems in the kernel doesn't mean we should put the same
> problems into DT.

Okay, I am going to send a patch for that as well and will respin the
series again.

-- 
viresh
