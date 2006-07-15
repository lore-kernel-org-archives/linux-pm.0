From: Pavel Machek <pavel@suse.cz>
Subject: Re: [linux-pm] Kernel panic after resuming from S4 on Napa dual-core.
Date: Sat, 15 Jul 2006 12:04:05 +0000
Message-ID: <20060715120405.GB9849@ucw.cz>
References: <076F541A621E59428B837DCEA0AEDB587A227B@bjsmsx401>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <076F541A621E59428B837DCEA0AEDB587A227B@bjsmsx401>
Sender: linux-acpi-owner@vger.kernel.org
To: "Hu, Fenghua" <fenghua.hu@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.osdl.org, lhcs-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

On Wed 12-07-06 09:29:40, Hu, Fenghua wrote:
> Hi all,
> 
> I am struggling with a S4 issue. On a Napa dual-core laptop, sometimes
> when resuming from S4, kernel panic occurs, then system reboots. After
> some investigation, I found it's due to CPU1(AP) can't be woken up in
> time, and
> this can be alleviated, even eliminated by introducing more delay in
> function wakeup_secondary_cpu().In official kernel tree, there were
> three lines in this function for delaying: mdelay(10), udelay(300) and
> udelay(200), now I changed them all to mdelay(500). Seems incorrect
> timing has led to the issue. Could you help me to root cause it? Thanks.

Do you have a copy of panic message and a patch? Or perhaps you just
want to ask on lkml for testing?

-- 
Thanks for all the (sleeping) penguins.
