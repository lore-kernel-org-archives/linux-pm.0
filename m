From: "Chris Friesen" <cfriesen@nortel.com>
Subject: Re: 2.6.29-git13: Reported regressions from 2.6.28
Date: Thu, 16 Apr 2009 15:08:40 -0600
Message-ID: <49E79E58.9000606__39212.1249730282$1239916438$gmane$org@nortel.com>
References: <n4io5wq70ZO.A.gzG.rFn2JB@chimera>
	<alpine.LFD.2.00.0904061443000.7443@localhost.localdomain>
	<200904070035.00784.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200904070035.00784.rjw@sisk.pl>
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
Cc: Adrian Bunk <bunk@kernel.org>, Trenton Adams <trenton.d.adams@gmail.com>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Natalie Protasevich <protasnb@gmail.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> On Monday 06 April 2009, Linus Torvalds wrote:
>> On Mon, 6 Apr 2009, Rafael J. Wysocki wrote:
>>> Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=13019
>>> Subject		: /proc/<pid>/maps offset output broken in 2.6.29
>>> Submitter	: "Chris Friesen" <cfriesen@nortel.com>
>>> Date		: 2009-04-01 23:18 (6 days old)
>>> References	: http://marc.info/?l=linuxppc-embedded&m=123862902916059&w=4
>>> Handled-By	: Hugh Dickins <hugh@veritas.com>
>> I don't think that's a regression, nor really a bug. It looks cosmetic, 
>> and likely to be fixed, but not really worth worrying about.
> 
> OK, I've dropped it from the list.

I'm okay with that.  The problem causes some backwards compatibility 
problems with existing apps that get confused by the large "offset" 
number.  The fix is going to cause problems too, but in a different way.

We'll work around it.

Chris
