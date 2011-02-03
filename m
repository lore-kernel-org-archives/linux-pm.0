From: "Carlos R. Mafra" <crmafra2@gmail.com>
Subject: Re: 2.6.38-rc3-git1: Reported regressions 2.6.36 ->
	2.6.37
Date: Thu, 3 Feb 2011 12:23:16 +0100
Message-ID: <20110203112316.GA3718__40034.9807613113$1296833736$gmane$org@linux-yscl.site>
References: <e9vOd5LzdBK.A.dyD.h6eSNB@chimera>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <e9vOd5LzdBK.A.dyD.h6eSNB@chimera>
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
Cc: Linux SCSI List <linux-scsi@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI <dri-devel@lists.freedesktop.org>, Florian Mickler <florian@mickler.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thu  3.Feb'11 at  1:03:41 +0100, Rafael J. Wysocki wrote:
> 
> If you know of any other unresolved post-2.6.36 regressions, please let us know
> either and we'll add them to the list.  Also, please let us know if any
> of the entries below are invalid.

I'm sorry if I'm overlooking something, but as far as I can see the regression
reported here:

https://lkml.org/lkml/2011/1/24/457

is not in the list (update on that report: reverting that commit on top of 
2.6.37 fixes the issue).

After some time, I also ended up finding an earlier report in the kernel bugzilla
which I think is the same regression (it was bisected to the same commit):

https://bugzilla.kernel.org/show_bug.cgi?id=24982

but I do not see it in the list either, even though it's marked as a
regression in the bugzilla.

The issue was also present in 2.6.38-rc2 last time I tested.
