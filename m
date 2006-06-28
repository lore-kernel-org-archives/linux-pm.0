From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: suspend to RAM (embedded) ppc?
Date: Thu, 29 Jun 2006 09:59:54 +1000
Message-ID: <1151539195.4044.43.camel@localhost.localdomain>
References: <Pine.LNX.4.60.0606241957470.22786@poirot.grange>
	<17565.58599.858812.278800@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.60.0606252034260.9893@poirot.grange>
	<17567.32285.641865.387583@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.60.0606262040230.5678@poirot.grange>
	<1151431635.4289.2.camel@localhost>
	<Pine.LNX.4.60.0606290025240.14864@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.60.0606290025240.14864@poirot.grange>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-pm <linux-pm@lists.osdl.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Thu, 2006-06-29 at 00:37 +0200, Guennadi Liakhovetski wrote:
> On Tue, 27 Jun 2006, Johannes Berg wrote:
> =

> > You may want to hold off working on this a bit and first ask BenH for
> > his old patches that converted the pmu stuff to the generic thing but
> > needed invasive generic stuff first.
> =

> Well, I started thinking about possible solutions for mpc824x by looking =

> at the only available sleep implementation for ppc in the kernel - =

> powermac. As was suggested I looked under drivers/macintosh. As an exampl=
e =

> I took powerbook_sleep_grackle() (I think, grackle is also installed in =

> "blue and white" G3's, right?). There I see various calls to pmu_request(=
) =

> with macros as parameters and some comments, so, most things can be =

> understood and mapped to another hardware (if still relevant under the ne=
w =

> power-management interface). But then come some things that I don't =

> understand:
> =

> 		/* Ask the PMU to put us to sleep */
> 		pmu_request(&req, NULL, 5, PMU_SLEEP, 'M', 'A', 'T', 'T');
> =

> So, what exactly does this command do?

It sends a command to the PMU microcontroller to go to sleep. The result
depends on the machine model (I'd suggest you look at the core99 version
rather than the grackle version, it's more sane, and the B&W G3 doesn't
have a PMU anyway). On anything recent, the PMU will then wait for a
signal from the northbridge indicating that the processor entered an
idle state (NAP or SLEEP), and when that haappens, will shut down
various bits of the motherboard, including the CPU, stop some clocks
etc... so basically put the machine to sleep (and do the thing with the
LED). It will also control the wakeup signals from the USB or the button
(or the ADB keyboard) and reboot the CPU when that hapens.

> Next I'll dig the real low-level stuff
> =

> 		low_sleep_handler();
> =

> I am already excited about getting my hands dirty with ppc assembly:-)

The above flushes all processor caches (since the CPU is going to be
powered down) and saves as much as necessary of the CPU state, then put
the CPU into a SLEEP loop waiting for the shutdown by the PMU. It also
sets up some magic vectors where the ROM code will jump to on resume and
restores everything it saved.

> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski
