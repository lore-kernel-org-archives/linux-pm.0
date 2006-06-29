From: "Matt Sealey" <matt@genesi-usa.com>
Subject: Re: PowerPC cpufreq using ICTC
Date: Thu, 29 Jun 2006 07:30:23 -0500
Message-ID: <007d01c69b77$cd36ec20$99dfdfdf@bakuhatsu.net>
References: <17571.27179.106239.531807@cargo.ozlabs.ibm.com>
Reply-To: matt@genesi-usa.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <17571.27179.106239.531807@cargo.ozlabs.ibm.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: 'Paul Mackerras' <paulus@samba.org>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


> > (when DPM is enabled). This should, by all documentation, =

> reduce the power consumption of the CPU.
> =

> But does it reduce the energy consumed per instruction =

> executed, or increase it?

In theory if you do not issue instructions to the units, DPM turns
themselves off saving (from some Freescale doc on the subject) around
6% power (while running benchmark code). Every pipeline bubble
adds to the power saving! :]

Then the theory goes that if you can force the units to sit idle for
1-255 instructions you can save more.

I have no idea if it actually works.. that is what I wanted to find
out.

> see any improvement in energy per instruction unless you can =

> reduce the CPU core Vdd voltage.

It doesn't improve energy per instruction, so much as allow the units
to go into low-power states so while there are no instructions being
fetched, you aren't wasting power.

> If you can't reduce the energy per instruction then you might =

> as well "race to idle", which is effectively what we do currently.

Like I said that is what I wanted to find out. Let me find that
Freescale doc..

http://www.freescale.com/files/32bit/doc/app_note/AN2436.pdf

-- =

Matt Sealey <matt@genesi-usa.com>
Manager, Genesi, Developer Relations
