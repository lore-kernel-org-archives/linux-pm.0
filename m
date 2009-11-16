From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.32-rc7-git1: Reported regressions 2.6.30 ->
	2.6.31
Date: Tue, 17 Nov 2009 00:35:11 +0100
Message-ID: <200911170035.11575.rjw__30307.4564472356$1258414720$gmane$org@sisk.pl>
References: <ipicVA1QUFF.A.zWB.1mdALB@chimera> <4B01E09D.3020608@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4B01E09D.3020608@lwfinger.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: DRI <dri-devel@lists.sourceforge.net>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Natalie Protasevich <protasnb@gmail.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 17 November 2009, Larry Finger wrote:
> On 11/16/2009 04:58 PM, Rafael J. Wysocki wrote:
> > This message contains a list of some regressions introduced between 2.6.30 and
> > 2.6.31, for which there are no fixes in the mainline I know of.  If any of them
> > have been fixed already, please let me know.
> > 
> > Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=14181
> > Subject		: b43 causes panic at ifconfig down / shutdown
> > Submitter	: Jeremy Huddleston <jeremyhu@freedesktop.org>
> > Date		: 2009-09-15 18:34 (63 days old)
> 
> This one is fixed by commit d50bae33d1358b909ade05ae121d83d3a60ab63f in
> mainline. The patch was also sent to stable.

Thanks, closed.

Rafael
