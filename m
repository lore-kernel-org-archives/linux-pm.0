From: Pavel Machek <pavel@ucw.cz>
Subject: Re: question on freeze and aio
Date: Wed, 14 Feb 2007 22:44:48 +0100
Message-ID: <20070214214448.GB26206@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0702091700450.4557-100000@iolanthe.rowland.org>
	<200702092309.11530.rjw@sisk.pl>
	<20070213101859.GD12996@elf.ucw.cz>
	<200702131653.15744.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200702131653.15744.rjw@sisk.pl>
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
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > Ok, then we have a bug in swsusp. Can someone locate _which_ workqueue
> > is used for aio... and make it freezeable?
> =

> Hm, so AIO is not needed for saving the image regardless of the system
> configuration?

No, definitely not.
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
