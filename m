From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Bug 10030] Suspend doesn't work when SD card is
	inserted
Date: Mon, 25 Feb 2008 13:31:00 +0100
Message-ID: <200802251331.01085.rjw__33702.1450199702$1203942871$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0802242119500.31164-100000@netrider.rowland.org>
	<200802251241.26216.rjw@sisk.pl>
	<c4e36d110802250402q7312a488idf752e07db7504e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <c4e36d110802250402q7312a488idf752e07db7504e8@mail.gmail.com>
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
To: Zdenek Kabelac <zdenek.kabelac@gmail.com>
Cc: Kernel development list <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: linux-pm@vger.kernel.org

On Monday, 25 of February 2008, Zdenek Kabelac wrote:
> Hi

Hi,

[CCs restored, added CC to Dave]

> I'm finally going to test some kernel - because I'd been trying it
> against the HEAD - but unfortunately  it looks like there is something
> seriously broken with -rc3 and sata merge - anyway - I'm going to make
> a test with this head commit 85b80ebfa4384b8ea30cc1af9617db30319a9ccd
> which should be the last one before merge of SATA.
> 
> So I'm going to check this tree with you patch:
> pm-remove-locking-from-core.patch

If that's the one from http://marc.info/?l=linux-acpi&m=120389632114090&w=2 ,
please do it.

> ---
>  drivers/base/core.c       |    8 ---
>  drivers/base/power/main.c |   97 +++-------------------------------------------
>  drivers/usb/core/usb.c    |    2
>  3 files changed, 8 insertions(+), 99 deletions(-)
> 
> Do you wan to test also the other patch ?

Yes.  Please also test the patch that Alan asked you to test here:
http://lkml.org/lkml/2008/2/23/402
It's experimantal, but it is important to us to know if you see the symptoms
(and which ones if you do) with this patch applied.

Thanks,
Rafael
