From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH resend] cpufreq: dt: disable unsupported OPPs
Date: Thu, 09 Oct 2014 00:36:26 +0200
Message-ID: <6765047.8AI47Iyegn@vostro.rjw.lan>
References: <1412090950-20835-1-git-send-email-l.stach@pengutronix.de> <2197100.Nocxtjmizk@vostro.rjw.lan> <CAKohpomH6V3akJjSQZS-xWubC6xUzfJihWcNT0FpYM98qvayNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52928 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932228AbaJHWQS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Oct 2014 18:16:18 -0400
In-Reply-To: <CAKohpomH6V3akJjSQZS-xWubC6xUzfJihWcNT0FpYM98qvayNQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Lucas Stach <l.stach@pengutronix.de>, Mark Brown <broonie@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Wednesday, October 01, 2014 08:59:17 AM Viresh Kumar wrote:
> On 1 October 2014 01:23, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Tuesday, September 30, 2014 05:29:10 PM Lucas Stach wrote:
> >> If the regulator connected to the CPU voltage plane doesn't
> >> support an OPP specified voltage with the acceptable tolerance
> >> it's better to just disable the OPP instead of constantly
> >> failing the voltage scaling later on.
> >>
> >> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> >> ---
> >> resend:
> >> - no functional change, split out from the imx5 cpufreq series
> >> v2:
> >> - rebase on top of pm/linux-next
> >
> > This makes sense to me, but I need ACKs from people who are more familiar
> > with OPPs in general.
> 
> @Rafael: Where is this gone?
> 
> http://permalink.gmane.org/gmane.linux.power-management.general/49384

OK, since this has been restored, what am I supposed to do with the
$subject patch?

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
