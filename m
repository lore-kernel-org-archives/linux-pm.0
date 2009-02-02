From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions
Date: Mon, 2 Feb 2009 12:56:34 +0100
Message-ID: <20090202115633.GB4609@elf.ucw.cz>
References: <20090131074743.GA13633@bulgaria.corp.google.com>
	<Pine.LNX.4.44L0.0901311033590.6305-100000@netrider.rowland.org>
	<d6200be20901311441r8742b8em7201ce3713b8a54a@mail.gmail.com>
	<200902010020.04696.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200902010020.04696.rjw@sisk.pl>
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
Cc: Brian Swetland <swetland@google.com>, linux-pm@lists.linux-foundation.org, Nigel Cunningham <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

On Sun 2009-02-01 00:20:04, Rafael J. Wysocki wrote:
> On Saturday 31 January 2009, Arve Hj?nnev?g wrote:
> > On Sat, Jan 31, 2009 at 7:41 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> > > On Fri, 30 Jan 2009, Brian Swetland wrote:
> > >> Imagine the computer in question is a cellphone which is going to need
> > >> to wake up when a call comes in to do traditional cellphone things, like
> > >> ring, bring up the incall UI (so the user can answer/cancel), etc.
> > >
> > > Yes.  So what?  Nothing I said prevents the computer from waking up
> > > when a call comes in.  What I said was that when the user tells the
> > > computer to suspend (e.g., by writing "mem" to /sys/power/state), the
> > > computer should suspend even if some wakelocks are still locked.
> > 
> > But this could prevent the phone from ringing. What if the user-space
> > code that is responsible for playing the ringtone has been notified
> > that a call is coming in and starts reading the audio file with the
> > ringtone. At the same, the user, unaware that someone is calling,
> > presses the power button. If we ignore the wakelock in this situation,
> > the phone will not ring.

Yes, you don't want to write "mem" to /sys/power/state on android. You
want to write something like "auto-mem" there.

> What if the user decides to power off the phone and a call comes in at the
> same time?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
