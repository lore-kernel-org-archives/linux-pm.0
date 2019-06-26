Return-Path: <SRS0=P6A+=UZ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A776C48BD3
	for <linux-pm@archiver.kernel.org>; Wed, 26 Jun 2019 18:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9A821726
	for <linux-pm@archiver.kernel.org>; Wed, 26 Jun 2019 18:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561572687;
	bh=w6tOOkUuptUdC84+maRnXDnKxsdqVZpo/u9m6H7vfWM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=EvA/D/ilJHx2UHyqTEwrFKax2O6vT6lCFSxhy8Ws/8R/Jv8xP8IYkKxiiTes+49yZ
	 ZAk+Wo8YkISS96g1r1jWsv4P/rBn2PtsrD0q31d0r7ZRs1R4kCTtwMGxkf5/avJH8E
	 kRwgRAe4R/yOE2x/zQ7ct+fNMxxPtto6Z8q7bV/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfFZSL0 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 26 Jun 2019 14:11:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbfFZSL0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 26 Jun 2019 14:11:26 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E27C2080C;
        Wed, 26 Jun 2019 18:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561572685;
        bh=w6tOOkUuptUdC84+maRnXDnKxsdqVZpo/u9m6H7vfWM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=StfT/c2pEjiOTK2XTvITAR3Qya96VNFXP9yNPYx/s1RlZdTpAdsQcsdLoHcEdj7ug
         1IPAfyaQMpjSBWi9BNUmlUx0XVO/2DSpOyV5yC0MxdrwfGhb0+3PgGIyqG7pWqSmbC
         E5x7NDgA+FDL8rVLy8YB1C6M4StwLocaQCZaFMo4=
Subject: Re: cpupower: update German translation
To:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Benjamin Weis <benjamin.weis@gmx.com>
Cc:     trenn@suse.com, linux-pm@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190624133150.12322-1-benjamin.weis@gmx.com>
 <20190624140931.GA21950@light.dominikbrodowski.net>
From:   shuah <shuah@kernel.org>
Message-ID: <b5f06bf0-e356-93c6-0547-f8a3439b9e4f@kernel.org>
Date:   Wed, 26 Jun 2019 12:11:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190624140931.GA21950@light.dominikbrodowski.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 6/24/19 8:09 AM, Dominik Brodowski wrote:
> On Mon, Jun 24, 2019 at 03:31:50PM +0200, Benjamin Weis wrote:
>> Update the German translation of cpupower, and change the encoding
>> to UTF-8.
>>
>> Signed-off-by: Benjamin Weis <benjamin.weis@gmx.com>
> 
> Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>
> 

Thanks Dominik!

Hi Benjamin,

Thanks for the patch. This patch appears to be corrupted. It is also
missing [PATCH] tag. Please refer to patch submission guidelines and
send v2.

Documentation/process/submitting-patches.rst

thanks,
-- Shuah


