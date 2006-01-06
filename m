From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch] pm: fix runtime powermanagement's
	/sys	interface
Date: Fri, 6 Jan 2006 04:24:22 +0000
Message-ID: <20060106042422.GB2496@ucw.cz>
References: <20051227213439.GA1884@elf.ucw.cz>
	<d120d5000512271355r48d476canfea2c978c2f82810@mail.gmail.com>
	<20051227220533.GA1914@elf.ucw.cz>
	<Pine.LNX.4.50.0512271957410.6491-100000@monsoon.he.net>
	<20060104213405.GC1761@elf.ucw.cz>
	<20060107083602.GE3184@neo.rr.com>
	<20060107102554.GC9225@elf.ucw.cz>
	<20060107124544.GA3972@neo.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============54837742672968481=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060107124544.GA3972@neo.rr.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adam Belay <ambx1@neo.rr.com>, Patrick Mochel <mochel@digitalimplant.org>, Andrew Morton <akpm@osdl.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============54837742672968481==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> > > 1.) most sound cards have more than two states. (once again latency over
> > > power savings trade offs)
> > 
> > What is the latency in typical "most sound card" case?
> 
> ACPI requires within 100ms for D1 and D2.  D3 can be longer.

Spec is useless here. 1usec is <100msec. Do you know any
soundcard that takes >10msec from D3?
> 
> > > 4.) IDE hard drives and other storage media have "sleep", "suspend",
> > > etc.
> > 
> > Yep; but spindown takes 5 seconds, so if you need to reset ide bus or
> > not to get it back is driver detail. Plus notice how power consuption
> > in sleep and suspend is almost same; motor not running is big deal
> > there. Ouch and hdparm already handles these.
> 
> 5 seconds is more of an upper bound.  My laptop hardrive can do spindown
> and spinup in around 1 second.  hdparm doesn't handle the deeper suspend
> case (it can enter but not recover).  Kernel level support is required.

...but this has very little to do with framework we are trying to
build.
(and no support is needed for hdparm -y).

> > > 6.) many video cards implement D1 and D2 as you've already seen.  This
> > > is often more a matter of "we only know how to restore from such and such
> > > states"
> > 
> > Excatly, so "on"/"off" is enough for them.
> 
> Not really.  The ACPI spec suggests latency requirements for each state.
> If we had better drivers, we might enter a lower latency video card
> state when the screen is blanked that's not quite an "off" state.

Backlight takes ages, anyway.


-- 
Thanks, Sharp!

--===============54837742672968481==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============54837742672968481==--
