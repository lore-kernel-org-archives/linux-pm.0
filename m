Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E591647987F
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 13:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784813172; cv=none; b=ULRtVKX8Wx/5Vwvwd3nBectdiZKeTEXs+4TgHw8W0/OkcaqvvMQ3W/Vv74QDkjgYojLjVZARHKlXM/g5KDUUeFT+f7v3ktWlpCrcX71814tY7J6IJEdoWSK8tTlEHMmDGSz6v1m/lb/VnjYoDx7KXeCN/ZmNlrzSbhJweWEVQkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784813172; c=relaxed/simple;
	bh=KJGjPS+gghyF4lEQeyswTSDvIC0+hS+PB2TpKH1/3j4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fnZUnkZzhuC39uFqHwJYjveIRxogfTj8RyO6gyOHabcvtUJCNJk0KqT7aYKocoJdL81HzhUyTX2EmG34kGdPLrpsC8uRtDPu6VnuRIQmRAGibFiUzSF5uQ6S1EpF5GM+X3RA9+gHBjndd8F90bvxnygl23DGmq1VCIpjn7gFSvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B071F00A3E
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 13:26:08 +0000 (UTC)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b14d1f9315so548103e87.2
        for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 06:26:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq5ehTaREjlCLOtWm/uRPEnSze5KGIedxWgmRrq1d04W6TLoAuMQBSpBOx+6TV/vojB9qL4QwlbKg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwyaGtWe43Td1ONNk0mQrqJMVb+U1uAobPVElodClXgTr5XFb5A
	gdWZXJoPoAHSyN14kujncpNTuIflQ3QUTApy7qdWo8nLeysgNhZIq7Q55FAJBJ2MiAzJqB6hl2F
	pjEhIkazn4TpZa0BL3qhO4M3FqDqC9g8=
X-Received: by 2002:a05:6512:606:10b0:5ae:bce4:b696 with SMTP id
 2adb3069b0e04-5b2b2e57b65mr473189e87.15.1784813166560; Thu, 23 Jul 2026
 06:26:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714072627.3165744-1-mattkim513@gmail.com>
In-Reply-To: <20260714072627.3165744-1-mattkim513@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 23 Jul 2026 15:25:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j31As0sW_p+dKcSqhbo825WaZM-gWV6_==3ztbPxNDxQ@mail.gmail.com>
X-Gm-Features: AUfX_mzipNP9iL_J2EmwacOOpcml9_u7N6pj-SrOT0g5gma2SDYijbeUkNqyNiw
Message-ID: <CAJZ5v0j31As0sW_p+dKcSqhbo825WaZM-gWV6_==3ztbPxNDxQ@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: swap: defer linking the next map page
To: Haesung Kim <mattkim513@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, matia.kim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 9:26=E2=80=AFAM Haesung Kim <mattkim513@gmail.com> =
wrote:
>
> Delay allocating and linking the next swap_map_page until another image
> page actually needs to be recorded.
>
> The previous code linked and wrote a new swap map page as soon as the
> current one became full. When the image size was an exact multiple of
> MAP_PAGE_ENTRIES, that left an empty final map page that existed only to
> terminate the on-disk chain.
>
> Instead, keep a full map page in memory and only allocate the next map pa=
ge
> when the next image page arrives. This preserves the resume chain while
> avoiding an unnecessary swap slot allocation and write for the empty
> swap map page.
>
> Signed-off-by: Haesung Kim <mattkim513@gmail.com>
> ---
>  kernel/power/swap.c | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index c626e9dc3c1c..e5cffb399e3a 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -430,19 +430,22 @@ static int swap_write_page(struct swap_map_handle *=
handle, void *buf,
>
>         if (!handle->cur)
>                 return -EINVAL;
> -       offset =3D alloc_swapdev_block(root_swap);
> -       error =3D write_page(buf, offset, hb);
> -       if (error)
> -               return error;
> -       handle->cur->entries[handle->k++] =3D offset;
> +
> +       /*
> +        * If the current map page is full, allocate and link next one fi=
rst.
> +        * Delaying this until here avoids writing an empty swap map page=
 when
> +        * the image size is an exact MAP_PAGE_ENTRIES multiple.
> +        */
>         if (handle->k >=3D MAP_PAGE_ENTRIES) {
>                 offset =3D alloc_swapdev_block(root_swap);
>                 if (!offset)
>                         return -ENOSPC;
> +
>                 handle->cur->next_swap =3D offset;
>                 error =3D write_page(handle->cur, handle->cur_swap, hb);
>                 if (error)
> -                       goto out;
> +                       return error;
> +
>                 clear_page(handle->cur);
>                 handle->cur_swap =3D offset;
>                 handle->k =3D 0;
> @@ -450,7 +453,7 @@ static int swap_write_page(struct swap_map_handle *ha=
ndle, void *buf,
>                 if (hb && low_free_pages() <=3D handle->reqd_free_pages) =
{
>                         error =3D hib_wait_io(hb);
>                         if (error)
> -                               goto out;
> +                               return error;
>                         /*
>                          * Recalculate the number of required free pages,=
 to
>                          * make sure we never take more than half.
> @@ -458,14 +461,21 @@ static int swap_write_page(struct swap_map_handle *=
handle, void *buf,
>                         handle->reqd_free_pages =3D reqd_free_pages();
>                 }
>         }
> - out:
> -       return error;
> +
> +       offset =3D alloc_swapdev_block(root_swap);
> +       error =3D write_page(buf, offset, hb);
> +       if (error)
> +               return error;
> +       handle->cur->entries[handle->k++] =3D offset;
> +       return 0;
>  }
>
>  static int flush_swap_writer(struct swap_map_handle *handle)
>  {
> -       if (handle->cur && handle->cur_swap)
> +       if (handle->cur && handle->cur_swap && handle->k)
>                 return write_page(handle->cur, handle->cur_swap, NULL);
> +       else if (handle->cur && handle->cur_swap)
> +               return 0;
>         else
>                 return -EINVAL;
>  }
> --

Applied as 7.3 material, thanks!
