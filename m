From: Mark Gross <mgross@linux.intel.com>
Subject: Re: Alternative Concept [Was: Re: [RFC] CPUFreq PowerOP
	integration, Intro 0/3]
Date: Mon, 16 Oct 2006 14:44:54 -0700
Message-ID: <20061016214454.GA18975@linux.intel.com>
References: <44ECFF94.3030506@gmail.com>
	<20061007023620.GD30380@dominikbrodowski.de>
	<452EC524.5000608@gmail.com> <20061013105504.GA1913@elf.ucw.cz>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20061013105504.GA1913@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pm list <linux-pm@lists.osdl.org>, Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: linux-pm@vger.kernel.org

On Fri, Oct 13, 2006 at 12:55:04PM +0200, Pavel Machek wrote:
> Hi!
> =

> > That's it. Bottom line is: what you are talking about is NOT an Alterna=
tive
> > Concept but a particular case instead. While PowerOP design is
> > generic case.
> =

> Fine then; submit powerOP with interface Dominik suggested. Notice
> that his solution exposes all the knobs to userspace directly, so his
> interface _is_ different to yours. "i_am_special" is just one of knobs.

I am very keen on Dominic's design concept, however; I missed his sysfs
interface that exposes the knobs to userspace.  =


I've search the archives and still don't see any interface to user space
users. =


--mgross
> =

> > The last remark about 256 CPU case. Leveraging POwerOP such systems wil=
l be
> > built using just one (current) operating point approach as described
> > above.
> =

> Notice that Dominik's solution still allows to have more than one
> operating point for each of 256 CPUs without explosion of number of
> states.
> =

> 								Pavel
> =

> > > F) So, how would this work for OMAP1?
> > > =

> > > Let's limit it, to keep it somewhat simple, to the values contained i=
n your
> > > "struct pm_core_point" for OMAP:
> > > =

> > > 	int cpu_vltg; /* voltage in mV */
> > > 	int dpll;     /* in KHz */
> > > 	int cpu;      /* CPU frequency in KHz */
> > > 	int tc;       /* in KHz */
> > > 	int per;      /* in KHz */
> > > 	int dsp;      /* in KHz */
> > > 	int dspmmu;   /* in KHz */
> > > 	int lcd;      /* in KHz */
> > > =

> > > and let's also add a
> > > =

> > > 	int i_am_special;
> > > =

> > > Let's assume that there is an OMAP1 PM module which implements a ->se=
t and
> > > ->get function for all of them. A yet-to-be-defined interface then te=
lls
> > > this PM module
> =

> -- =

> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/linux-pm
