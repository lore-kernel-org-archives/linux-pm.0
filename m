From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: 3.10-rcX: cpu governor ondemand doesn't scale well after s2ram
Date: Thu, 4 Jul 2013 13:28:55 +0530
Message-ID: <CAKohpo=O0P9tKq5QFMhotvErcHnt9haJw3N-p9p0cZOa1t-SRQ@mail.gmail.com>
References: <51C08370.4050906@gmx.de>
	<CAKohpok1gThXL925Yz5UgC54vTVQgymBA1cLGER_g-dgZu0JLA@mail.gmail.com>
	<51CF1E53.6060902@gmx.de>
	<8029836.CFiJCXmRQ0@vostro.rjw.lan>
	<51D05DF4.50704@linux.vnet.ibm.com>
	<51D06556.7080204@gmx.de>
	<51D47FB0.5090604@gmx.de>
	<51D51C63.2080702@linux.vnet.ibm.com>
	<CAKohpomfM55cRfLOohpv4nhLBcwVcD-y3-WcYOaznVhA6H2TAw@mail.gmail.com>
	<51D51F63.8080905@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <51D51F63.8080905@linux.vnet.ibm.com>
Sender: cpufreq-owner@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 4 July 2013 12:38, Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com> wrote:
> Coming to git bisect, I think it needs to be done between a66b2e5 + this-patch
> and 3.10 + this-patch, to ensure that we look for problematic commits in-between
> a66b2e5 and 3.10 (to avoid the bisect result ending up at a66b2e5 again).

Exactly!!
