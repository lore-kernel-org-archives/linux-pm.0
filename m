From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm 3/3] PM: Disable _request_firmware
	before hibernation/suspend
Date: Mon, 28 May 2007 20:57:27 +0000
Message-ID: <20070528205727.GA5911@ucw.cz>
References: <20070528161242.GA1063@srcf.ucam.org>
	<Pine.LNX.4.44L0.0705281237200.22682-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0705281237200.22682-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > I can't speak for the second example, but there's a good reason the
> > > first example works this way.  It's not a matter of races; the problem
> > > is that the kernel thread's job is to selectively suspend and resume
> > > devices.  We don't want it doing this while a system sleep is in 
> > > progress; it would (and in fact has, before the thread was made 
> > > freezable) cause the sleep transition to abort.
> > 
> > How does this work on PPC or APM systems?
> 
> For hibernation it behaves the same as on other types of systems.
> 
> For STR it generally works okay.  There was one report of suspends
> aborting, and it looked like this was caused by selective resumes
> originating from userspace.  This seemed to be unrelated to the kernel
> threads; apparently some program was running while the STR was in
> progress, and causing the problem.  For example, the lsusb program will
> do a selective resume on every USB device as it scans through them all.
> However that's just a guess, we haven't fully resolved that bug report.
> 
> The theoretical answer is that it behaves the way we want.  The kernel 
> thread does selective resumes in response to device requests.  If such 
> a request comes in while the system is asleep it will awaken the 
> system; so it's only logical that a request coming in while the system 
> is in the process of going to sleep should abort the suspend.

I'd say that it shows ppc being broken. User wanted to suspend the
system, and now unrelated task did lsusb... and system will not sleep.

AFAICT it is DoS issue -- if one of your users keeps doing lsusb, root
will not be able to suspend the system.
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
