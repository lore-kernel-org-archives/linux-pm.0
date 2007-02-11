From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Re: NAK new drivers without proper power
	management?
Date: Sun, 11 Feb 2007 20:37:29 +0100
Message-ID: <20070211193729.GB15445@elf.ucw.cz>
References: <fa.xSKPgY66Q+DPCZ1pszFFfdrJ0To@ifi.uio.no>
	<200702101034.04410.rjw@sisk.pl>
	<1171101723.3821.22.camel@nigel.suspend2.net>
	<200702101130.44471.rjw@sisk.pl>
	<Pine.LNX.4.64.0702101231281.20138@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702101231281.20138@iabervon.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Daniel Barkalow <barkalow@iabervon.org>
Cc: Robert Hancock <hancockr@shaw.ca>, Jeff Garzik <jeff@garzik.org>, pm list <linux-pm@lists.osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > Also, I think there are quite some drivers already in the tree that don=
't
> > support suspend/resume explicitly and honestly we should start from add=
ing the
> > suspend/resume routines to these drivers _before_ we ban new drivers li=
ke that.
> =

> It'd be relatively quick to modify all the current drivers that don't =

> explicitly support suspend/resume to explicitly not support it. (Or

Well, I think that is more work than you realize, but yes, that patch
would really be welcome.
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
