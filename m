From: Pavel Machek <pavel@ucw.cz>
Subject: Re: sleepy linux self-test
Date: Sun, 10 Feb 2008 22:02:58 +0100
Message-ID: <20080210210258.GH15662__13920.8666551442$1202678977$gmane$org@elf.ucw.cz>
References: <20080130131748.GA3796@elf.ucw.cz>
	<20080202193202.GB31621@elf.ucw.cz>
	<20080202193843.GB32039@elte.hu>
	<200802021837.17777.david-b@pacbell.net>
	<20080203050537.GA18942@elte.hu> <20080203051425.GA20740@elte.hu>
	<20080203051953.GA21183@elte.hu> <20080203053507.GA21681@elte.hu>
	<20080203055429.GA24996@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080203055429.GA24996@elte.hu>
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

Hi!

> >  [   23.893598] Calling initcall 0xc0c518b0: be_sleepy+0x0/0x170()
> >  [   23.901601] PM: no wakelarm-capable RTC
> >  [   23.905599] initcall 0xc0c518b0: be_sleepy+0x0/0x170() returned 0.
> >  [   23.910879] initcall 0xc0c518b0 ran for 3 msecs: be_sleepy+0x0/0x170()
> > 
> > so close, yet so far away :-)
> 
> good news: the suspend+resume self-test works perfectly now! :-)

Good. What's next here? Will you just merge it to -x86, meaning it is
planned for 2.6.26?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
