From: Ingo Molnar <mingo@elte.hu>
Subject: Re: sleepy linux self-test
Date: Sat, 2 Feb 2008 19:00:02 +0100
Message-ID: <20080202180002.GB26560__30958.5693445571$1201975369$gmane$org@elte.hu>
References: <20080130131748.GA3796@elf.ucw.cz>
	<200801311755.33899.david-b@pacbell.net>
	<20080202124759.GB25773@elf.ucw.cz>
	<200802020931.38689.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200802020931.38689.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.linux-foundation.org, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


* David Brownell <david-b@pacbell.net> wrote:

> > > Plus, the way you're doing it now is violating the locking 
> > > protocol used by that driver.
> > 
> > Yep, you are right, but that is the easy issue to fix.
> 
> Which is why I was puzzled that you didn't start out doing it the 
> "right" way ... even just hard-wiring the dubious assumption that 
> "rtc0" is the right RTC to use.  :)

because this was mostly about an quick & easy hack to see whether it 
makes sense at all to automate the testing of suspend/resume. (People 
who want to use RTC functionality might not have the desire to get into 
extending it straight away - they just want something rather obvious 
done and that's it.)

	Ingo
