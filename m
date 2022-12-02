Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D25C4332F
	for <linux-pm@archiver.kernel.org>; Fri,  2 Dec 2022 19:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbiLBTtH (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 2 Dec 2022 14:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbiLBTs7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Dec 2022 14:48:59 -0500
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F83F140E;
        Fri,  2 Dec 2022 11:48:59 -0800 (PST)
Received: by mail-qv1-f45.google.com with SMTP id o12so4109563qvn.3;
        Fri, 02 Dec 2022 11:48:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8qjK3a1pWzqgDItN3g9EK0V1DK52FhicwQlRSLLHjgw=;
        b=6q0qVZ/Opo56pFqBSXiDBTfQ+6H25VV0MiJpnZ7qIT14IRSA6cZKV/RTtY0NZ7U80h
         rMPjB/RfrFYbl92bQVWyOcAaM1YNpZy2BUlsrMEjhqGmMJnsRJnMHT++qOceWht2JVyZ
         23aWa2JR+24WG6NL8u8QohyHeNPHkAw53zYfmuBFiMYUtz/Y9MF8CDFDaNORcQmKxhhC
         xyzmaP2AJsff7cOK5pfASNlOmnJR8dGz1OBUe90NcxY1xBgo7s1maHBRrZjk7LKeMmsR
         t8Qys+lZ023MffICygqe4JpOJ//VS0MTgFb/p3CwXlgqGI8nnzT2S/lgWHvTyHVP04me
         bP+w==
X-Gm-Message-State: ANoB5pkXviDkVo1gaKn2WTWFV0FeddjvP38TbuXvAnc/LeZL9/JW/Q1i
        lKltlSm2Y2sZUtO4HMNmYgy/o04k9KjNXmyoq80=
X-Google-Smtp-Source: AA0mqf6YDg4gweJTTyr8KtYvVDvVd72AtgBpX5BpYmqAXeo3TAuWoDS8y2D5PvLblNwsVLNBeVomId3ZHuk+GB9qMyI=
X-Received: by 2002:a0c:c589:0:b0:4b1:a9ac:21de with SMTP id
 a9-20020a0cc589000000b004b1a9ac21demr48229101qvj.119.1670010538291; Fri, 02
 Dec 2022 11:48:58 -0800 (PST)
MIME-Version: 1.0
References: <20221128162001.31227-1-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20221128162001.31227-1-ricardo.neri-calderon@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 2 Dec 2022 20:48:47 +0100
Message-ID: <CAJZ5v0h29B-r7TqAD5wqDX6d-uMpUrFainirYWwPhiuDy9HRwQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: hfi: Remove a pointless die_id check
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Haowen Bai <baihaowen@meizu.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 28, 2022 at 5:12 PM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> die_id is an u16 quantity. On single-die systems the default value of
> die_id is 0. No need to check for negative values.
>
> Plus, removing this check makes Coverity happy.
>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Amit Kucheria <amitk@kernel.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Aubrey Li <aubrey.li@linux.intel.com>
> Cc: Haowen Bai <baihaowen@meizu.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
>  drivers/thermal/intel/intel_hfi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> index 239afe02e518..d35287eb2f78 100644
> --- a/drivers/thermal/intel/intel_hfi.c
> +++ b/drivers/thermal/intel/intel_hfi.c
> @@ -371,7 +371,7 @@ void intel_hfi_online(unsigned int cpu)
>         die_id = topology_logical_die_id(cpu);
>         hfi_instance = info->hfi_instance;
>         if (!hfi_instance) {
> -               if (die_id < 0 || die_id >= max_hfi_instances)
> +               if (die_id >= max_hfi_instances)
>                         return;
>
>                 hfi_instance = &hfi_instances[die_id];
> --

Applied as 6.2 material, thanks!
