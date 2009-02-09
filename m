From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 05/13] PM: Add option to disable
	/sys/power/state interface
Date: Mon, 9 Feb 2009 10:09:35 +0100
Message-ID: <20090209090935.GD28794@atrey.karlin.mff.cuni.cz>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<200902081450.46584.rjw@sisk.pl>
	<20090208140404.GA22084@bulgaria.corp.google.com>
	<200902090040.22364.rjw@sisk.pl>
	<d6200be20902081558r272e13b1q28692eaba758878b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d6200be20902081558r272e13b1q28692eaba758878b@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve Hj?nnev?g <arve@android.com>
Cc: ncunningham@crca.org.au, u.luckas@road.de, Brian Swetland <swetland@google.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> On Sun, Feb 8, 2009 at 3:40 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Sunday 08 February 2009, Brian Swetland wrote:
> >> Out of curiosity, do these changes provide a model where the system can
> >> be in suspend 99+% of the time, waking up for specific events
> >> (voice/data telephony, user interaction, etc), and rapidly returning to
> >> suspend when the processing required is complete?
> >
> > The changes I was referring to above were rather related to the "normal"
> > suspend (ie. the one happening as a result of writing "mem" into
> > /sys/power/state).  Namely, we believe that for some devices it is not
> > necessary or even desirable to allow the driver to perform all of the power
> > management operations by itself.  For example, we are going to make the PCI
> > PM core (which in fact is the PCI bus type driver) handle the saving and
> > restoration of PCI devices' configuration registers as well as putting the
> > devices into low power states and back into the full power state.  We can do
> > that, because in the "normal" suspend code path the suspend routines of a
> > driver are executed by the appropriate bus type's suspend routines and not
> > directly by the PM core.  The "early suspend" mechanism seems to go round this
> > by calling directly into device drivers.
> 
> How do you handle devices that should be in a low power mode when
> closed, and a high(er) power mode when open. While adding
> early-suspend hooks to a driver may be ugly, it does not need any more
> support than open and close does.

I put the device to low power mode when its close() is called, and I
pull it back up when open() is called....? Every well-behaved driver
should do that, even on PC.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
