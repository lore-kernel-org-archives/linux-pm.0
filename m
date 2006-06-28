From: "Matt Sealey" <matt@genesi-usa.com>
Subject: Re: PowerPC cpufreq using ICTC
Date: Wed, 28 Jun 2006 03:04:06 -0500
Message-ID: <008101c69a89$6fd20630$99dfdfdf@bakuhatsu.net>
References: <1151450597.2350.110.camel@localhost.localdomain>
Reply-To: matt@genesi-usa.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1151450597.2350.110.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: 'Benjamin Herrenschmidt' <benh@kernel.crashing.org>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

 =


> -----Original Message-----
> From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org] =

> Sent: Tuesday, June 27, 2006 6:23 PM
> To: matt@genesi-usa.com
> Cc: linux-pm@lists.osdl.org
> Subject: Re: [linux-pm] PowerPC cpufreq using ICTC
> =

> On Tue, 2006-06-27 at 09:56 -0500, Matt Sealey wrote:
> =

> > I'm looking at it from the point of view of the Pegasos =

> > (www.pegasosppc.com) because right now we only have G3 =

> (750CXe) and G4 =

> > (7447) processor cards which do not support DFS.
> =

> 7447A is supposed to support it no ?

Yeah but we don't ship that processor card (nor a 7448 even
though we have the design and prototypes) and right now.. I
doubt we ever will considering the cost and rather unnoticable
performance improvement in the heavy stuff. Unfortunately there
aren't many customers out there who want do to the kind of
benchmarks you see on the EEMBC scores, the ones that make the
G4 shine, they just want to run MySQL or GNOME..

> >  The G3 is fanless so there is no scope to reduce noise =

> > dynamically or  turn the fan off,
> =

> Also G3 generally support at least DOZE mode when idle, =

> unlike the 7447 where all you have is NAP which is better, =

> but requires proper northbridge support... I would be =

> surprised if the Discovery II used on the Pegasos supports =

> that properly and without funky bugs...

I can find out pretty quickly.. when Gerald gets back in the
office.. *stares at the door*.

> I'm not sure a cpufreq driver is the best thing to do but =

> let's first simply measure if ICTC helps at all... it should =

> be fairly trivial to do a simple kernel module to tweak the value.

One of those links had one (maybe a year old) with a sysfs entry
to mess with. Unfortunately! I don't have the resources to really
test it here without dragging a couple guys away from real important
work. It *DOES* work but I'll be damned if I can see any difference
apart from the speed on the G4, and I don't have a G3 handy to check
the temperature.

-- =

Matt Sealey <matt@genesi-usa.com>
Manager, Genesi, Developer Relations
