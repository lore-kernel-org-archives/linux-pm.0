From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] PM: Make it possible to avoid wakeup events
	from being lost
Date: Sat, 26 Jun 2010 19:43:39 -0700 (PDT)
Message-ID: <323677.5124.qm__24259.6858916388$1277606693$gmane$org@web180313.mail.gq1.yahoo.com>
References: <Pine.LNX.4.44L0.1006261258140.22018-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1006261258140.22018-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: mark gross <640e9920@gmail.com>, Neil Brown <neilb@suse.de>, linux-pci@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Florian Mickler <florian@mickler.org>, Arve@smtp1.linux-foundation.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


> > This is a repeat of an issue I posted before, but
> > which for some reason I never saw email back ...
> =

> I replied to one of your emails on this topic.=A0 Maybe you didn't see th=
e reply.

I guess not; I'll see if there's some message
buried in a too-much-email folder.)
> =

> > basically, I think the notion of counting wakeup
> > events seems dubious on common hardware, ...
> I disagree.=A0
> =

> The "counting" isn't meant as a way of keeping track of the absolute
> number of these events.=A0 It's more like a technique  for seeing how many
> remain outstanding at any time.

But if you can't count them with any
reliability, you can't know *that* either... so
there must be a a problem with that model.
