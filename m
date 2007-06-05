From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Linux 2.6.22-rc4
Date: Tue, 5 Jun 2007 22:16:43 +0200
Message-ID: <20070605201643.GA4424__23547.5728208714$1181074672$gmane$org@elf.ucw.cz>
References: <alpine.LFD.0.98.0706042040350.23741@woody.linux-foundation.org>
	<4665B169.2030803@googlemail.com>
	<alpine.LFD.0.98.0706051219560.4921@woody.linux-foundation.org>
	<20070605193718.GB24877@elte.hu>
	<alpine.LFD.0.98.0706051245190.4921@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0706051245190.4921@woody.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, linux-pm@lists.linux-foundation.org, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: linux-pm@vger.kernel.org

Hi!

> > isnt the refrigerator() suspend related? Perhaps suspend disables irqs 
> > somewhere that we forgot to track?
> 
> There _is_ something strange there. For that whole sequence to trigger, 
> the current task has to have the TIF_FREEZE bit set, but I don't see why 
> it would be during shutdown.

[  116.733327] PM: suspend-to-disk mode set to 'shutdown'
[  116.738849] swsusp: Basic memory bitmaps created
[  116.745353] Stopping tasks ... WARNING: at
/home/devel/linux-git/kernel/lockdep.c:2414 check_flags()
[  116.754921]  [<c0404fbf>] show_trace_log_lvl+0x1a/0x2f
[  116.754937]  [<c0405bd6>] show_trace+0x12/0x14

No, he's not shutting down, he's trying to snapshot his
machine. 'shutdown' will be done at end of hibernation, _way_ after
this.

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
