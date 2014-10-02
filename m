From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH resend] cpufreq: dt: disable unsupported OPPs
Date: Thu, 02 Oct 2014 19:33:17 +0200
Message-ID: <2501955.IIHrJfzgRB@vostro.rjw.lan>
References: <1412090950-20835-1-git-send-email-l.stach@pengutronix.de> <CAKohpon9buGWmcXH9+PmtatmbnOro+gU84zkskPjNZ6fiM5SLQ@mail.gmail.com> <1412251075.4875.3.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62239 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751510AbaJBRNS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Oct 2014 13:13:18 -0400
In-Reply-To: <1412251075.4875.3.camel@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Mark Brown <broonie@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Thursday, October 02, 2014 01:57:55 PM Lucas Stach wrote:
> Am Donnerstag, den 02.10.2014, 10:54 +0530 schrieb Viresh Kumar:
> > On 2 October 2014 02:09, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > Would you mind sending it again with the fix folded in for me?
> > 
> > Done.
> 
> I don't know how it makes sense to fold the fix into this patch. It has
> nothing to do with the rename.
> If you want to fold the fix in the relevant patch this would be
> "cpufreq: cpu0: Move per-cluster initialization code to ->init()"

OK, my confusion, sorry about that.

I'll take the original version of the Viresh's patch and the fix on top
of that separately, then.

That said, it would help if the information about when things broke was there
in the fix' chanelog.

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
