From: Pavel Machek <pavel@suse.cz>
Subject: Re: suspend to RAM (embedded) ppc?
Date: Fri, 30 Jun 2006 20:00:04 +0200
Message-ID: <20060630180004.GB9225@elf.ucw.cz>
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
Content-Disposition: inline
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
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Thu 2006-06-29 00:37:47, Guennadi Liakhovetski wrote:
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
                                                      ~~~~~~~~~~~~~~~~~~
					What kind of inside joke is that?

									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
