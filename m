From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Wed, 30 Aug 2006 21:41:14 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A50764440C@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Preece Scott-PREECE <scott.preece@motorola.com>, Pavel Machek <pavel@ucw.cz>
Cc: Matthew Locke <matthew.a.locke@comcast.net>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

> Well, we have some hardware where we can sleep everything but
> memory and some where we can also leave the display active (and
> backlit). In fact, however, today the latency for going to sleep
> is too great to do so between frames, so we just do a wait there.
[Woodruff, Richard] =


In effect OMAP2/3 can auto idle to low power states in between LCD FIFO
refills.  The SDRAM, the DPLL and interconnects can be auto-idled
between LCD FIFO loads.  By carefully setting your LCD FIFO thresholds
you can spin back up the DPLL, memory and interconnect in time to load
up the LCD FIFO, then back to sleep.

Its not just LCD, other devices can do the same.  Say pushing data into
an audio codec's FIFO.

Getting this effect does require device coordination.  If a device
objects you don't hit the big savings.

Regards,
Richard W.
