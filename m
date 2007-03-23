From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Fri, 23 Mar 2007 22:08:04 +0100 (CET)
Message-ID: <Pine.LNX.4.60.0703232158090.5971@poirot.grange>
References: <200703221344.l2MDi2Q9007989@olwen.urbana.css.mot.com>
	<200703221655.17693.david-b@pacbell.net>
	<Pine.LNX.4.60.0703230745070.4651@poirot.grange>
	<200703230915.12117.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703230915.12117.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: alexey.y.starikovskiy@intel.com, dirk.behme@de.bosch.com, pavel@ucw.cz, linux-pm@lists.linux-foundation.org, johannes@sipsolutions.net, nico@cam.org, ben@simtec.co.uk
List-Id: linux-pm@vger.kernel.org

On Fri, 23 Mar 2007, David Brownell wrote:

> On Thursday 22 March 2007 11:46 pm, Guennadi Liakhovetski wrote:
> > On Thu, 22 Mar 2007, David Brownell wrote:
> > =

> > > So the fundamental definition needs to be in relative terms,
> > > because platform-specific differences otherwise make trouble.
> > =

> > What if we define system-wide and per device power states in terms of =

> > time? Time needed for the system / device to become fully operational =

> > again? And you'd need a user-space calibration daemon...
> =

> So if you take two otherwise identical systems and clock one slower
> than the other, then "standby" may become "suspend-to-RAM"?
> =

> Yuck.  No.  Speed is only a factor in that STR is likely slower.

I'm just trying to think about it from the user perspective. As a user I =

want - save the system save some power but be ready again when I need it =

_not_ _later_ than, 10 sec after wakeup. I don't care how it is called. I =

want to save as much power as possible and I want a certain wakeup time. =

Yes, if one system in your example is clocked slower, then yes, saying "I =

want it back up and running 5 seconds after wakeup" will for one of them =

mean "standby" for another one "str". As a user I don't care whatsoever =

what PCI state you drive my eth card into. I want it back in 5 seconds.

Similarly for single devices: I don't need wlan now, but when I need it I =

want it to be available in less than 2 seconds.

And if I say 10 minutes hibernate it.

If I say "don't care about time, save maximum power" - similarly.

And I may say "I want it wakeable from eth" or "from modem" take that into =

account too.

Those would be policies to be implemented in the user space. The kernel =

might just present a single numerical per-device parameter "wakeup =

responsiveness", and a way to do this system-wide.

Thanks
Guennadi
---
Guennadi Liakhovetski
