From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/5] PM/Hibernate: Move memory shrinking to
	snapshot.c	(rev. 2)
Date: Mon, 4 May 2009 15:35:21 +0200
Message-ID: <20090504133520.GA1393__28369.1301978708$1241444267$gmane$org@ucw.cz>
References: <nY3-4PrO6XH.A.xtB.yw85JB@chimera> <200905031830.49690.rjw@sisk.pl>
	<200905040208.43040.rjw@sisk.pl> <200905040211.03569.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200905040211.03569.rjw@sisk.pl>
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
Cc: kernel-testers@vger.kernel.org, linux-kernel@vger.kernel.org, alan-jenkins@tuffmail.co.uk, jens.axboe@oracle.com, linux-pm@lists.linux-foundation.org, Wu Fengguang <fengguang.wu@intel.com>, torvalds@linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon 2009-05-04 02:11:02, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> The next patch is going to modify the memory shrinking code so that
> it will make memory allocations to free memory instead of using an
> artificial memory shrinking mechanism for that.  For this purpose it
> is convenient to move swsusp_shrink_memory() from
> kernel/power/swsusp.c to kernel/power/snapshot.c, because the new
> memory-shrinking code is going to use things that are local to
> kernel/power/snapshot.c .
> 
> [rev. 2: Make some functions static and remove their headers from
>  kernel/power/power.h]
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
