From: Pavel Machek <pavel@ucw.cz>
Subject: Re: S2RAM and PCI quirks
Date: Thu, 9 Nov 2006 00:47:29 +0100
Message-ID: <20061108234729.GB23816@elf.ucw.cz>
References: <1163000705.23956.18.camel@localhost.localdomain>
	<1163000924.3138.342.camel@laptopd505.fenrus.org>
	<1163001711.23956.30.camel@localhost.localdomain>
	<200611082218.55052.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200611082218.55052.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.osdl.org>, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed 2006-11-08 22:18:54, Rafael J. Wysocki wrote:
> On Wednesday, 8 November 2006 17:01, Alan Cox wrote:
> > Ar Mer, 2006-11-08 am 16:48 +0100, ysgrifennodd Arjan van de Ven:
> > > at the same time I'm not 100% convinced it's ok to always run all qui=
rks
> > > at resume, for one the difference is that there now is a driver active
> > > owning the device... Almost sounds like having a per quirk flag stati=
ng
> > > "run at resume" is needed ;-(
> > =

> > We probably need a quirk class for resume in this situation. The kind of
> > things that worry me if we are not doing the quirk handling, and what I
> > suspect happened in the case I looked at are that chipset bug
> > workarounds did not get restored, and in this case the older VIA chipset
> > involved then corrupted DMA streams and trashed the users disk.
> =

> Now that would explain why many boxes resume from disk correctly, but don=
't
> resume from RAM by any means.

Well, there are other good reasons, too. (suspend-to-disk resume works
with hardware in mostly-initialized state, while suspend-to-ram resume
works with hardware in mostly-weird state). Yes, per-quirk "run me on
resume-from-ram" is probably the way forward.
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
