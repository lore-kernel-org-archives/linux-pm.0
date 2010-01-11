From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.33-rc3-git3: Reported regressions from 2.6.32
Date: Mon, 11 Jan 2010 23:10:20 +0100
Message-ID: <201001112310.21048.rjw__8097.09164682335$1263247872$gmane$org@sisk.pl>
References: <wnS54-l8PVO.A.TlF.oMlSLB@chimera>
	<20100111214603.GA4335@emergent.ellipticsemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100111214603.GA4335@emergent.ellipticsemi.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nick Bowler <nbowler@elliptictech.com>
Cc: Adrian Bunk <bunk@kernel.org>, DRI <dri-devel@lists.sourceforge.net>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Natalie Protasevich <protasnb@gmail.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday 11 January 2010, Nick Bowler wrote:
> On 23:27 Sun 10 Jan     , Rafael J. Wysocki wrote:
> > This message contains a list of some regressions from 2.6.32, for which there
> > are no fixes in the mainline I know of.  If any of them have been fixed already,
> > please let me know.
> > 
> > If you know of any other unresolved regressions from 2.6.32, please let me know
> > either and I'll add them to the list.  Also, please let me know if any of the
> > entries below are invalid.
> 
> Here are two that I don't see in the list:
> 
>  * LVDS downclocking breaks on G45/thinkpad T500
> 
>      LKML: http://lkml.org/lkml/2009/12/26/40
>      FDO:  http://bugs.freedesktop.org/show_bug.cgi?id=25809

Added this one.

>  * Receive failure in et131x (Alan Cox sent me a patch for this but
>                               it's not in mainline yet)
> 
>      LKML: http://lkml.org/lkml/2009/12/29/210

This one is a staging driver, so I'm not going to list it.

Thanks,
Rafael
