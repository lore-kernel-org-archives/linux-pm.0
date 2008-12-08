From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH -suspend] Hibernate: Replace unnecessary
	evaluation of	pfn_to_page()
Date: Mon, 8 Dec 2008 08:26:58 +0100
Message-ID: <20081208072657.GA2418__31592.7944532179$1228721508$gmane$org@ucw.cz>
References: <200812080052.49604.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200812080052.49604.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon 2008-12-08 00:52:49, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: Hibernate: Replace unnecessary evaluation of pfn_to_page()
> 
> Replace one evaluation of pfn_to_page() in copy_data_pages() with
> the value of a local variable containing the right number already.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Acked-by: Pavel Machek <pavel@suse.cz>

> ---
>  kernel/power/snapshot.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6/kernel/power/snapshot.c
> ===================================================================
> --- linux-2.6.orig/kernel/power/snapshot.c
> +++ linux-2.6/kernel/power/snapshot.c
> @@ -981,7 +981,7 @@ static void copy_data_page(unsigned long
>  			 * data modified by kmap_atomic()
>  			 */
>  			safe_copy_page(buffer, s_page);
> -			dst = kmap_atomic(pfn_to_page(dst_pfn), KM_USER0);
> +			dst = kmap_atomic(d_page, KM_USER0);
>  			memcpy(dst, buffer, PAGE_SIZE);
>  			kunmap_atomic(dst, KM_USER0);
>  		} else {

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
