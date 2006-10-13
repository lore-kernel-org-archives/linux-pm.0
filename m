From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Alternative Concept [Was: Re: [RFC] CPUFreq PowerOP
	integration, Intro 0/3]
Date: Fri, 13 Oct 2006 12:55:04 +0200
Message-ID: <20061013105504.GA1913@elf.ucw.cz>
References: <44ECFF94.3030506@gmail.com>
	<20061007023620.GD30380@dominikbrodowski.de>
	<452EC524.5000608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <452EC524.5000608@gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Cc: pm list <linux-pm@lists.osdl.org>, Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: linux-pm@vger.kernel.org

Hi!

> That's it. Bottom line is: what you are talking about is NOT an Alternati=
ve
> Concept but a particular case instead. While PowerOP design is
> generic case.

Fine then; submit powerOP with interface Dominik suggested. Notice
that his solution exposes all the knobs to userspace directly, so his
interface _is_ different to yours. "i_am_special" is just one of knobs.

> The last remark about 256 CPU case. Leveraging POwerOP such systems will =
be
> built using just one (current) operating point approach as described
> above.

Notice that Dominik's solution still allows to have more than one
operating point for each of 256 CPUs without explosion of number of
states.

								Pavel

> > F) So, how would this work for OMAP1?
> > =

> > Let's limit it, to keep it somewhat simple, to the values contained in =
your
> > "struct pm_core_point" for OMAP:
> > =

> > 	int cpu_vltg; /* voltage in mV */
> > 	int dpll;     /* in KHz */
> > 	int cpu;      /* CPU frequency in KHz */
> > 	int tc;       /* in KHz */
> > 	int per;      /* in KHz */
> > 	int dsp;      /* in KHz */
> > 	int dspmmu;   /* in KHz */
> > 	int lcd;      /* in KHz */
> > =

> > and let's also add a
> > =

> > 	int i_am_special;
> > =

> > Let's assume that there is an OMAP1 PM module which implements a ->set =
and
> > ->get function for all of them. A yet-to-be-defined interface then tells
> > this PM module

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
