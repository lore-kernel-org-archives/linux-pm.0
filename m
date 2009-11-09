From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Help needed: Resume problems in 2.6.32-rc,
	perhaps related to preempt_count leakage in keventd
Date: Mon, 9 Nov 2009 16:47:03 +0100
Message-ID: <200911091647.03502.rjw__23233.2618827515$1257781652$gmane$org@sisk.pl>
References: <200911091250.31626.rjw@sisk.pl> <200911091526.02147.rjw@sisk.pl>
	<1257777896.6365.21.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1257777896.6365.21.camel@marge.simson.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mike Galbraith <efault@gmx.de>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday 09 November 2009, Mike Galbraith wrote:
> On Mon, 2009-11-09 at 15:26 +0100, Rafael J. Wysocki wrote:
> 
> > Well, I can add the printk(), but I can't guarantee that I will get the call
> > trace once again.  So far I've seen it only once after 20-25 consecutive
> > suspend-resume cycles, so ...  you get the idea.
> > 
> > However, running on a wrong CPU would very nicely explain all of the observed
> > symptoms, so I guess we can try a House M.D.-alike approach and assume that the
> > answer is "yes, we're running on the wrong CPU".  What would we do next if that
> > was the case?
> 
> If you're interested in trying a patch, I have a couple that fix things
> up here.  My "get a bigger hammer" patch would be best if it's what I
> think it is.  If it only fails once in a blue moon though, maybe not
> worth even trying.  If I could suspend/resume, I'd try it myself, but I
> have (steenking) nvidia card.  No eyecandy or resume for me, though I
> can suspend... once.

OK, please send me (a) poiter(s) to the patches.

I'll first try the patch you've just sent and report back. 

Thanks,
Rafael
