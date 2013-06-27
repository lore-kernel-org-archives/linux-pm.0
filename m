From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: 3.10-rcX: cpu governor ondemand doesn't scale well after s2ram
Date: Thu, 27 Jun 2013 09:40:53 +0530
Message-ID: <CAKohpokbQS8Bb5D2B_UaN-eyVnAbQYKDKh5pm_QzEDMoABwcOw@mail.gmail.com>
References: <51C08370.4050906@gmx.de>
	<1778593.ufLkNuJuaY@vostro.rjw.lan>
	<51CB34A2.7090404@gmx.de>
	<1475885.FjB577tJj8@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1475885.FjB577tJj8@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 27 June 2013 00:42, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Well, I'm not aware of any recent changes in cpufreq that would make things
> work differently depending on whether or not AC power is used.

Toralf,

It would be helpful if you can do git bisect and let us know which patch
created this problem. Otherwise its very difficult to trace it.
