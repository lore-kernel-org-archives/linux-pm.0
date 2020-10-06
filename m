Return-Path: <SRS0=ZSVA=DN=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70694C41604
	for <linux-pm@archiver.kernel.org>; Tue,  6 Oct 2020 17:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18063206CB
	for <linux-pm@archiver.kernel.org>; Tue,  6 Oct 2020 17:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bnr35trw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgJFRjB (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 6 Oct 2020 13:39:01 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44262 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgJFRjA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 13:39:00 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 096HcdPf042856;
        Tue, 6 Oct 2020 12:38:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602005919;
        bh=N3FZH8SbixKKaMS+nxenTXpdYd5HyGtXOeg/JOiaaYI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=bnr35trwnSrqqOlvk2RCwI6M8COUKA0Vxvajl43uD9EZnVtzwdvrca8N1NvfIo3ZN
         waScIC/kv0o4WvujVl5gKIxZeh3if626+B3SdC0Slom7GCQb7lIbPLKYuD5p1f9F73
         dF/BCwQ8T2PqT0i+djePr+J+bbZFA8q3d6ylV72s=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 096Hcd7Q026107
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Oct 2020 12:38:39 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 6 Oct
 2020 12:38:38 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 6 Oct 2020 12:38:38 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 096HccNZ006462;
        Tue, 6 Oct 2020 12:38:38 -0500
Date:   Tue, 6 Oct 2020 12:38:38 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-pm@vger.kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Niklas Cassel <nks@flawful.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kevin Hilman <khilman@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 4/4] power: avs: Drop the avs directory and the
 corresponding Kconfig
Message-ID: <20201006173838.f7ylfbpakkxprzhj@mummified>
References: <20201006160516.319830-1-ulf.hansson@linaro.org>
 <20201006160516.319830-5-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201006160516.319830-5-ulf.hansson@linaro.org>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18:05-20201006, Ulf Hansson wrote:
> All avs drivers have now been moved to their corresponding soc specific
> directories. Additionally, they don't depend on the POWER_AVS Kconfig
> anymore. Therefore, let's simply drop the drivers/power/avs directory
> altogether.
> 
> Cc: Nishanth Menon <nm@ti.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Nishanth Menon <nm@ti.com>
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
