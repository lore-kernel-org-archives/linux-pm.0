From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH v7 0/6] solve deadlock caused by memory allocation with
 I/O
Date: Thu, 17 Jan 2013 13:57:26 -0800
Message-ID: <20130117135726.5b31fd0f.akpm@linux-foundation.org>
References: <1357352744-8138-1-git-send-email-ming.lei@canonical.com>
	<20130116153744.70210fa3.akpm@linux-foundation.org>
	<CACVXFVOipr0VMyPQaZTLckxTaPan7ZneERUqZ1S_mYo11A5AeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACVXFVOipr0VMyPQaZTLckxTaPan7ZneERUqZ1S_mYo11A5AeA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ming Lei <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>, Minchan Kim <minchan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Jens Axboe <axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 17 Jan 2013 09:28:14 +0800
Ming Lei <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org> wrote:

> > If so, I wonder if we could avoid the whole problem by appropriately
> > syncing all dirty memory back to storage before starting to turn devices
> > off?
> 
> The patchset is to address the probable deadlock problem by GFP_KERNEL
> during runtime suspend/resume which is per block/network device. I am
> wondering if syncing all dirty memory is suitable or necessary during
> per-storage/network device runtime resume/suspend:
> 
>       - sys_sync is very slow and runtime pm operation is frequent
> 
>       - it is not efficient because only sync dirty memory against the affected
>         device is needed in theory and not necessary to sync all
> 
>      - we still need some synchronization to avoid accessing the storage
>        between sys_sync and device suspend, just like system sleep case,
>        pm_restrict_gfp_mask is needed even sys_sync has been done
>        inside enter_state().
> 
> So looks the approach in the patch is simpler and more efficient, :-)
> 
> Also, with the patchset, we can avoid many GFP_NOIO allocation
> which is fragile and not easy to use.

Fair enough, thanks.

I grabbed the patches for 3.9-rc1.  It is good that the page
allocator's newly-added test of current->flags is not on the fastpath.

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
