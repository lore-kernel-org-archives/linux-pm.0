From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/9] PM / Hibernate: swap,
	switch to hibernate_io_handle
Date: Thu, 10 Jun 2010 15:55:41 +0200
Message-ID: <20100610135541.GB4514__29432.5523348109$1276178203$gmane$org@ucw.cz>
References: <1275468768-28229-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1275468768-28229-1-git-send-email-jslaby@suse.cz>
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

Hi!

> I addressed the comments I got on the previous RFC. I left the handles
> in place, the functions in hibernate_io_ops now works on them. Further
> I got rid of the memory barriers and minimized global variables as much
> as possible. Comments welcome.

It would be good if you carried ack-s from previous rounds, so that I
don't have to review good patches again...

> Some code, which will be moved out of swap.c, will know nothing about
> swap. There will be also other than swap writers later, so that it
> won't make sense at all.
> 
> So introduce a new structure called hibernate_io_handle which
> currently contains only a pointer to private data, but is independent
> on I/O reader/writer actually used. Private data are swap_map_handle
> for now.
> 
> This structure is allocated in _start and freed in _finish. This will
> correspond to the later introduction of hibernate_io_ops where users
> will do handle=start->repeat{read/write(handle)}->finish(handle).
> I.e. they will operate on handle instead of global variables.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>

 ack.

> +/**
> + * hib_io_handle_alloc - allocate io handle with priv_size for private data
> + *
> + * @priv_size: the sie to allocate behind hibernate_io_handle for private use
> + */
> +static inline struct hibernate_io_handle *hib_io_handle_alloc(size_t priv_size)
> +{
> +	struct hibernate_io_handle *ret;
> +	ret = kzalloc(sizeof(*ret) + priv_size, GFP_KERNEL);
> +	if (ret)
> +		ret->priv = ret + 1;

Uhuh, why this? Aha, grabbing the pointer to priv_size-sized area at
the end of regular struct?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
