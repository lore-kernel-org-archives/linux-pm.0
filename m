From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 5/9] PM / Hibernate: add chunk i/o support
Date: Fri, 25 Jun 2010 15:44:44 +0200
Message-ID: <201006251544.45121.rjw__45609.029781963$1277473715$gmane$org@sisk.pl>
References: <1275468768-28229-1-git-send-email-jslaby@suse.cz>
	<1275468768-28229-5-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1275468768-28229-5-git-send-email-jslaby@suse.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com
List-Id: linux-pm@vger.kernel.org

On Wednesday, June 02, 2010, Jiri Slaby wrote:
> Chunk support is useful when not writing whole pages at once. It takes
> care of joining the buffers into the pages and writing at once when
> needed.
> 
> This adds functions for both reads and writes.
> 
> In the end when pages are compressed they use this interface as well
> (because they are indeed shorter than PAGE_SIZE).

This one looks good up to a couple of minor things below.

> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> ---
>  kernel/power/block_io.c |  126 +++++++++++++++++++++++++++++++++++++++++++++++
>  kernel/power/power.h    |   16 ++++++
>  2 files changed, 142 insertions(+), 0 deletions(-)
> 
> diff --git a/kernel/power/block_io.c b/kernel/power/block_io.c
> index 97024fd..5b6413d 100644
> --- a/kernel/power/block_io.c
> +++ b/kernel/power/block_io.c
> @@ -3,6 +3,7 @@
>   *
>   * Copyright (C) 1998,2001-2005 Pavel Machek <pavel@ucw.cz>
>   * Copyright (C) 2006 Rafael J. Wysocki <rjw@sisk.pl>
> + * Copyright (C) 2004-2008 Nigel Cunningham (nigel at tuxonice net)

Please use the e-mail address.

>   *
>   * This file is released under the GPLv2.
>   */
> @@ -74,6 +75,131 @@ int hib_bio_write_page(pgoff_t page_off, void *addr, struct bio **bio_chain)
>  			virt_to_page(addr), bio_chain);
>  }
>  
> +static int hib_buffer_init_rw(struct hibernate_io_handle *io_handle,
> +		int writing)
> +{
> +	/* should never happen - it means we didn't finish properly last time */
> +	BUG_ON(io_handle->chunk_buffer || io_handle->chunk_buffer_pos);

Please use if (WARN_ON(...)) retuirn -EINVAL; instead.  The BUG_ON() will kill
an otherwise perfectly useable system just because we happen to have a bug in
the hibernation code.

Generally, please don't use BUG_ON() unless you _have_ _to_ (ie. the system
would crash anyway causing data loss and possibly other damage to happen if
we didn't do it).

Rafael
