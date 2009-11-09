From: Mike Galbraith <efault@gmx.de>
Subject: Re: Help needed: Resume problems in 2.6.32-rc,
 perhaps related to preempt_count leakage in keventd
Date: Mon, 09 Nov 2009 15:44:56 +0100
Message-ID: <1257777896.6365.21.camel__32778.2435146675$1257777993$gmane$org@marge.simson.net>
References: <200911091250.31626.rjw@sisk.pl> <20091109124937.GA21114@elte.hu>
	<alpine.LFD.2.00.0911091452300.2725@localhost.localdomain>
	<200911091526.02147.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200911091526.02147.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2009-11-09 at 15:26 +0100, Rafael J. Wysocki wrote:

> Well, I can add the printk(), but I can't guarantee that I will get the call
> trace once again.  So far I've seen it only once after 20-25 consecutive
> suspend-resume cycles, so ...  you get the idea.
> 
> However, running on a wrong CPU would very nicely explain all of the observed
> symptoms, so I guess we can try a House M.D.-alike approach and assume that the
> answer is "yes, we're running on the wrong CPU".  What would we do next if that
> was the case?

If you're interested in trying a patch, I have a couple that fix things
up here.  My "get a bigger hammer" patch would be best if it's what I
think it is.  If it only fails once in a blue moon though, maybe not
worth even trying.  If I could suspend/resume, I'd try it myself, but I
have (steenking) nvidia card.  No eyecandy or resume for me, though I
can suspend... once.

	-Mike
