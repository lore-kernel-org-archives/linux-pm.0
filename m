Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581E9C761A6
	for <linux-pm@archiver.kernel.org>; Mon, 27 Mar 2023 17:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjC0RLu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 27 Mar 2023 13:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjC0RLu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Mar 2023 13:11:50 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540F0F2;
        Mon, 27 Mar 2023 10:11:49 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id i5so39318635eda.0;
        Mon, 27 Mar 2023 10:11:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679937108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKMInRwl0Gc1Ecqdj/dy1/q2BubdqaACdxj2JmQ6+TI=;
        b=fY+FgxRiP2AyB2EVcBpOMG/svAmAcK1TdqIyQnyNwksR/Qkd8DMMlgywDnG1zplU52
         usS4hW1CcFYxckVpXwTiA90rXHzblwlklXokEG28MSZTbjZFZO1KVoiyVhCAmnuniaWJ
         6aNBtaU7SqIfB8gX9qk3lJYaePGMbCjakYu/pWK92gXAa2qr54DHUS4fEVZk+71t63Fp
         Jo2WvTyO2g1Nhqx7tCDw92+xPAGXz5h3ADLlaTKOGHBfKX5h+y0EZSC+LurmhW1+witE
         X9snEVsNcjNnXEgAKh94bfEDntx80Z7MbiiC3FxYxM39J/xSeJuOAWYjZndDYhwDoPPt
         6xZA==
X-Gm-Message-State: AAQBX9dFiWkaHYwyjkdcMr5VRkBlvLVNi7c7zqukd/9HPJeAQ3pZL7FC
        +ZQ3b/mmKoHdyb79nWRTJceZAtirx7dVBkWSp2k=
X-Google-Smtp-Source: AKy350bYCVWPVVIvU+DrDIPLJj6ptCcfYC/TjPJYE8B/rXs4vqSjQId7RPLOgscyV/NFdIsOuVle0McskcJJI+S0bjM=
X-Received: by 2002:a50:a6d7:0:b0:4fa:71a2:982b with SMTP id
 f23-20020a50a6d7000000b004fa71a2982bmr6042472edc.0.1679937107869; Mon, 27 Mar
 2023 10:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230310144703.1541819-1-robh@kernel.org> <20230313042647.gkth7prhopaa7nnq@vireshk-i7>
In-Reply-To: <20230313042647.gkth7prhopaa7nnq@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Mar 2023 19:11:36 +0200
Message-ID: <CAJZ5v0jpp-+PtTLmM9qSP3W-ny0NV3x-bmjJrfMkxxC+5fbxYw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: pmac32: Use of_property_read_bool() for boolean properties
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 13, 2023 at 5:26 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 10-03-23, 08:47, Rob Herring wrote:
> > It is preferred to use typed property access functions (i.e.
> > of_property_read_<type> functions) rather than low-level
> > of_get_property/of_find_property functions for reading properties.
> > Convert reading boolean properties to to of_property_read_bool().
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/cpufreq/pmac32-cpufreq.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 6.4 material, thanks!
