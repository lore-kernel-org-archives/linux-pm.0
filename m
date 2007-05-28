From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 1/3] PM: Hibernation and suspend
	notifiers
Date: Mon, 28 May 2007 19:29:37 +0200
Message-ID: <200705281929.38259.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0705281155270.22682-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0705281155270.22682-100000@netrider.rowland.org>
Content-Disposition: inline
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday, 28 May 2007 17:56, Alan Stern wrote:
> On Sun, 27 May 2007, Rafael J. Wysocki wrote:
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Make it possible to register hibernation and suspend notifiers, so that
> > subsystems can perform hibernation-related or suspend-related operations that
> > should not be carried out by device drivers' .suspend() and .resume() routines.
> 
> > +static DEFINE_MUTEX(pm_notifier_lock);
> > +
> > +static RAW_NOTIFIER_HEAD(pm_chain);
> 
> Is there any particular reason you chose to use a RAW_NOTIFIER_HEAD 
> with an explicit mutex instead of using a BLOCKING_NOTIFIER_HEAD?

Hmm, not really.  I based it on the CPU hotplug notifiers, actually.

I'll see if I can use BLOCKING_NOTIFIER_HEAD.

Greetings,
Rafael
