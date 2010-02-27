From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: pm-suspend working, but pm-hibernate fails
Date: Sat, 27 Feb 2010 19:08:58 +0100
Message-ID: <201002271908.58333.rjw@sisk.pl>
References: <4B86F96A.1010306@maroy.hu> <20100227135144.GA18662@qp>
	<4B89288F.8070302@maroy.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4B89288F.8070302@maroy.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Saturday 27 February 2010, =C1kos Mar=F3y wrote:
> Matthias,
> =

> > Did you try it without framebuffer and X.org? It seems to me that the
> > system wakes up correctly, but the graphics card is this issue. I had
> > this with my old laptop too.
> =

> instead of guessword, I'd be very happy to look at a log of what's
> happening. a long time ago I remember, with tuxonice, this was possible,
> just to immitate hibernation.

You can actually do that with the in-kernel hibernate too.

Please read Documentation/power/basic-pm-debugging.txt, there are more
hibernate debugging hints in there.

Rafael
