From: David Brownell <david-b@pacbell.net>
Subject: Re: nokia 770 [was Re: community PM requirements...]
Date: Wed, 13 Dec 2006 14:27:12 -0800
Message-ID: <20061213222712.EC5911EE1CC@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <20060914101704.GA17820@elf.ucw.cz>
	<457FEE17.8080806@gmail.com> <20061213210359.GC11843@elf.ucw.cz>
	<200612131332.58606.david-b@pacbell.net> <45807708.3090607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <45807708.3090607@gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: eugeny.mints@gmail.com
Cc: linux-pm@lists.osdl.org, matthew.a.locke@comcast.net, scott.preece@motorola.com, pavel@ucw.cz, amit.kucheria@nokia.com
List-Id: linux-pm@vger.kernel.org

> >> Okay... so you have system with 4 different cpu speeds. That should be
> >> simple enough to get running using cpufreq, no need for complex
> >> operating points patches.
> > =

> > And OMAP1 does have cpufreq support.  I believe that if I checked it out
> > I'd find that it's used on N770, as a good way to kick in low voltage
> > operation modes.

(Of course the 17xx OMAPs already use very low voltage, so systems
using them might not win much by runtime switching of voltage ...)


> > ... that's in addition to the reduced power idle, which didn't seem to
> > fit into the DPM framework in any obvious way.
>
> It fits. Omitting some details DPM allows to map/stick operating point
> to tasks.  Mapping one of OMAP low power mode operating point to idle
> task does the job.

The "operating" points on the web page you referenced did not
include the "Big Sleep" state ... the CPU does not "operate"
there, so that's understandable.

It would be good to have one of the Nokia folk who worked on PM
for the 770 provide a bit more detail.  I'm all but positive it =

doesn't use any incarnation of DPM.  I'm sure that if any numbers
(even rough ones) were available, that'd be very interesting.

Pavel's comment about C2/C3/etc on PCs is relevant in some ways,
but it's also important to remember that many systems don't have
states compatible (in detail, affecting infrastructure) with Intel's
Cx model.  In particular, CPU caches usually won't snoop, so the
constraints associated with cache and DMA interactions won't exist;
but different constraints, e.g clock usage, could easily apply.

- Dave
