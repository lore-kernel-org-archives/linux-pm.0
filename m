From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch 2.6.17-rc4-git] correct the USB info in
	Documentation/power/swsusp.txt
Date: Wed, 17 May 2006 16:41:31 +0200
Message-ID: <20060517144131.GB8472@elf.ucw.cz>
References: <200605161733.15144.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200605161733.15144.david-b@pacbell.net>
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

On =DAt 16-05-06 17:33:14, David Brownell wrote:
> info =3D=3D good, misinformation =3D=3D bad

> The swsusp.txt documentation harshes confusingly on USB, and this patch
> addresses the issue.  It's harsh because it blames USB for some issues
> that are generic to all drivers -- especially those supporting removabl=
e
> media -- and it's confusing since it says that USB has the issue with
> "suspend" not just swsusp ... while in reality, USB doesn't have the
> issue when real system suspend states are used.

Yep, right, the documentation is _old_. ACK.
								Pavel


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html
