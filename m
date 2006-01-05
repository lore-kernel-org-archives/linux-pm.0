From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch] pm: fix runtime powermanagement's /sys
	interface
Date: Fri, 6 Jan 2006 00:58:38 +0100
Message-ID: <20060105235838.GC3339@elf.ucw.cz>
References: <20051227220533.GA1914@elf.ucw.cz>
	<Pine.LNX.4.50.0512271957410.6491-100000@monsoon.he.net>
	<20060104213405.GC1761@elf.ucw.cz>
	<Pine.LNX.4.50.0601051329590.17046-100000@monsoon.he.net>
	<20060105215528.GF2095@elf.ucw.cz>
	<20060105221334.GA925@isilmar.linta.de>
	<20060105222338.GG2095@elf.ucw.cz>
	<20060105222705.GA12242@isilmar.linta.de>
	<20060105230849.GN2095@elf.ucw.cz>
	<20060105234629.GA7298@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20060105234629.GA7298@isilmar.linta.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Dominik Brodowski <linux@dominikbrodowski.net>, Patrick Mochel <mochel@digitalimplant.org>, Andrew Morton <akpm@osdl.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On P=E1 06-01-06 00:46:29, Dominik Brodowski wrote:
> On Fri, Jan 06, 2006 at 12:08:49AM +0100, Pavel Machek wrote:
> > Ok, so lets at least add value-checking to .../power file, and preven=
t
> > userspace see changes to PM_EVENT_SUSPEND value. 2 and 0 are now
> > "arbitrary cookies". I'd like to use "on" and "off", but pcmcia
> > apparently depends on "2" and "0", so...
> >=20
> > Any objections?
>=20
> Sorry, but yes -- the same as before, minus the PCMCIA breakage.

I don't understand at this point.

Current code takes value from user, and passes it down to driver,
without any checking. If user writes 666 into the file, it will
happily pass down 666 to the driver. Driver does not expect 666 in
pm_message_t.event. It may oops, BUG_ON() or anything like that.

Shall I change=20

#define PM_EVENT_SUSPEND 2

to

#define PM_EVENT_SUSPEND 1324

to get my point across? This is kernel-specific value, it should not
be exported to userland.
								Pavel

--=20
Thanks, Sharp!
