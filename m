From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch 2.6.18-rc2-mm 2/2] PM:
	/sys/devices/.../power/state updates
Date: Wed, 16 Aug 2006 13:58:23 +0200
Message-ID: <20060816115823.GC10764@elf.ucw.cz>
References: <200607191340.14371.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200607191340.14371.david-b@pacbell.net>
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
Cc: Linus Torvalds <torvalds@osdl.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Wed 2006-07-19 13:40:13, David Brownell wrote:
> Two changes here:  (a) make writes to these files fail on devices that
> may need the new operations in Linus' patch; (b) update in-source docs
> to match current behavior, including that change.
> =

> I hope nobody has issues with (a), but I can't see a good reason to
> do more than reject such writes since the notions behind that file
> are so broken.

Looks okay.
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
