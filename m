Return-Path: <SRS0=iPxC=B6=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A835C433DF
	for <linux-pm@archiver.kernel.org>; Thu, 20 Aug 2020 10:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CF0D20855
	for <linux-pm@archiver.kernel.org>; Thu, 20 Aug 2020 10:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgHTK0S convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:26:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:45314 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730535AbgHTK0E (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 20 Aug 2020 06:26:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 64C2DAE33;
        Thu, 20 Aug 2020 10:26:30 +0000 (UTC)
From:   Thomas Renninger <trenn@suse.com>
To:     shuah@kernel.org, linux-pm@vger.kernel.org,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: Re: [PATCH] cpupower: Replace HTTP links with HTTPS ones
Date:   Thu, 20 Aug 2020 12:26:02 +0200
Message-ID: <7169450.1KdEUtMQry@c100>
In-Reply-To: <20200713110511.33549-1-grandmaster@al2klimov.de>
References: <20200713110511.33549-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Am Montag, 13. Juli 2020, 13:05:11 CEST schrieb Alexander A. Klimov:
>  .SH REFERENCES
>  "BIOS and Kernel Developer’s Guide (BKDG) for AMD Family 14h Processors"
> -http://support.amd.com/us/Processor_TechDocs/43170.pdf
> +https://support.amd.com/us/Processor_TechDocs/43170.pdf
> 
>  "Intel® Turbo Boost Technology
>  in Intel® Core™ Microarchitecture (Nehalem) Based Processors"
> @@ -178,7 +178,7 @@
> http://download.intel.com/design/processor/applnots/320354.pdf
> 
>  "Intel® 64 and IA-32 Architectures Software Developer's Manual
>  Volume 3B: System Programming Guide"
> -http://www.intel.com/products/processor/manuals
> +https://www.intel.com/products/processor/manuals

The 2 above https:// links are still valid.

No idea it's worth replacing. If this is checked and done through the whole 
kernel, then I agree that it would be nice if Shuah picks it up...

  Thomas


