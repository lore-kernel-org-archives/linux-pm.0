From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCH] epoll_ctl.2: minor clarification concerning when a WAKEUP event is "processes"
Date: Wed, 09 Jul 2014 14:37:08 +0200
Message-ID: <4463815.T873Vrf1pJ@vostro.rjw.lan>
References: <20140706190351.423e9a93@notabene.brown> <20140707210157.1aa38ed0@notabene.brown> <20140709133746.70d0dffb@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140709133746.70d0dffb-wvvUuzkyo1EYVZTmpyfIwg@public.gmane.org>
Sender: linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
Cc: "Michael Kerrisk (man-pages)" <mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, July 09, 2014 01:37:46 PM NeilBrown wrote:
> 
> --Sig_/BvtUQvnWLsVQBetw73gPkyQ
> Content-Type: text/plain; charset=US-ASCII
> Content-Transfer-Encoding: quoted-printable
> 
> 
> I guess it should be obvious, but it never hurts to be explicit.
> When the epoll file descriptor is closed all events are assumed
> to be "processed".
> Also if the event is removed with EPOLL_CTL_DEL or the EPOLLWAKEUP
> flag is removed with EPOLL_CTL_MOD the event will be "processed".
> 
> 
> Signed-off-by: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

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
> --Sig_/BvtUQvnWLsVQBetw73gPkyQ
> Content-Type: application/pgp-signature; name=signature.asc
> Content-Disposition: attachment; filename=signature.asc
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2.0.22 (GNU/Linux)
> 
> iQIVAwUBU7y5Cjnsnt1WYoG5AQJjuQ/+JshOD5nn4wRh83j+QK8Y1ff1Fynw2jh4
> vWGGdF/XdEyJgagnFuIuVHHmn0yyGvGYE8xFzgtBJqs12O6+7AshRUXtCSjr6f7r
> kwa4dZQvwDMr0SchoIsftexZJJPQOE7zxDwm7jjk7682/VoePbCtXHUnVUM3G6Hl
> 5n/11WDocetHFztj95lIF8KIQZ98Q7ZOETvdxnZXIvBtxxaPLVdOS/a7d8q2bcP3
> /rvM+JyA0SnUx3ZFTbqYWmUk/WWDjXhBEwt5fSqqph4zOT7sxjCH1kmap1MV4ej2
> ZzQ5rgecQDL+YAJTLYNKeDCeYpGQYVDNUK4oLq5ofsNLcump3jAlnUfmB96ifD7h
> iXxWExv9r1Zk3aS//ZRgFQuGas+w23wklEjaavwQFt9S0aoS6zmcsSWpucyvpYCW
> JOguVvqO4qphadh1gfOhWEpYVgD9AhADqICLymwcVAphYq/TenRqFPv7UdbcBE0l
> vDM5D8R0bLrcHLheA2YWwwxTDdZo49D08Pf7RopKbnoMxmwpoxRdkYiJ/n981wgR
> 4S3FQgSAD+wsI87kwkf0uU3YXT5IYrMt5VoaQZysDTC1ryPuHn4JPexw0YRDOd7l
> D+SSounos3jqMTVsmKolA84pSMmEcPwQ0624QHouWWkGVlcApIw2xDgr1c6TYzPq
> s/V/0SXPztU=
> =8PYy
> -----END PGP SIGNATURE-----
> 
> --Sig_/BvtUQvnWLsVQBetw73gPkyQ--
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-man" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
