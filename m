From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: cpufreq-cpu0: Use a sane boot frequency when
 booting with a mismatched bootloader configuration
Date: Tue, 19 Nov 2013 09:16:59 +0530
Message-ID: <CAKohpok_yRZr-XQEC+w8PLN+ZyW83uijFyZrDM1LB8G2X4h-fg@mail.gmail.com>
References: <1384568535-26611-1-git-send-email-nm@ti.com>
	<20131116134445.GI11014@S2101-09.ap.freescale.net>
	<CAKohponU-WFnG8Gx6ba=k3eJmWV_0eWtpsy9kDP8yA2KrdoKtg@mail.gmail.com>
	<528A27F8.3070402@ti.com>
	<20131118155753.GU11014@S2101-09.ap.freescale.net>
	<528A4340.3020508@ti.com>
	<20131119022133.GB18434@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20131119022133.GB18434@S2101-09.ap.freescale.net>
Sender: cpufreq-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Carlos Hernandez <ceh@ti.com>
List-Id: linux-pm@vger.kernel.org

On 19 November 2013 07:51, Shawn Guo <shawn.guo@linaro.org> wrote:
> No, I did not say that.  IMO, when cpufreq-cpu0 sees a mismatch, it has
> no way to know or assume which one is correct and which is incorrect.
> The best thing it can do is to fail out without changing anything about
> running frequency and voltage.

Not specifically on this patch, but this is what I feel about this issue:

- As we are discussing on the other thread, there is scope of adding
"unknown" field in tables so that people would know that they were
running out of table freq at some point..
- This is a common problem for all drivers/platforms and not only
cpufreq-cpu0, so the solution has to be generic and not driver
specific.. So, atleast I don't want to get this patch in at any cost,
unless there is a generic solution present..
- There are non-dt drivers as well, and so freq table is present
with the kernel and we can't support all frequencies that bootloader
may end up with..

--
viresh
