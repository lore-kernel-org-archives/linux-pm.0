From: Pavel Machek <pavel@ucw.cz>
Subject: Re: community PM requirements/issues and PowerOP [Was:
	Re: So, what's the status on the recent patches here?]
Date: Mon, 18 Sep 2006 11:02:29 +0200
Message-ID: <20060918090229.GA3746@elf.ucw.cz>
References: <20060914101704.GA17820@elf.ucw.cz>
	<acd2a5930609140515j5c57583cm43615b6f48a265aa@mail.gmail.com>
	<20060914130311.GA2224@elf.ucw.cz>
	<acd2a5930609140615r5ee11e5amd48857198e1cd8c7@mail.gmail.com>
	<20060914132037.GC2029@elf.ucw.cz>
	<1158490414.22541.2.camel@localhost>
	<20060917131831.GM2741@elf.ucw.cz>
	<1158499703.22773.11.camel@localhost>
	<20060917134006.GO2741@elf.ucw.cz>
	<1158502497.22773.16.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <1158502497.22773.16.camel@localhost>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Amit Kucheria <amit.kucheria@nokia.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

> (Modified recipient list)

> > I'm pretty sure Zauruses do s-t-ram. Flash is read only during normal
> > operation.
> > =

> > I'm very sure Sharp zaurus sl-5500 does s-t-ram. After all, it has
> > 16MB of flash and 64MB of ram. Suspend-to-flash is not an option.
> =

> If that is the case, I stand corrected. Did the drivers support dynamic
> idling?

Not sure about that one.

> Although something about the time it took to resume still bothers me....
> I will try to find time to flash it and check.

Well, in 2.6.X suspend-to-RAM means console switch and process
freezing. (Yes, it would be nice to fix that).
								Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
