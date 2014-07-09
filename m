From: "Michael Kerrisk (man-pages)" <mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] epoll_ctl.2: minor clarification concerning when a WAKEUP
 event is "processes"
Date: Wed, 09 Jul 2014 10:26:53 +0200
Message-ID: <53BCFCCD.6030300@gmail.com>
References: <20140706190351.423e9a93@notabene.brown>	<53BA4244.30502@gmail.com>	<20140707210157.1aa38ed0@notabene.brown> <20140709133746.70d0dffb@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140709133746.70d0dffb-wvvUuzkyo1EYVZTmpyfIwg@public.gmane.org>
Sender: linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
Cc: mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Neil,
On 07/09/2014 05:37 AM, NeilBrown wrote:
> 
> I guess it should be obvious, but it never hurts to be explicit.
> When the epoll file descriptor is closed all events are assumed
> to be "processed".
> Also if the event is removed with EPOLL_CTL_DEL or the EPOLLWAKEUP
> flag is removed with EPOLL_CTL_MOD the event will be "processed".

Thanks. Probably better to be explicit, as you say. Applied.

Cheers,

Michael


> Signed-off-by: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
> 
> diff --git a/man2/epoll_ctl.2 b/man2/epoll_ctl.2
> index 2936bc7e97f7..74a09b6c276b 100644
> --- a/man2/epoll_ctl.2
> +++ b/man2/epoll_ctl.2
> @@ -173,7 +173,14 @@ until the next call to
>  .BR epoll_wait (2)
>  on the same
>  .BR epoll (7)
> -file descriptor.
> +file descriptor,
> +the closure of that file descriptor,
> +the removal of the event file descriptor with
> +.BR EPOLL_CTL_DEL ,
> +or the clearing of
> +.B EPOLLWAKEUP
> +for the event file descriptor with
> +.BR EPOLL_CTL_MOD .
>  See also BUGS.
>  .SH RETURN VALUE
>  When successful,
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
--
To unsubscribe from this list: send the line "unsubscribe linux-man" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
