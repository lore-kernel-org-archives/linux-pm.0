From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Alternative Concept
Date: Tue, 20 Mar 2007 23:06:32 +0100
Message-ID: <20070320220632.GK3545@elf.ucw.cz>
References: <200703182104.27555.david-b@pacbell.net>
	<46003329.6050808@gmail.com> <20070320204514.GH3545@elf.ucw.cz>
	<200703201504.47956.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200703201504.47956.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > But we do not want new subsystem. We want power management to
> > work. Take a look how Alan added pm to usb... and just do it like
> > him. If some code makes sense to be shared, share it. But start with
> > support for platform you care about and don't overdesign it.
> =

> Note, Alan didn't do it by himself.  The autosuspend stuff built on
> previous work in USB PM, and this DID get discussed -- as concrete
> proposals -- before he did all that good stuff.

Okay, you are right. But I do not remember any "handwaving"
phase... (And sorry for not giving credit where it was due, obviously
Alan did not do it all by himself).

									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
