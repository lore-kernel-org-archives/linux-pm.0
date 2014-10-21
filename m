From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RESEND 2] cpufreq: dt: disable unsupported OPPs
Date: Tue, 21 Oct 2014 16:19:54 +0200
Message-ID: <8590662.lsNXszcTd0@vostro.rjw.lan>
References: <48734362.lRa73hezrZ@vostro.rjw.lan> <1413454100-23009-1-git-send-email-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63989 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932586AbaJUN72 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Oct 2014 09:59:28 -0400
In-Reply-To: <1413454100-23009-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org

On Thursday, October 16, 2014 12:08:20 PM Lucas Stach wrote:
> If the regulator connected to the CPU voltage plane doesn't
> support an OPP specified voltage with the acceptable tolerance
> it's better to just disable the OPP instead of constantly
> failing the voltage scaling later on.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
