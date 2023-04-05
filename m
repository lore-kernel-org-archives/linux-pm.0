Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD42C77B62
	for <linux-pm@archiver.kernel.org>; Wed,  5 Apr 2023 18:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbjDESj5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 5 Apr 2023 14:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbjDESjw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Apr 2023 14:39:52 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346261BC5;
        Wed,  5 Apr 2023 11:39:51 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id r11so143440829edd.5;
        Wed, 05 Apr 2023 11:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680719989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hf01kvsvjUqGL7/i9jyPXAdwko9hlY5PySP1S08JZ2o=;
        b=Iq7K7QBLXPura1VOrKf4cvbco9z2dZw42+jRAjPH4cbRqEC6vmbcryfVDfc55FXwnW
         7s3xTIhOGx3fEFbgNRdxhcnB7PrZJOm32N5v1KBReR7ldTT4xXCQsnWAcjMK3jgGD7mG
         N7//amTYUSfO1SdJ4myhMk/9eIZYyDA5y+CK1kyp+9VXZSHr5KTuddOzh9d3Gyp+8rsR
         JtYbGpX5B4p0Q5F1ym6uZ89ir6svlrSFZgR8yNDVMDnTE/swb7mcnOSqrUedykRQRMnn
         6pGfxfd0WJB2EiftzXDSTBetTqpzpObchxtSV7qcN/oVhxhv2Puz1GaAx7jgPQH3fBEb
         7Crg==
X-Gm-Message-State: AAQBX9eFjewwdqRVwq2kzKq7eQD242nXy05oaHO0JOYBczcq39tM5Oog
        pyBQRQNDPdoTEE/Wv19/OtLlcCFyShKFZbnSUTJDm01b
X-Google-Smtp-Source: AKy350bOANU2XzGCBd75k+fjLBMVbsqKgE8oPRzOS+2EasLew5PkGrxJaQqc5xhbZNSotr8gc/wYu/EvrgbUJj+k7j4=
X-Received: by 2002:a17:907:8c17:b0:8b1:3298:c587 with SMTP id
 ta23-20020a1709078c1700b008b13298c587mr2151268ejc.2.1680719989471; Wed, 05
 Apr 2023 11:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <ab323c72-61f9-9ac6-48ce-366f62e82091@linaro.org> <3e64e6b2-7c3f-d149-2f7d-6c41be4c4d14@linaro.org>
In-Reply-To: <3e64e6b2-7c3f-d149-2f7d-6c41be4c4d14@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 5 Apr 2023 20:39:38 +0200
Message-ID: <CAJZ5v0ji6SxrgiMRMwNDwGspxifo0FSi3d5+2O02SKM_q_OaFA@mail.gmail.com>
Subject: Re: [GIT PULL] thermal for v6.4-rc1
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yang Li <yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 5, 2023 at 8:32 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> just a gentle reminder

This is in my linux-next branch, I'll merge it into thermal tomorrow.

>  because more material will come in the next days

So why can't it wait?
