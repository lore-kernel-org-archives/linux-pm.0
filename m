From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [GIT PULL] ARM: CPUFreq updates for 3.11
Date: Mon, 24 Jun 2013 16:40:27 +0530
Message-ID: <CAKohpomdnEgDcAExoyN1b4vohHNEg3NDH1mM8NWG8gQoPvff+Q@mail.gmail.com>
References: <CAKohpo=v4qPDH32Y4ithr_p007nTn5AOUzkUCiHTGgQN6-=BEw@mail.gmail.com>
	<1524748.bV9OZAOR0D@vostro.rjw.lan>
	<CAKohpomThmZFKTufBzWpmokqqZJ8C6DtGTKTzBY=OxJPNT-BmA@mail.gmail.com>
	<7195611.gCcafMWC85@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <7195611.gCcafMWC85@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: cpufreq@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Lists linaro-kernel <linaro-kernel@lists.linaro.org>
List-Id: linux-pm@vger.kernel.org

On 24 June 2013 16:29, Rafael J. Wysocki <rjw@sisk.pl> wrote:

> In your original series that patch was the last one.  What made you change your
> mind and put it in front?

I initially thought that this one would break git bisect (code would
compile, but would fail) for platforms whose code I have fixed in
this patchset.

But that is true only for failure cases, otherwise code would work as
normal.

And hence kept this at the top this time.
