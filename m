From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Wed, 4 Aug 2010 17:17:16 -0700
Message-ID: <20100805001716.GO24163__36349.0293537781$1280967492$gmane$org@linux.vnet.ibm.com>
References: <20100804185520.GA2417@srcf.ucam.org>
	<201008042251.08266.rjw@sisk.pl>
	<20100804205654.GA4986@srcf.ucam.org>
	<alpine.DEB.2.00.1008041529530.6545@asgard.lang.hm>
	<AANLkTimRZc2B1=ic-0jrGBX7ahCu=NCoQadCOePGDmh9@mail.gmail.com>
	<alpine.DEB.2.00.1008041554580.6545@asgard.lang.hm>
	<AANLkTingom2AKfMu0EbfdfLiMnHo+buy1e4=PBENf3Vi@mail.gmail.com>
	<alpine.DEB.2.00.1008041620010.6545@asgard.lang.hm>
	<20100804233013.GN24163@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008041643490.6545@asgard.lang.hm>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1008041643490.6545@asgard.lang.hm>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david@lang.hm
Cc: peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 04, 2010 at 04:49:22PM -0700, david@lang.hm wrote:
> On Wed, 4 Aug 2010, Paul E. McKenney wrote:
> 
> >On Wed, Aug 04, 2010 at 04:23:43PM -0700, david@lang.hm wrote:
> >>On Wed, 4 Aug 2010, Arve Hj?nnev?g wrote:
> >>
> >>>
> >>>We suspend as soon as no wakelocks are held. There is no delay.
> >>
> >>So, if I have a bookreader app that is not allowed to get the
> >>wakelock, and nothing else is running, the system will suspend
> >>immediatly after I click a button to go to the next page? it will
> >>not stay awake to give me a chance to read the page at all?
> >>
> >>how can any application run without wakelock privilages?
> >
> >Isn't a wakelock held as long as the display is lit, so that the
> >system would continue running as long as the page was visible?
> 
> what holds this wakelock, and what sort of timeout does it have?
> (and why could that same timeout be used in other ways instead)

I defer to the Android guys on what exactly holds the display's
wakelock.  The timeout is the display-blank timeout.

> how many apps really need to keep running after the screen blanks?
> there are a few (audio output apps, including music player and
> Navigation directions), but I don't have see a problem with them
> being marked as the 'trusted' apps to pay attention instead.

Downloading is another.

The music player is an interesting example.  It would be idle most
of the time, given that audio output doesn't consume very much CPU.
So you would not want to suspend the system just because there were
no runnable processes.  In contrast, allowing the music player to
hold a wake lock lets the system know that it would not be appropriate
to suspend.

Or am I misunderstanding what you are proposing?

> if the backlight being on holds the wakelock, it would seem that
> almost every other use of the wakelock could (and probably should)
> be replaced by something that tickles the display to stay on longer.

The problem with this approach is that the display consumes quite a
bit of power, so you don't want to leave it on unnecessarily.  So if
the system is doing something (for example, playing music) that does
not require the display, you really want the display to be off.

							Thanx, Paul
