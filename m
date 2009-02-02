From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions
Date: Mon, 2 Feb 2009 12:55:18 +0100
Message-ID: <20090202115518.GA4609@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0901311033590.6305-100000@netrider.rowland.org>
	<200901311939.30837.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200901311939.30837.rjw@sisk.pl>
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

Hi!

> However, I think that what we are used to call a sleep (or suspend) state is
> really a power off state for cell phone people.  So lets define what we're
> talking about.
> 
> Sleep states (suspend to RAM, hibernation) are the states of the whole system
> in which no instructions are executed by the processor(s).  The
> difference

s/processor(s)/CPU/.

Even in PC, you have keyboard controller running while sleeping. On
cellphone, you have some kind of pmu chip + GSM chip running. So
cellphone actually _is_ useful even when CPU is sleeping.

> between a sleep state and the power off state is that in a sleep state we have
> some application context saved (in memory or in a storage device) and
> (in principle) after the system goes back to the working state, the
> applications can continue doing do whatever they had been doing before the
> system was put into the sleep state.
> 
> If instructions are executed by the processor(s), the system is in the working
> state.

ACK.

> Well, I think that sleep states are not really useful in cell phones.  Useful
> is the ability to put all devices into low power states separately and as
> needed (eg. after a period of inactivity).  IOW, the system as a
> whole is

No, it does not work like that. Cellphone with sleeping CPU
(suspended-to-RAM) is still very useful.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
