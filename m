From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Suspend, followed by immediate resume
Date: Wed, 14 May 2008 16:43:57 +0200
Message-ID: <20080514144357.GC6260@ucw.cz>
References: <20080501214437.0ae618c5@osprey.hogchain.net>
	<200805021859.57457.rjw@sisk.pl>
	<20080502122910.429312a7@osprey.hogchain.net>
	<200805021941.08003.rjw@sisk.pl>
	<20080502131003.15f45b82@osprey.hogchain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080502131003.15f45b82@osprey.hogchain.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jay Cliburn <jacliburn@bellsouth.net>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > Does it suspend if you don't activate the WOL?
> 
> Yes, it suspends even if WOL is disabled.
> 
> I poked around in BIOS and changed the behavior somewhat.  There's a
> BIOS setting called "Suspend Mode" with three options:
> 
> 	S1 (POS) only
> 	S3 only
> 	Auto
> 
> When set to "S3 only" or "Auto," the machine spontaneously resumes
> following a suspend.  When set to "S1 (POS) only" the machine stays
> asleep.
> 
> What is "POS" an acronym for?  Does it make sense to leave the thing
> set to "S1 only?"

Pile of s*t?
Point of sales?

S1 may make sense for testing wake-on-lan, yes. It is pretty useless
otherwise.

You should be able to do echo 1 > /proc/acpi/sleep to emulate it...

							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
