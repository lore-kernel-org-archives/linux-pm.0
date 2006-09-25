From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Suspend and slight video corruption
Date: Mon, 25 Sep 2006 10:12:22 +0200
Message-ID: <20060925081222.GA2107@elf.ucw.cz>
References: <20060921210244.GB5888@excelhustler.com>
	<20060924094153.GA4057@ucw.cz>
	<20060924230213.GA21162@katherina.lan.complete.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20060924230213.GA21162@katherina.lan.complete.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: John Goerzen <jgoerzen@complete.org>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Sun 2006-09-24 18:02:13, John Goerzen wrote:
> On Sun, Sep 24, 2006 at 09:41:53AM +0000, Pavel Machek wrote:
> > > I have tried both uswsusp and suspend2 and get the same results with
> > > each.
> > > =

> > > This is a Debian etch system, kernel.org 2.6.18 (with the small
> > > mactel-linux patches), booting without EFI, XOrg 7.0.0, ATI fglrx dri=
ver
> > > 8.28.8.
> > =

> > You are using ati closed video drivers, experience video problem, and
> > expect us to help? Huh? Ask ATI.
> =

> I understand your position, and would be quite happy to be free of
> fglrx -- X.org doesn't yet support this video card, so I have no other
> choice.

You do not need X.org support. vesafb should work nice, for
example. Maybe even radeonfb.

> As I'm sure you're aware, ATI doesn't provide any support for their
> driver.  I was merely hoping someone may have seen this behavior

As I'm sure you're aware, we don't provide any support for
closed-source systems. Anyway, indicate that system includes closed
components in the subject line next time...
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
