From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v1 1/8] mm: balloon: update comment about
 isolation/migration/compaction
Date: Tue, 20 Nov 2018 20:56:14 -0500
Message-ID: <20181120204655-mutt-send-email-mst@kernel.org>
References: <20181119101616.8901-1-david@redhat.com>
 <20181119101616.8901-2-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <20181119101616.8901-2-david@redhat.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>, linux-pm@vger.kernel.org, pv-drivers@vmware.com, linux-doc@vger.kernel.org, kexec-ml <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, devel@linuxdriverproject.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 19, 2018 at 11:16:09AM +0100, David Hildenbrand wrote:
> Commit b1123ea6d3b3 ("mm: balloon: use general non-lru movable page
> feature") reworked balloon handling to make use of the general
> non-lru movable page feature. The big comment block in
> balloon_compaction.h contains quite some outdated information. Let's fix
> this.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  include/linux/balloon_compaction.h | 26 +++++++++-----------------
>  1 file changed, 9 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
> index 53051f3d8f25..cbe50da5a59d 100644
> --- a/include/linux/balloon_compaction.h
> +++ b/include/linux/balloon_compaction.h
> @@ -4,15 +4,18 @@
>   *
>   * Common interface definitions for making balloon pages movable by compaction.
>   *
> - * Despite being perfectly possible to perform ballooned pages migration, they
> - * make a special corner case to compaction scans because balloon pages are not
> - * enlisted at any LRU list like the other pages we do compact / migrate.
> + * Balloon page migration makes use of the general non-lru movable page
> + * feature.
> + *
> + * page->private is used to reference the responsible balloon device.
> + * page->mapping is used in context of non-lru page migration to reference
> + * the address space operations for page isolation/migration/compaction.
>   *
>   * As the page isolation scanning step a compaction thread does is a lockless
>   * procedure (from a page standpoint), it might bring some racy situations while
>   * performing balloon page compaction. In order to sort out these racy scenarios
>   * and safely perform balloon's page compaction and migration we must, always,
> - * ensure following these three simple rules:
> + * ensure following these simple rules:
>   *
>   *   i. when updating a balloon's page ->mapping element, strictly do it under
>   *      the following lock order, independently of the far superior
> @@ -21,19 +24,8 @@
>   *	      +--spin_lock_irq(&b_dev_info->pages_lock);
>   *	            ... page->mapping updates here ...
>   *
> - *  ii. before isolating or dequeueing a balloon page from the balloon device
> - *      pages list, the page reference counter must be raised by one and the
> - *      extra refcount must be dropped when the page is enqueued back into
> - *      the balloon device page list, thus a balloon page keeps its reference
> - *      counter raised only while it is under our special handling;
> - *
> - * iii. after the lockless scan step have selected a potential balloon page for
> - *      isolation, re-test the PageBalloon mark and the PagePrivate flag
> - *      under the proper page lock, to ensure isolating a valid balloon page
> - *      (not yet isolated, nor under release procedure)
> - *
> - *  iv. isolation or dequeueing procedure must clear PagePrivate flag under
> - *      page lock together with removing page from balloon device page list.
> + *  ii. isolation or dequeueing procedure must remove the page from balloon
> + *      device page list under b_dev_info->pages_lock.
>   *
>   * The functions provided by this interface are placed to help on coping with
>   * the aforementioned balloon page corner case, as well as to ensure the simple
> -- 
> 2.17.2
