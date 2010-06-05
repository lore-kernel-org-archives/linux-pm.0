From: Florian Mickler <florian@mickler.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Sat, 5 Jun 2010 21:49:39 +0200
Message-ID: <20100605214939.49dd0ee0__48927.4960513741$1275767475$gmane$org@schatten.dmk.lab>
References: <20100527222514.0a1710bf@lxorguk.ukuu.org.uk>
	<1275149418.4503.128.camel@mulgrave.site>
	<1275156734.1645.496.camel@laptop> <201005312314.12391.rjw@sisk.pl>
	<AANLkTil4DLUciWMVmCiiygS2Y1vLZu0Lnfys-w4q3L7W@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTil4DLUciWMVmCiiygS2Y1vLZu0Lnfys-w4q3L7W@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: tytso@mit.edu, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, James Bottomley <James.Bottomley@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, felipe.balbi@nokia.com
List-Id: linux-pm@vger.kernel.org

On Sat, 5 Jun 2010 20:16:33 +0300
Felipe Contreras <felipe.contreras@gmail.com> wrote:

> On Tue, Jun 1, 2010 at 12:14 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > Do you realistically think that by hurting the _user_ you will make the
> > _developer_ write better code? =A0No, really.
> =

> As an application writer, if my users complain that their battery is
> being drained (as it happened), they stop using it, and other people
> see there are problems, so they stop using it, if people get angry
> about it they will vote it down.
> =

> New users will see it has low score; they will not install it. That's
> a network effect.
> =

> Having users is the quintessential reason people write code.
> =


That is nice. But how does it impact the problem that suspend blockers
solve? And why do suspend blockers interfere with that?

Cheers,
Flo
