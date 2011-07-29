From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v4 0/3] DEVFREQ,
	DVFS framework for non-CPU devices
Date: Fri, 29 Jul 2011 11:10:41 +0200
Message-ID: <201107291110.41801.rjw@sisk.pl>
References: <1310717510-19002-1-git-send-email-myungjoo.ham@samsung.com>
	<201107290010.53788.rjw@sisk.pl>
	<CAJOA=zNpmQpCyh0ow2q6gUTxkLMcWDsoMOaQEGzV4Sw__BszHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJOA=zNpmQpCyh0ow2q6gUTxkLMcWDsoMOaQEGzV4Sw__BszHg@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Turquette, Mike" <mturquette@ti.com>
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Friday, July 29, 2011, Turquette, Mike wrote:
> On Thu, Jul 28, 2011 at 3:10 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Friday, July 15, 2011, MyungJoo Ham wrote:
> >> For a usage example, please look at
> >> http://git.infradead.org/users/kmpark/linux-2.6-samsung/shortlog/refs/heads/devfreq
> >>
> >> In the above git tree, DVFS (dynamic voltage and frequency scaling) mechanism
> >> is applied to the memory bus of Exynos4210 for Exynos4210-NURI boards.
> >> In the example, the LPDDR2 DRAM frequency changes between 133, 266, and 400MHz
> >> and other related clocks simply follow the determined DDR RAM clock.
> >>
> >> The DEVFREQ driver for Exynos4210 memory bus is at
> >> /arch/arm/mach-exynos4/devfreq_bus.c in the git tree.
> >>
> >> MyungJoo Ham (3):
> >>   PM: Introduce DEVFREQ: generic DVFS framework with device-specific
> >>     OPPs
> >>   PM / DEVFREQ: add example governors
> >>   PM / DEVFREQ: add sysfs interface (including user tickling)
> >
> > OK, I'm going to take the patches for 3.2.
> 
> Have any other platforms signed up to use this mechanism to manage
> their peripheral DVFS?

Not that I know of, but one initial user is sufficient for me.
So if you have anything _against_ the patches, please speak up.

Thanks,
Rafael
