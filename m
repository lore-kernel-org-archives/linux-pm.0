From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1 1/1] intel_idle: Add CPU model 74 (Atom Z34xx series)
Date: Wed, 15 Jun 2016 21:14:48 -0400
Message-ID: <CAJvTdKmDWQPtfHBtTEF2-_Ax=PvUpc6E56wR=6GjJcKf-kjXQw@mail.gmail.com>
References: <1465232806-138619-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f66.google.com ([209.85.192.66]:36628 "EHLO
	mail-qg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932084AbcFPBOt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jun 2016 21:14:49 -0400
Received: by mail-qg0-f66.google.com with SMTP id 78so3164188qgt.3
        for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2016 18:14:49 -0700 (PDT)
In-Reply-To: <1465232806-138619-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>

Hi Andy,

Is this a patch from the Android kernel tree?
Is there anybody testing the upstream kernel on this hardware?

Past efforts to support old hardware that nobody tests upstream
have resulted in all pain and no gain, and I'm not eager to
repeat that experience.

thanks,
-Len


On Mon, Jun 6, 2016 at 1:06 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Add CPU ID for Atom Z34xx processors. Datasheets indicate support for this,
> detailed information about potential quirks or limitations are missing, though.
> So we just reuse the definition for the previous ATOM series. The quite similar
> values (C1 is slightly deviated) are used in the official Intel Edison BSP.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/idle/intel_idle.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index c966492..bb52275 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1033,6 +1033,7 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
>         ICPU(0x2d, idle_cpu_snb),
>         ICPU(0x36, idle_cpu_atom),
>         ICPU(0x37, idle_cpu_byt),
> +       ICPU(0x4a, idle_cpu_atom),
>         ICPU(0x4c, idle_cpu_cht),
>         ICPU(0x3a, idle_cpu_ivb),
>         ICPU(0x3e, idle_cpu_ivt),
> --
> 2.8.1
>



-- 
Len Brown, Intel Open Source Technology Center
