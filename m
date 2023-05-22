Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82436C77B73
	for <linux-pm@archiver.kernel.org>; Mon, 22 May 2023 16:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbjEVQvK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 22 May 2023 12:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjEVQvJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 May 2023 12:51:09 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABEDF4;
        Mon, 22 May 2023 09:51:07 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-513debc49e8so458132a12.0;
        Mon, 22 May 2023 09:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684774265; x=1687366265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=prsCEJ6oGGjSe0Cvn82lvxEASIZfzQmdFsTTFy0EMdI=;
        b=MGjQFEtKzDnkiWAP+bIyLxtMAJiNwsvLTd3Vn/RS1FCcsgEKBTleYAl/VeYRhFh3QO
         unQ57Qj8aZzoO1a0wnriI/F6iXUJ+KyUg5IwS3Z2vBP+8Uu/74KaZKnXXFuPmBLAVTUH
         wQe2KPGwyjcWH6/pTzIYEe2O/AL4eu7oqPwLMeuW7OD2lzGpEZm4KPDl52S96/XNoRbP
         Vg/rL+LN7isnY118ZZOO4ktXx3nt2gJsm86m8vkvqUkeQNaqudq+KnENRW8jMWDKQM6Q
         J64iO7GaVlGNn4G4vdHKb0r+Yag1Bc7CbK/PglALJgY8jSHxF6s+iYJAvDU9rncsPzRS
         nufA==
X-Gm-Message-State: AC+VfDzXr2ueisRB6sS2mPXM7uMSP9Q9JgmYfal5WF+4TrmHa9b98Zmm
        l1A0d0dPQQ7VcDsGo58kE9jEy/Hz0FJ15Efp/Hz0nDBO
X-Google-Smtp-Source: ACHHUZ40eA7KPDT+SqOa4Nsm/sQnxkFPSXWB3IQj0l3Y5cpLcBljg+SD+WKn9IKigDiHQrxr4sIIxUKnfVLMf0LIkLo=
X-Received: by 2002:a17:906:72d4:b0:96f:da08:d451 with SMTP id
 m20-20020a17090672d400b0096fda08d451mr3730896ejl.6.1684774265481; Mon, 22 May
 2023 09:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230520133249.22689-1-kweifat@gmail.com>
In-Reply-To: <20230520133249.22689-1-kweifat@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 22 May 2023 18:50:54 +0200
Message-ID: <CAJZ5v0guY16bicakMokQtp=_DGbBb4hk6B=RuPp_8+bd0jt+6w@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Avoid initializing variables prematurely
To:     Fieah Lim <kweifat@gmail.com>
Cc:     srinivas.pandruvada@linux.intel.com, lenb@kernel.org,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, May 20, 2023 at 3:32 PM Fieah Lim <kweifat@gmail.com> wrote:
>
> all_cpu_data struct is pretty large,

all_cpu_data is not a structure, it is an array of pointers.

If you want to clean up the code, please make sure that your cleanups
really make sense.

Also please don't make unrelated changes in one patch, this doesn't help much.

Thanks!
