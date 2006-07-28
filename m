From: Pavel Machek <pavel@suse.cz>
Subject: Re: swsusp status report
Date: Sat, 29 Jul 2006 01:46:37 +0200
Message-ID: <20060728234637.GD4230@elf.ucw.cz>
References: <200607251325.14747.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0607261137410.6573-100000@iolanthe.rowland.org>
	<20060727204046.GA4623@ucw.cz>
	<200607271613.25538.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200607271613.25538.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > > The disk I/O while reading or writing the image is very slow.  In fac=
t, it =

> > > sounds like it's going one sector at a time.  Can it be sped up?  Do =
the =

> > > AIO changes accomplish that?
> > =

> > Actually yes, it was sector-at-a-time, but it still was ~half of
> > possible speed, so it should not be _that_ bad.
> =

> Thing is, it's sometimes been acceptably quick, but recent kernels
> have gone back and forth between really slow, to not quite so slow,
> to OK, to really slow ...

I do not think I have seen that myself (in recent history). More info
would be needed :-(.
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
