From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Alternative Concept [Was: Re: [RFC] CPUFreq PowerOP
	integration, Intro 0/3]
Date: Tue, 17 Oct 2006 10:26:15 +0200
Message-ID: <20061017082615.GB14335@elf.ucw.cz>
References: <44ECFF94.3030506@gmail.com>
	<20061007023620.GD30380@dominikbrodowski.de>
	<452EC524.5000608@gmail.com> <20061013105504.GA1913@elf.ucw.cz>
	<20061016214454.GA18975@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20061016214454.GA18975@linux.intel.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Mark Gross <mgross@linux.intel.com>
Cc: pm list <linux-pm@lists.osdl.org>, Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > That's it. Bottom line is: what you are talking about is NOT an Alter=
native
> > > Concept but a particular case instead. While PowerOP design is
> > > generic case.
> > =

> > Fine then; submit powerOP with interface Dominik suggested. Notice
> > that his solution exposes all the knobs to userspace directly, so his
> > interface _is_ different to yours. "i_am_special" is just one of knobs.
> =

> I am very keen on Dominic's design concept, however; I missed his sysfs
> interface that exposes the knobs to userspace.  =


He did not specify it in detail. Important point is he has
one-file-per-knob and one-value-per-knob.

								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
