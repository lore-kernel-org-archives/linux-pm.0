From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: cpufreq-next opps with cpufreq-bench
Date: Wed, 16 Oct 2013 12:40:11 +0200
Message-ID: <2640083.dKj7t8UqiF@vostro.rjw.lan>
References: <20131013090159.GB24566@lunn.ch> <2502389.2uE805jDh9@vostro.rjw.lan> <CAKohponEEagXGYOXYXrAqdDJn23Po6=sVhpZEO_+Sta8MUY-XA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52018 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1760554Ab3JPK2V (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2013 06:28:21 -0400
In-Reply-To: <CAKohponEEagXGYOXYXrAqdDJn23Po6=sVhpZEO_+Sta8MUY-XA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, linux-pm@vger.kernel.org

On Wednesday, October 16, 2013 09:49:02 AM Viresh Kumar wrote:
> 
> --047d7b6d91a050552f04e8d40024
> Content-Type: text/plain; charset=ISO-8859-1
> 
> On 16/10/2013, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > Well, I've dropped the offending commit from my queue.  Hopefully, it still
> > builds on all targets it used to build on.
> 
> Thanks!!
> 
> I tried to reproduce it 2 days back and my laptop was almost completely
> discharged and I have left my charger at a friends place last week :(
> So couldn't really do anything until then.. Got my charger today and so
> coming back on this..
> 
> I couldn't run and find cpufreq-bench on ubuntu (Is it available?)..
> But I think I have found the problem..
> 
> @Andrew: Can you give this a try please? (Use attached commit)..

No.

Please resumbit the original commit *with* the fix folded into it.

Since I have dropped the broken one from linux-next, this "fixup" doesn't
apply to it any more.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
