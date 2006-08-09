From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC][PATCH -mm 2/5] swsusp: Use memory bitmaps
	during resume
Date: Wed, 9 Aug 2006 13:33:35 +0200
Message-ID: <20060809113335.GP3308@elf.ucw.cz>
References: <200608091152.49094.rjw@sisk.pl> <200608091204.36186.rjw@sisk.pl>
	<20060809103442.GJ3308@elf.ucw.cz> <200608091304.35746.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200608091304.35746.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > Okay, I'm little out of time now, and I do not understand 2 and 3 in
> > the series.
> =

> Well ...
> =

> > > Make swsusp use memory bitmaps to store its internal information duri=
ng the
> > > resume phase of the suspend-resume cycle.
> > > =

> > > If the pfns of saveable pages are saved during the suspend phase inst=
ead of
> > > the kernel virtual addresses of these pages, we can use them during t=
he resume
> > > phase directly to set the corresponding bits in a memory bitmap.  The=
n, this
> > > bitmap is used to mark the page frames corresponding to the pages tha=
t were
> > > saveable before the suspend (aka "unsafe" page frames).
> > > =

> > > Next, we allocate as many page frames as needed to store the entire s=
uspend
> > > image and make sure that there will be some extra free "safe" page fr=
ames for
> > > the list of PBEs constructed later.  Subsequently, the image is loade=
d and,
> > > if possible, the data loaded from it are written into their "original=
" page frames
> > > (ie. the ones they had occupied before the suspend).  The image data =
that
> > > cannot be written into their "original" page frames are loaded into "=
safe" page
> > > frames and their "original" kernel virtual addresses, as well as the =
addresses
> > > of the "safe" pages containing their copies, are stored in a list of =
PBEs.
> > > Finally, the list of PBEs is used to copy the remaining image data in=
to their
> > > "original" page frames (this is done atomically, by the architecture-=
dependent
> > > parts of swsusp).
> > =

> > So... if page in highmem is allocated during resume, you'll still need
> > to copy it during assembly "atomic copy", right?
> =

> No.  It can be copied before the assembly gets called, because we are in =
the
> kernel at that time which certainly is not in the highmem. :-)

Ahha, okay, nice trick.

> > Unfortunately, our assembler parts can't do it just now...?
> =

> No, they can't, but that just isn't necessary.  During the resume we crea=
te
> two lists of PBEs - one for "normal" pages, and one for highmem pages.  T=
he
> first one is handled by the "atomic copy" code as usual, but the second o=
ne
> may be handled by some C code a bit earlier.

I'm still not sure if highmem support is worth the complexity -- I
hope highmem dies painful death in next 3 weeks or so.

									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
