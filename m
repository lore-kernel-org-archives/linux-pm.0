From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [RFC][PATCH 3/5] PM/Hibernate: Move memory shrinking
	to	snapshot.c (rev. 2)
Date: Fri, 8 May 2009 16:53:16 +0800
Message-ID: <20090508085316.GB25924__22558.139023795$1241773106$gmane$org@localhost>
References: <200905070040.08561.rjw@sisk.pl> <200905072348.59856.rjw@sisk.pl>
	<200905072351.57381.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200905072351.57381.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, David Rientjes <rientjes@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, May 08, 2009 at 05:51:56AM +0800, Rafael J. Wysocki wrote:
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
> Acked-by: Pavel Machek <pavel@ucw.cz>

Acked-by: Wu Fengguang <fengguang.wu@intel.com> 
