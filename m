From: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: Re: freeze_processes questions
Date: Wed, 06 Apr 2005 09:10:41 +1000
Message-ID: <1112742641.3757.58.camel@desktop.cunningham.myip.net.au>
References: <200504051120.44496.rjw@sisk.pl>
	<200504052002.30245.rjw@sisk.pl> <20050405203753.GC1380@elf.ucw.cz>
	<200504060046.18159.rjw@sisk.pl>  <20050405225751.GA1353@elf.ucw.cz>
Reply-To: ncunningham@cyclades.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============99975935347557354=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050405225751.GA1353@elf.ucw.cz>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============99975935347557354==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi.

On Wed, 2005-04-06 at 08:57, Pavel Machek wrote:
> Hi!
> 
> > > > 2) We can try to force uninterruptible tasks to get their "signals" anyway using
> > > > wake_up_state() directly on them (which I don't like as much).
> > > 
> > > They are probably uninterruptible for a reason...
> > > 
> > > If something is staying in UNINTERRUPTIBLE for more than 1 second, it
> > > is going to cause problems elsewhere, anyway. Do you see that happening?
> > 
> > Probably.  Please see, for example, this message sent to l-k:
> > 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=111268969510393&w=2
> 
> ...hmm, perhaps kseriod needs suspend/resume support, or something;
> but that does not mean we should handle *all* uninterruptible tasks
> that way.
> 
> > I can easily trigger a similar behavior with an uninterruptible task and I
> > have some problems with freezing tasks on SMP that smell like this too.
> > 
> > If we are going to ignore uninterruptible tasks, I'd propose to set PF_FREEZE
> > and TIF_SIGPENDING for them without counting them as "todo" in
> 
> You can't just ignore uninterruptible tasks, sorry.

I don't think Rafael is suggesting ignoring them. He's suggesting what
I'm already doing:
- Signal so they enter the freezer if they leave the state;
- Don't count them when deciding whether freezing failed;
- Handle the case where they don't leave the state until post resume (I
let them enter the refrigerator, but have code in there to check whether
the freezer is still on).

In this way, I handle kseriod and anything else uninterruptible without
any problems.

> OTOH, if you want working refrigerator, Nigel has one ;-). We were
> talking about merging it to mainline few times already...

Sorry. I keep getting preoccupied with other things. I'll get my act
together :>

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net


--===============99975935347557354==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============99975935347557354==--
