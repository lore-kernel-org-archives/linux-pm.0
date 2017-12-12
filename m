From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] drivers: base: power: Fix GFP_KERNEL in spinlock context
Date: Tue, 12 Dec 2017 15:58:00 +0100
Message-ID: <CAMuHMdUrhV9RkUnXkTbSWaRY33iQrANwbKBE5KAPQseNgxOofg@mail.gmail.com>
References: <1513086342-3581-1-git-send-email-shrikant.maurya@techveda.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:37017 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753003AbdLLO6C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Dec 2017 09:58:02 -0500
In-Reply-To: <1513086342-3581-1-git-send-email-shrikant.maurya@techveda.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: shrikant.maurya@techveda.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg KH <gregkh@linuxfoundation.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Suniel Mahesh <sunil.m@techveda.org>, Karthik Tummala <karthik@techveda.org>, raghu@techveda.org

Hi Shrikant,

On Tue, Dec 12, 2017 at 2:45 PM,  <shrikant.maurya@techveda.org> wrote:
> From: Shrikant Maurya <shrikant.maurya@techveda.org>
>
> As reported by Jia-Ju Bai (https://lkml.org/lkml/2017/12/11/872):
> API's are using GFP_KERNEL to allocate memory which may sleep.
>
> To ensure atomicity such allocations must be avoided in critical
> sections under spinlock.
> Fixed by replacing GFP_KERNEL to GFP_ATOMIC.
>
> Reported-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> Signed-off-by: Shrikant Maurya <shrikant.maurya@techveda.org>
> Signed-off-by: Suniel Mahesh <sunil.m@techveda.org>
> Signed-off-by: Raghu Bharadwaj <raghu@techveda.org>
> Signed-off-by: Karthik Tummala <karthik@techveda.org>

Can't the call to device_init_wakeup() in isp116x_start() just be moved
below the spinlock release?

> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -92,11 +92,11 @@ struct wakeup_source *wakeup_source_create(const char *name)
>  {
>         struct wakeup_source *ws;
>
> -       ws = kmalloc(sizeof(*ws), GFP_KERNEL);
> +       ws = kmalloc(sizeof(*ws), GFP_ATOMIC);

With GFP_ATOMIC, allocation failure is much more likely to occur.
So IMHO it's better to fix the isp116x, than to impose this burden on
every user.

>         if (!ws)
>                 return NULL;
>
> -       wakeup_source_prepare(ws, name ? kstrdup_const(name, GFP_KERNEL) : NULL);
> +       wakeup_source_prepare(ws, name ? kstrdup_const(name, GFP_ATOMIC) : NULL);
>         return ws;
>  }
>  EXPORT_SYMBOL_GPL(wakeup_source_create);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
