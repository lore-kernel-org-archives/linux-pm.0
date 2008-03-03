From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] cpuidle: avoid singing capacitors
Date: Mon, 3 Mar 2008 21:46:03 +0100
Message-ID: <20080303204603.GA19775__42641.7375369512$1204577238$gmane$org@elf.ucw.cz>
References: <20080229193812.31f45b0c@mjolnir.drzeus.cx>
	<20080303211842.6f492782@mjolnir.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080303211842.6f492782@mjolnir.drzeus.cx>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>, Adam Belay <abelay@novell.com>, Andi Kleen <andi@firstfloor.org>, Lee Revell <rlrevell@joe-job.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> I've been playing around with this for a bit, and the jiffies approach
> just had too many gotchas. So I tried using the information that was
> already present in the menu governor. This is what I came up with.
> 
> It solves the primary problem of getting rid of the noise. I've also
> tried some crude power measurements and I couldn't get any difference
> with and without the patch. Powertop also nicely shows that the CPU is
> still spending almost all of its time in C3. Therefore, I'm letting the
> effects of it be enabled by default.
> 
> So I'm taking the [RFC] off it. Please still test and see that it
> solves the issue on other machines, and the it does not cause any big
> power surges.
> 
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> index 78d77c5..d9c43e3 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -16,6 +16,8 @@
>  
>  #define BREAK_FUZZ     4       /* 4 us */
>  
> +static unsigned int min_deep_sleep = 2000;
> +

Well, why not, but I believe we should default to old behaviour... not
all machines are cheaply-build.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
