From: Pavel Machek <pavel@ucw.cz>
Subject: Re: sleepy linux self-test
Date: Sat, 2 Feb 2008 20:59:56 +0100
Message-ID: <20080202195956.GC31621__7676.50249549678$1201982481$gmane$org@elf.ucw.cz>
References: <20080130131748.GA3796@elf.ucw.cz>
	<200802020931.38689.david-b@pacbell.net>
	<20080202180002.GB26560@elte.hu>
	<200802021113.22130.david-b@pacbell.net>
	<20080202193202.GB31621@elf.ucw.cz>
	<20080202193843.GB32039@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080202193843.GB32039@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-pm@lists.linux-foundation.org, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat 2008-02-02 20:38:43, Ingo Molnar wrote:
> 
> * Pavel Machek <pavel@ucw.cz> wrote:
> 
> > > It would have been easier to just use the public interface and 
> > > hard-wire "rtc0".  But going directly to the hardware was dirtier, 
> > > and more in the spirit of "hack that obviously shouldn't go upstream 
> > > until it gets done properly".
> > 
> > Yes, it was "quick and dirty". And I do not think it is going upstream 
> > in this form...?
> 
> which would be a pity - this thing _almost_ started doing suspend and 
> resume cycles on my testsystems, all by itself :-)

...which is good reason for me to create cleaned-up patch, right?

wakeup in .c now works, so I actually have time to do it now.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
