From: Pavel Machek <pavel@ucw.cz>
Subject: Re: USB autosuspend patch series
Date: Mon, 25 Sep 2006 23:47:30 +0200
Message-ID: <20060925214729.GA2506@elf.ucw.cz>
References: <20060924211939.GH1873@elf.ucw.cz>
	<Pine.LNX.4.44L0.0609251542410.5680-101000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0609251542410.5680-101000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > > Are autosuspend patches available somewhere? (Relative to -mm, or
> > > > relative to 2.6.18?) I'd like to play with them...
> > > =

> > > The versions in the mailing list archives are a little old.  I'll post
> > > some updates later this week.
> > =

> > Thanks!
> =

> Attached is a gzipped tar archive of a quilt "patches" directory for
> 2.6.18-mm1, with all the USB autosuspend code.  These patches include the
> related updates and bug fixes that have been or will soon be submitted.  =

> The autosuspend facility is dependent on CONFIG_USB_SUSPEND, so check you=
r =

> .config before building this code.
> =

> Some of the patches are still rather experimental.  If anyone has any =

> problem using them (with or without CONFIG_USB_SUSPEND), please let me =

> know.

Thanks, they work as expected here... and save around 3-4W. (Big deal on
machine that eats 9W total).
									Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
