From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.34-rc5: Reported regressions from 2.6.33
Date: Tue, 20 Apr 2010 06:13:33 +0200
Message-ID: <201004200613.33696.rjw__34791.2500532859$1271736872$gmane$org@sisk.pl>
References: <deuQKFRcc0B.A.3EG.BRSzLB@tosh>
	<20100419205723.8724338c.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100419205723.8724338c.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: DRI <dri-devel@lists.sourceforge.net>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday 20 April 2010, Andrew Morton wrote:
> On Tue, 20 Apr 2010 05:15:57 +0200 (CEST) "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=15812
> > Subject		: utsname.domainname not set in x86_32 processes (causing "YPBINDPROC_DOMAIN: domain not bound" errors)
> > Submitter	:  <adi@hexapodia.org>
> > Date		: 2010-04-19 21:28 (1 days old)
> 
> I merged hch's fix for this twelve seconds ago.

I updated the entry.
