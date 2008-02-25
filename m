From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: Bugs in MMC [was: [Bug 10030] Suspend doesn't work
	when SD card is inserted]
Date: Tue, 26 Feb 2008 00:51:43 +0200
Message-ID: <31e679430802251451y3ae370ddj125616ee4e655536__10711.3216225573$1203981523$gmane$org@mail.gmail.com>
References: <200802241500.41969.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0802240941440.29504-100000@netrider.rowland.org>
	<20080225184102.0a2e2bb5@mjolnir.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080225184102.0a2e2bb5@mjolnir.drzeus.cx>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pierre Ossman <drzeus-mmc@drzeus.cx>, carlos.aguiar@indt.com.br
Cc: Kernel development list <linux-kernel@vger.kernel.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

<snip>

> > What's the purpose of the card-counting loop in
> > host/omap.c:mmc_omap_switch_handler()? It looks like dead code.
> >
>
> I'm not too familiar with that driver, but they've been playing around
> with multiplexing several cards into one controller. Might be bits and
> pieces of that.
>

AFAIK, that came after mmc multislot support. Omap2 has one mmc
controller  for several (2 in practice) mm slots (cards).
It's not really a dead code since it's used in n800 and n810, it's in
linux-omap archives and git tree.

Carlos Aguiar, added in the loop, might have some comments about it.

--
Best Regards,
Felipe Balbi
felipebalbi@users.sourceforge.net
