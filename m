From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm 3/3] PM: Disable _request_firmware
	before hibernation/suspend
Date: Mon, 28 May 2007 20:59:51 +0000
Message-ID: <20070528205951.GB5911@ucw.cz>
References: <Pine.LNX.4.44L0.0705281151250.22682-100000@netrider.rowland.org>
	<200705281943.25129.rjw@sisk.pl>
	<2c0942db0705281351g450bd0c6u31e634757dfa8ac0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <2c0942db0705281351g450bd0c6u31e634757dfa8ac0@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ray Lee <ray-lk@madrabbit.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> >In fact, I'd like drivers to use notifiers to actually 
> >load the firmware into
> >memory before hibernation/suspend.  Namely, if there's 
> >PM_PRE_FREEZE, the
> >driver calls request_firmware() from within the 
> >notifier and saves the firmware
> >in memory for future use, if need be.  Later, when 
> >PM_POST_THAW comes, the
> >memory holding the firmware is released.
> >
> >Unfortunately there are drivers that call 
> >request_firmware() directly from
> >.resume() which blocks until timeout expires and fails 
> >anyway.  I just wanted
> >this to fail immediately, without waiting.
> 
> Stupid question time. Wouldn't it just be easier to have
> request_firmware() keep a copy of the firmware once it's 
> been loaded?
> We're not talking about a lot of memory that would be 
> wasted, and that
> way no drivers have to be changed.

Actually, I like this idea. Firmware problems magically disappear.

...unless someone uses x86 emulator in userland to POST graphics card.
You can't 'cache' that. But that's separate problem.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
