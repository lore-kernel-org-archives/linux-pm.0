From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.34-rc5: Reported regressions from 2.6.33
Date: Mon, 19 Apr 2010 20:57:23 -0400
Message-ID: <20100419205723.8724338c.akpm__1020.04544246501$1271735992$gmane$org@linux-foundation.org>
References: <deuQKFRcc0B.A.3EG.BRSzLB@tosh>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <deuQKFRcc0B.A.3EG.BRSzLB@tosh>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: DRI <dri-devel@lists.sourceforge.net>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux@smtp1.linux-foundation.org, List <linux-pm@lists.linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tue, 20 Apr 2010 05:15:57 +0200 (CEST) "Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=15812
> Subject		: utsname.domainname not set in x86_32 processes (causing "YPBINDPROC_DOMAIN: domain not bound" errors)
> Submitter	:  <adi@hexapodia.org>
> Date		: 2010-04-19 21:28 (1 days old)

I merged hch's fix for this twelve seconds ago.
