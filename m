From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 3/6] mm,
	PM/Freezer: Disable OOM killer when tasks are	frozen
Date: Wed, 13 May 2009 11:19:42 +0200
Message-ID: <20090513091942.GC27261__25111.9264438332$1242206573$gmane$org@elf.ucw.cz>
References: <200905070040.08561.rjw@sisk.pl> <200905101548.57557.rjw@sisk.pl>
	<200905131032.53624.rjw@sisk.pl> <200905131037.50011.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200905131037.50011.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, David Rientjes <rientjes@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed 2009-05-13 10:37:49, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Currently, the following scenario appears to be possible in theory:
> 
> * Tasks are frozen for hibernation or suspend.
> * Free pages are almost exhausted.
> * Certain piece of code in the suspend code path attempts to allocate
>   some memory using GFP_KERNEL and allocation order less than or
>   equal to PAGE_ALLOC_COSTLY_ORDER.
> * __alloc_pages_internal() cannot find a free page so it invokes the
>   OOM killer.
> * The OOM killer attempts to kill a task, but the task is frozen, so
>   it doesn't die immediately.
> * __alloc_pages_internal() jumps to 'restart', unsuccessfully tries
>   to find a free page and invokes the OOM killer.
> * No progress can be made.
> 
> Although it is now hard to trigger during hibernation due to the
> memory shrinking carried out by the hibernation code, it is
> theoretically possible to trigger during suspend after the memory
> shrinking has been removed from that code path.  Moreover, since
> memory allocations are going to be used for the hibernation memory
> shrinking, it will be even more likely to happen during hibernation.
> 
> To prevent it from happening, introduce the oom_killer_disabled
> switch that will cause __alloc_pages_internal() to fail in the
> situations in which the OOM killer would have been called and make
> the freezer set this switch after tasks have been successfully
> frozen.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
