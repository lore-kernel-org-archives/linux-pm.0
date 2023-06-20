Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDDAEB64D8
	for <linux-pm@archiver.kernel.org>; Tue, 20 Jun 2023 17:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjFTRaN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 20 Jun 2023 13:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjFTRaM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Jun 2023 13:30:12 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3741703;
        Tue, 20 Jun 2023 10:30:10 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-31114d47414so1075636f8f.1;
        Tue, 20 Jun 2023 10:30:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687282209; x=1689874209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAJD1CAE2NOLg5Z0/zR5WnQufrmFPLnVVORvNgNy9Sk=;
        b=C2eIMxgEqdr07OQLfA8Sr+GZ6cxGAEI+NPcVxYrwRplf3n4c5xdn5H5Z/BUw2Wg3zc
         hTN4mg0qdiuMgVyWI8zls2+pKTKU4s2evyMuCbEl+S73HpWKn4pdrKSVnVshwBq+pt6f
         LansT0gSYMRRfYtiEC0sCoCFEvKr//B/N00IRVYn5VFylxDc4mSrushh82/hbmHBs417
         iPKg31Z35955+wvUh6S/gl6Fgcv3wY3vZjdKrB2eDfsYqkkZWvREiEP2K4YdLyn9/8It
         MdzkdgmTDbswtn8lmI9us4Bhv/cryQUrrIf/LV8wEDC4Y1Alcu8NbRvsKYtxRyD0oryY
         c4mA==
X-Gm-Message-State: AC+VfDySmJmgyVIqHppu4mG/BNhvjib9PHjb6Kfc1Jv9edY1q7i6Bnnv
        eXJ88BVNGyIkWgkNnLrEL0u7hH7z9bJcuzIwivA=
X-Google-Smtp-Source: ACHHUZ6qEZTFVs2lRa+IclRc22f6t2zMAP2L7ps/n/TAqOmssNuZMKQejfjedhObqaZaVUzgDuzg6YScXBzJLxAAgAQ=
X-Received: by 2002:a5d:4b08:0:b0:307:5561:5eec with SMTP id
 v8-20020a5d4b08000000b0030755615eecmr11066378wrq.0.1687282208681; Tue, 20 Jun
 2023 10:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230519032719.2581689-1-evalenti@kernel.org> <20230519032719.2581689-7-evalenti@kernel.org>
In-Reply-To: <20230519032719.2581689-7-evalenti@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 20 Jun 2023 19:29:57 +0200
Message-ID: <CAJZ5v0hrddGcoqdT6a0+9t20guW_1cZmbNhP_ZuQTmkCLGSKEA@mail.gmail.com>
Subject: Re: [PATCH 6/7] ythermal: core: report errors to governors
To:     Eduardo Valentin <evalenti@kernel.org>
Cc:     eduval@amazon.com, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 19, 2023 at 5:27 AM Eduardo Valentin <evalenti@kernel.org> wrote:
>
> From: Eduardo Valentin <eduval@amazon.com>
>
> Currently the thermal governors are not allowed to
> react on temperature error events as the thermal core
> skips the handling and logs an error on kernel buffer.
> This patch adds the opportunity to report the errors
> when they happen to governors.
>
> Now, if a governor wants to react on temperature read
> errors, they can implement the .check_error() callback.

Explaining the use case for this would help a lot.
