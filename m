From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] Fix the outstanding issue with hangs on
	insert/removal of mmc cards
Date: Fri, 11 Jun 2010 12:42:47 -0700 (PDT)
Message-ID: <536217.22740.qm__3419.1376100809$1276285505$gmane$org@web180312.mail.gq1.yahoo.com>
References: <1276282801.8557.20.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1276282801.8557.20.camel@maxim-laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-mmc <linux-mmc@vger.kernel.org>, Maxim Levitsky <maximlevitsky@gmail.com>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Philip Langdale <philipl@overt.org>
List-Id: linux-pm@vger.kernel.org



--- On Fri, 6/11/10, Maxim Levitsky <maximlevitsky@gmail.com> wrote:
> After thinking a lot about how to fix properly the hangs
> caused by
> insert/removal of mmc card during suspend/resume, and default behavior
> of not trusting the card persistence over suspend,

Right; there are two types of driver:  ones
that can correctly report whether the card
has been removed ... and ones that can't  That
default behavior presumes the latter. 

The MMC/SD framework doesn't know about these
two types

(For
reference:  the easy way to do the former involves
setting up the GPIO used for card detect as a
(wakeup?) IRQ source.

> First of all there are 2 types of removal possible. First
> one happens
> when system detects that some device is gone. At that point
> there is
> really no point in syncing it.

One suggestion was syncing before suspend...
but that would require coordinating the
block layer and PM framework.  That seems
like it'd be generally a wise thing to do;
no point in losing the write cache, ever.


> The other type of removal is controlled removal, usually on user  request.
