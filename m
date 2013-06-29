From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: 3.10-rcX: cpu governor ondemand doesn't scale well after s2ram
Date: Sat, 29 Jun 2013 19:00:54 +0530
Message-ID: <CAKohpok1gThXL925Yz5UgC54vTVQgymBA1cLGER_g-dgZu0JLA@mail.gmail.com>
References: <51C08370.4050906@gmx.de>
	<1778593.ufLkNuJuaY@vostro.rjw.lan>
	<51CB34A2.7090404@gmx.de>
	<1475885.FjB577tJj8@vostro.rjw.lan>
	<CAKohpokbQS8Bb5D2B_UaN-eyVnAbQYKDKh5pm_QzEDMoABwcOw@mail.gmail.com>
	<51CC7DB2.3020502@gmx.de>
	<CAKohponp7JbQeeC7D=X7+DBcWtUr2NhRKz7spxKA=+K8SAY+Og@mail.gmail.com>
	<51CDAAF7.40101@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <51CDAAF7.40101@gmx.de>
Sender: cpufreq-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 28 June 2013 20:55, Toralf F=F6rster <toralf.foerster@gmx.de> wrote:
> n22 ~ # cat /sys/devices/system/cpu/cpu?/cpufreq/scaling_cur_freq
> 800000
> 800000
> 800000
> 800000
> n22 ~ # cat /sys/devices/system/cpu/cpu?/cpufreq/cpuinfo_cur_freq
> 800000
> 2601000
> 2601000
> 2601000

Hmm.. So this is what I make out of it.
scaling_cur_freq: is the freq which cpufreq core thinks is set. Which i=
s
correct. 800 MHz.

cpuinfo_cur_freq: is the actual freq in hardware, which is wrong.
@Rafael: If I am not wrong we have seen this earlier too in last few
months. There was some problem with bootloader or something else
I can't remember.
