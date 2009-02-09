From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 05/13] PM: Add option to disable
	/sys/power/state interface
Date: Mon, 9 Feb 2009 09:58:54 +0100
Message-ID: <20090209085854.GA28794@atrey.karlin.mff.cuni.cz>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<200902090040.22364.rjw@sisk.pl>
	<d6200be20902081558r272e13b1q28692eaba758878b@mail.gmail.com>
	<200902090126.17899.rjw@sisk.pl>
	<d6200be20902081735l734ac6c9h811b8ad6f40e2562@mail.gmail.com>
	<20090209015333.GC24119@bulgaria.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090209015333.GC24119@bulgaria.corp.google.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Brian Swetland <swetland@google.com>
Cc: ncunningham@crca.org.au, u.luckas@road.de, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> [Arve Hj?nnev?g <arve@android.com>]
> > 
> > > Still, I'm very much interested in your reply to the last paragraph of my
> > > message, the one that you removed.
> > 
> > Yes we need access to wakelocks from user space. We also allow third
> > party apps to use wakelocks if they request the right permission. This
> > could include a music player keeping the device on while playing a
> > song, or an pop email client using an alarm to download email every
> > hour.
> 
> To expand on this a bit: We don't allow arbitrary apps to directly grab
> wakelocks with the sys interface -- instead a system service in
> userspace manages wakelock requests on behalf of apps needing them.

So in fact single wakelock for userspace would be enough for you?

Cool, that certainly makes user<->kernel interface easier.

OTOH "gcc now has to talk to system service" requirement is quite ugly.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
