From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [RFC] Driver States
Date: Thu, 31 Mar 2005 20:01:15 -0800
Message-ID: <200503312001.15646.david-b@pacbell.net>
References: <1111963367.3503.152.camel@localhost.localdomain>
	<20050328092925.2c2736de@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============34371204568502234=="
Return-path: <linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
In-Reply-To: <20050328092925.2c2736de-aftB2sG12IhaqnLngUycEA@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--===============34371204568502234==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 28 March 2005 8:29 am, Jordan Crouse wrote:
> > struct device_driver {
> 
> Its still in debate, but if we decide to do centralized policy
> management (like DPM), then we will need some way to pass in attributes
> such as device inactivity timeout to the device. 

Device inactivity is a good example of something that's _already_ done
in a well-decentralized manner.  E.g. X11/DPMS, and hdparm.  If you're
after a motivation to adopt the MontaVista DPM model, that undermines
your argument ...


> Personally, I would be 
> happy with a call that passed a pointer for flexibility,  but it seems
> that recently, people are heavily favoring arguments that can be
> typchecked.

Pointers can easily be type-checked.  :)


> [ As an aside, I think that deciding where policy management will live
> will help clear up some of the nagging issues we've been having about
> the role of the drivers vs. the role of the system, etc, etc. ]

I think system policy should live at the system level, and driver policy
should live at the driver level.  Simple.  ;)

 
> > A table could be defined that indicates what should be called for each
> > power level transition.  *suspend and *resume could handle any extra
> > steps (ex. saving state).  As an example, *start and *stop may only be
> > called when power is going to be lost entirely.
> 
> I think we discussed this during the IRC meeting.  I certainly don't
> favor multiple calls which increase the level of complexity of the
> calling entity.  

It's a tradeoff.  Needless complexity should be avoided, of course.
Device driver authors should have only a limited slate of system-wide
issues to cope with ... which argues more for keeping complexity in
the core.  On the other hand, complex core logic can be hard to maintain
and error prone too.


> I would need one table to tell me what power level the 
> device should be at, and a second table to tell me if I need to call
> stop() or start().  Furthermore some devices may go clocks off during
> one S-T-R transition, and then keep clocks on for wake another time. 

Same is true for power, not just for clocks:  both get switched on/off.


> Our current thinking is to assume that the driver is intelligent enough
> to know what to do for any given power level, and I think a single call
> would suffice for that.

There's also system configuration to think of.  A recent example:  a
device should turn off several controllers whenever it's not hooked
up to its docking station (with power supply).  Regardless of whatever
else the other system power state(s) may be.

Some of these issues are completely orthogonal to other issues about
system state.  You're right that these are examples of places where
the intelligence is best kept at the _driver_ level ... in this case,
the driver that handles the "I'm docked!" IRQ is the natural place to
know what devices a given docking configuration should activate.

- Dave


--===============34371204568502234==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============34371204568502234==--
