From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Wed, 21 Mar 2007 23:36:55 +0100 (CET)
Message-ID: <Pine.LNX.4.60.0703212325560.7211@poirot.grange>
References: <20070320015846.636692000@sipsolutions.net>
	<200703201644.59046.david-b@pacbell.net>
	<Pine.LNX.4.60.0703212153350.7211@poirot.grange>
	<200703211507.55125.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703211507.55125.david-b@pacbell.net>
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
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Ben Dooks <ben@simtec.co.uk>, linux-arm@lists.arm.linux.org.uk, Dirk Behme <dirk.behme@de.bosch.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org, Nicolas Pitre <nico@cam.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Wed, 21 Mar 2007, David Brownell wrote:

> On Wednesday 21 March 2007 2:01 pm, Guennadi Liakhovetski wrote:
> =

> > May we agree on some "simple" criteria, like "CPU power on, i.e.,  =

> > CPU registers preserved"? If yes - standby, CPU off, registers lost - S=
tR? =

> =

> The ACPI spec has some verbiage on those things, which uses
> roughly that distinction.
> =

> Which is very much an indication of how weak ACPI is.  It
> doesn't contemplate typical SOC behavior, which have a wide
> variety of system sleep states that leave the CPU on ... and
> which may not even *have* (or need!) a "cpu off" state.
> =

> My own definition would be more like:  the minimal RAM-based
> power-saving system state is "standby".  If the system
> implements a deeper RAM-based system sleep state, that's "STR".

Hmmm, this leaves the decision how to call each state COMPLETELY to the =

implementor, doesn't it? For example, in my suspend above, I do put the =

peripheral controller to sleep too, whereas a "minimal RAM-based" suspend =

could leave it on. So, does it mean I already qualify for StR?:-) I am =

sure you have more experience with power management and a better =

understanding of it too, maybe that's the reason why your definition makes =

a good sense to you and not to me. But "suspend to RAM" - I think it would =

be logical to interpret it as "only system RAM contents is preserved. All =

other volatile storage (CPU registers, peripheral internal registers and =

RAM, etc.) contents is lost."

Thanks
Guennadi
---
Guennadi Liakhovetski
