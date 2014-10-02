From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH resend] cpufreq: dt: disable unsupported OPPs
Date: Thu, 02 Oct 2014 13:57:55 +0200
Message-ID: <1412251075.4875.3.camel@pengutronix.de>
References: <1412090950-20835-1-git-send-email-l.stach@pengutronix.de>
	 <2197100.Nocxtjmizk@vostro.rjw.lan>
	 <CAKohpomH6V3akJjSQZS-xWubC6xUzfJihWcNT0FpYM98qvayNQ@mail.gmail.com>
	 <4618249.XhLIrkx56O@vostro.rjw.lan>
	 <CAKohpon9buGWmcXH9+PmtatmbnOro+gU84zkskPjNZ6fiM5SLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51093 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331AbaJBL6A (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Oct 2014 07:58:00 -0400
In-Reply-To: <CAKohpon9buGWmcXH9+PmtatmbnOro+gU84zkskPjNZ6fiM5SLQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Brown <broonie@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Am Donnerstag, den 02.10.2014, 10:54 +0530 schrieb Viresh Kumar:
> On 2 October 2014 02:09, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > Would you mind sending it again with the fix folded in for me?
> 
> Done.

I don't know how it makes sense to fold the fix into this patch. It has
nothing to do with the rename.
If you want to fold the fix in the relevant patch this would be
"cpufreq: cpu0: Move per-cluster initialization code to ->init()"

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

