From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.32-rc4: Reported regressions 2.6.30 -> 2.6.31
Date: Mon, 12 Oct 2009 23:48:33 +0200
Message-ID: <200910122348.33588.rjw__28221.1470803761$1255384910$gmane$org@sisk.pl>
References: <56acieJJ2fF.A.nEB.Hzl0KB@chimera>
	<1255377529.9544.63.camel@bluto.andrew>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1255377529.9544.63.camel@bluto.andrew>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Patterson <andrew.patterson@hp.com>
Cc: DRI <dri-devel@lists.sourceforge.net>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Natalie Protasevich <protasnb@gmail.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday 12 October 2009, Andrew Patterson wrote:
> On Mon, 2009-10-12 at 00:41 +0200, Rafael J. Wysocki wrote:
> > 
> > 
> > Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=14309
> > Subject		: MCA on hp rx8640
> > Submitter	: Andrew Patterson <andrew.patterson@hp.com>
> > Date		: 2009-09-29 17:20 (13 days old)
> > First-Bad-Commit: http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=db8be50c4307dac2b37305fc59c8dc0f978d09ea
> > References	: http://www.spinics.net/lists/linux-usb/msg22799.html
> > 
> 
> Linus fixed this one with d93a8f829fe1d2f3002f2c6ddb553d12db420412.  It
> also looks like a duplicate of
> http://bugzilla.kernel.org/show_bug.cgi?id=14374

Thanks, I closed #14309 as a duplicate of #14374 that's already closed.

Best,
Rafael
