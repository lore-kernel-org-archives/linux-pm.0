From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC][PATCH -mm 2/5] swsusp: Use memory bitmaps
	during resume
Date: Wed, 9 Aug 2006 12:34:42 +0200
Message-ID: <20060809103442.GJ3308@elf.ucw.cz>
References: <200608091152.49094.rjw@sisk.pl> <200608091204.36186.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200608091204.36186.rjw@sisk.pl>
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

Okay, I'm little out of time now, and I do not understand 2 and 3 in
the series.

> Make swsusp use memory bitmaps to store its internal information during t=
he
> resume phase of the suspend-resume cycle.
> =

> If the pfns of saveable pages are saved during the suspend phase instead =
of
> the kernel virtual addresses of these pages, we can use them during the r=
esume
> phase directly to set the corresponding bits in a memory bitmap.  Then, t=
his
> bitmap is used to mark the page frames corresponding to the pages that we=
re
> saveable before the suspend (aka "unsafe" page frames).
> =

> Next, we allocate as many page frames as needed to store the entire suspe=
nd
> image and make sure that there will be some extra free "safe" page frames=
 for
> the list of PBEs constructed later.  Subsequently, the image is loaded an=
d,
> if possible, the data loaded from it are written into their "original" pa=
ge frames
> (ie. the ones they had occupied before the suspend).  The image data that
> cannot be written into their "original" page frames are loaded into "safe=
" page
> frames and their "original" kernel virtual addresses, as well as the addr=
esses
> of the "safe" pages containing their copies, are stored in a list of PBEs.
> Finally, the list of PBEs is used to copy the remaining image data into t=
heir
> "original" page frames (this is done atomically, by the architecture-depe=
ndent
> parts of swsusp).

So... if page in highmem is allocated during resume, you'll still need
to copy it during assembly "atomic copy", right? Unfortunately, our
assembler parts can't do it just now...?
								Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
