From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Resume hanging on MSI motherboard
Date: Tue, 8 Dec 2009 13:38:56 +0100
Message-ID: <200912081338.56941.rjw@sisk.pl>
References: <20091204081739.575b29d5@mjolnir.ossman.eu>
	<20091208090327.3ac443e9@mjolnir.ossman.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091208090327.3ac443e9@mjolnir.ossman.eu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Pierre Ossman <pierre-list@ossman.eu>
List-Id: linux-pm@vger.kernel.org

On Tuesday 08 December 2009, Pierre Ossman wrote:
> Anyone?

Sorry, it's just difficult to advise something in this case.

You can try to use the /sys/power/pm_test tests to see if the problem is
related to the drivers (it is described in
Documentation/power/basic-pm-debugging.txt), but I bet it's not.

> On Fri, 4 Dec 2009 08:17:39 +0100
> Pierre Ossman <pierre-list@ossman.eu> wrote:
> 
> > I have a MSI Neo2-Digital board that I'm trying to get suspend working
> > on. I'm not having much luck though, so I need some pointers on how to
> > debug this.
> > 
> > The symptoms are that the machine shuts down when suspend is triggered
> > and wakes up when the power button is pressed or an usb device pokes
> > it. Unfortunately it never gets back to a running state. It rattles a
> > bit on the disk, powers up the fans and turns on the LEDs, but that's
> > it.
> > 
> > Doing a suspend in Windows has entirely different behaviour. There it
> > keeps all fans running, and doesn't do much in the way of saving power.
> > It goes from 90 W to 67 W from idle to "standby". The [broken] state
> > Linux puts the system in OTOH runs at 13 W ("off" is 10 W).
> > 
> > I've been trying to use pm_trace to debug where things lock up, but I'm
> > not able to get it to work. I do "echo 1 > /sys/power/pm_trace" and
> > then suspend the machine. But at the next boot, the clock is still sane
> > so it seems like the PM code never stores anything.
> > 
> > Help :/

Thanks,
Rafael
