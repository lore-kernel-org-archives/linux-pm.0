From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Suspend to disk with PCMCIA card plugged in with
	kernel 2.6.16.28
Date: Wed, 4 Oct 2006 00:02:43 +0200
Message-ID: <20061003220243.GD2353@elf.ucw.cz>
References: <380D9721A8E2114485644D71E87C6AB202902D60@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <380D9721A8E2114485644D71E87C6AB202902D60@PNE-HJN-MBX01.wipro.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: rasmit.ranjan@wipro.com
Cc: deepti.chotai@wipro.com, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

Hi!

> > Reproduce it with 2.6.18, then it is bugzilla time, or post =

> > to linux-usb mailing list.
> =

> Thanks Pavel. I tried with kernel 2.6.18. It worked fine with bulk
> device ( USB key). But does not work with isochronous device and system
> hangs. This time I did not have kdb so could not figure out where did it
> hang.
> Is it that for 2.6.16.28, this path is still broken for some cases like
> suspend to disk when transfer is in progress??

No idea, ask on the usb lists. And update to 2.6.18, if you can.

								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
