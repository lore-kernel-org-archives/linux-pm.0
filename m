From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] cpufreq: cpufreq-cpu0: Use a sane boot frequency when
 booting with a mismatched bootloader configuration
Date: Tue, 19 Nov 2013 10:21:35 +0800
Message-ID: <20131119022133.GB18434@S2101-09.ap.freescale.net>
References: <1384568535-26611-1-git-send-email-nm@ti.com>
 <20131116134445.GI11014@S2101-09.ap.freescale.net>
 <CAKohponU-WFnG8Gx6ba=k3eJmWV_0eWtpsy9kDP8yA2KrdoKtg@mail.gmail.com>
 <528A27F8.3070402@ti.com>
 <20131118155753.GU11014@S2101-09.ap.freescale.net>
 <528A4340.3020508@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <528A4340.3020508@ti.com>
Sender: cpufreq-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Carlos Hernandez <ceh@ti.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 18, 2013 at 10:41:36AM -0600, Nishanth Menon wrote:
> In the case of mismatch, to consider that device tree may be wrong in
> driver is also to assume that hardware was always configured correctly
> and we assume description is the flawed data.

No, I did not say that.  IMO, when cpufreq-cpu0 sees a mismatch, it has
no way to know or assume which one is correct and which is incorrect.
The best thing it can do is to fail out without changing anything about
running frequency and voltage.

Shawn

> That is just plain
> wrong. we need to assume device tree is the correct description of the
> hardware and any mismatch must be assumed as bad configuration - and
> this is what the patch does.
> 
> Now, if the description is wrong, that is a dts bug of it's own.
> 
> If the suggestion is to improve my commit message, I am more than
> happy to do so - please suggest how I could improve the same.

