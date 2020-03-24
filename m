Return-Path: <SRS0=R0/j=5J=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30DDC43331
	for <linux-pm@archiver.kernel.org>; Tue, 24 Mar 2020 12:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4DD2208CA
	for <linux-pm@archiver.kernel.org>; Tue, 24 Mar 2020 12:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585054441;
	bh=k6ZXBz8QD/4kfv0bHfHEBCFIfqVCqXs/r7Ewz8zRoI4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Sv804PGAP5Xk/XBDcqWR+R1/OMigzUfUIRcCFGLNvCpo0dGnCAEpTx0naj9kG/vyT
	 uTSkcl73KVI4yJG7hzJe1NArQFbbpTCBY4+F1E4UWkP2Df6nh4vbBiWt6ubv5dJn3D
	 nFMuS/xdOMRpGVw8T/U+A4eHe+wj5iMnRX3zpTL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbgCXMyA (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 24 Mar 2020 08:54:00 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46096 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbgCXMyA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Mar 2020 08:54:00 -0400
Received: by mail-oi1-f195.google.com with SMTP id q204so10494512oia.13;
        Tue, 24 Mar 2020 05:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U2wacXSgZRrqld91nBc+2P+qMpfsyfKnAMjLEtgLRG4=;
        b=os2wygwx9Ubr6F4iCHo5w5vJxejnZVsA5ujDrN1N14BXS/m8LvgaVSb5fNrKng0br/
         UzDug9F9TkoFZMM6mGLSlqPSlQOU2PdPtsUDPQrLQPh4ySuPNM3YQfPLX88hVONHkzHz
         fPyidMz/x+Qrdlu5VqFCSZOtDC2trRyrgL2hes0NCBOD4BJeDsLGvPmp4jIe6Y3J8JKr
         2SyhUkWBNYvh7AlJ92Lzzm5OGxPd7LP+bVJx+WgQe0q3LbzxpkvqUHhlL7tYqj241HUJ
         mDKhddduuCS4ql9EbQ+u5LN/PhrzuWwEYBNRc1Ep8hy0s4peshP9qFU/B+enKsfvViYG
         9v/Q==
X-Gm-Message-State: ANhLgQ1VXyoZbgy3v4AttphauVba/nKDpnTJ96RxQILxTfytcVX9+SSn
        EzT9uxtKTew3hdA92jYM/7ni4hNj15F5FvUi/6I=
X-Google-Smtp-Source: ADFU+vu7lVRzij8BdL1iZw5BZVh5vAngXo/3An/UPrFI5dVBYGsPsfi/P3xlGxQQEheZNQWTIsm/Frn0qvjDay39+WI=
X-Received: by 2002:aca:5155:: with SMTP id f82mr3313363oib.103.1585054439854;
 Tue, 24 Mar 2020 05:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200324122023.9649-1-andriy.shevchenko@linux.intel.com> <20200324122023.9649-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200324122023.9649-3-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 24 Mar 2020 13:53:49 +0100
Message-ID: <CAJZ5v0gg=V8uDd4afJ3MULsgKYvWajKJioANk4jj7xEhBzrRrQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] driver core: Replace open-coded list_last_entry()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 24, 2020 at 1:20 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> There is a place in the code where open-coded version of list entry accessors
> list_last_entry() is used.
>
> Replace that with the standard macro.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> v2: no change
>  drivers/base/dd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index efd0e4c16ba5..27a4d51b5bba 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -1226,7 +1226,7 @@ void driver_detach(struct device_driver *drv)
>                         spin_unlock(&drv->p->klist_devices.k_lock);
>                         break;
>                 }
> -               dev_prv = list_entry(drv->p->klist_devices.k_list.prev,
> +               dev_prv = list_last_entry(&drv->p->klist_devices.k_list,
>                                      struct device_private,
>                                      knode_driver.n_node);
>                 dev = dev_prv->device;
> --
> 2.25.1
>
