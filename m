From: Amit Kucheria <amit.kucheria@nokia.com>
Subject: Re: community PM requirements/issues and PowerOP
	[Was:	Re: So, what's the status on the recent patches here?]
Date: Sun, 17 Sep 2006 17:14:57 +0300
Message-ID: <1158502497.22773.16.camel@localhost>
References: <a1a8b0b5c71a78fafd450c10ec52a60d@comcast.net>
	<45092968.7070508@gmail.com> <20060914101704.GA17820@elf.ucw.cz>
	<acd2a5930609140515j5c57583cm43615b6f48a265aa@mail.gmail.com>
	<20060914130311.GA2224@elf.ucw.cz>
	<acd2a5930609140615r5ee11e5amd48857198e1cd8c7@mail.gmail.com>
	<20060914132037.GC2029@elf.ucw.cz> <1158490414.22541.2.camel@localhost>
	<20060917131831.GM2741@elf.ucw.cz>
	<1158499703.22773.11.camel@localhost>
	<20060917134006.GO2741@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060917134006.GO2741@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: ext Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

(Modified recipient list)

On Sun, 2006-09-17 at 15:40 +0200, ext Pavel Machek wrote:
> On Sun 2006-09-17 16:28:23, Amit Kucheria wrote:
> > On Sun, 2006-09-17 at 15:18 +0200, ext Pavel Machek wrote:
> > >  =

> > > > > Well, for now, Nokia 770 is zaurus with wifi but without keyboard
> > > > > (mostly). It seems to be very similar to zaurus pm-wise.
> > > > =

> > > > You have conveniently chosen to forget that Nokia 770 does not supp=
ort
> > > > suspend-to-disk - it is a S-T-R device. In fact, personally I agree=
 with
> > > > Linus' comments elsewhere about S-T-D being irrelevant.
> > > =

> > > Now I do not understand... this was power savings debate, no? Zaurus
> > > basically does not support S-T-D either (or at least I do not use it
> > > there), and I agree that S-T-D is irrelevant in the long term. And it
> > > is hardly relevant for non-PC machines _now_.
> > =

> > I was referring to the default method of power save on Zaurus on the
> > Sharp ROMs. It was S-T-D (Flash), IIRC. I do not recall drivers doing
> > runtime power management on Zaurus; that is a major difference from
> > Nokia 770.
> =

> I'm pretty sure Zauruses do s-t-ram. Flash is read only during normal
> operation.
> =

> I'm very sure Sharp zaurus sl-5500 does s-t-ram. After all, it has
> 16MB of flash and 64MB of ram. Suspend-to-flash is not an option.
> =

> 								Pavel

If that is the case, I stand corrected. Did the drivers support dynamic
idling?

Although something about the time it took to resume still bothers me....
I will try to find time to flash it and check.


-- =

Amit Kucheria <amit.kucheria@nokia.com>
Nokia
