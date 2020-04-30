Return-Path: <SRS0=MSX4=6O=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED09C8300A
	for <linux-pm@archiver.kernel.org>; Thu, 30 Apr 2020 12:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AC2F2078D
	for <linux-pm@archiver.kernel.org>; Thu, 30 Apr 2020 12:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yGOvUJiL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgD3Mwz (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 30 Apr 2020 08:52:55 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:46460 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgD3Mwz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Apr 2020 08:52:55 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03UCqph2023466;
        Thu, 30 Apr 2020 07:52:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588251171;
        bh=IJiH5XXjwvCYQrn8bAHW0XTGtuzYNqRGjiJpARBzrWk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=yGOvUJiLcMQz1eI/NJzhNoZtAIIlZrIK6gJPUeqvMIMw2Wmz5svbTJuTimYBN0NUh
         b6d2+pQTPGFYR9RwQrYKJe7EYXi1wJMMwSf2I7zwxztK1lfBl5sJKa0eoeNIjHVraz
         tFerEiVNSxv/XybL13dmtTWIU0fjCE8qEK/CKKDg=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03UCqp1B048588;
        Thu, 30 Apr 2020 07:52:51 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 30
 Apr 2020 07:52:50 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 30 Apr 2020 07:52:50 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03UCqowF019754;
        Thu, 30 Apr 2020 07:52:50 -0500
Subject: Re: [PATCH 1/2] dt-bindings: power: Add the BQ27561 fuel gauge
 bindings
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
References: <20200417172227.28075-1-dmurphy@ti.com>
 <20200429223105.2echdvu745d6xbx2@earth.universe>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <9ab727a2-098b-465a-e74f-e169abf9ef81@ti.com>
Date:   Thu, 30 Apr 2020 07:44:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429223105.2echdvu745d6xbx2@earth.universe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sebastien

On 4/29/20 5:31 PM, Sebastian Reichel wrote:
> Hi,
>
> On Fri, Apr 17, 2020 at 12:22:26PM -0500, Dan Murphy wrote:
>> Introduce the Texas Instrument BQ27561 and BQ27750 fuel gauge device
>> tree bindings.
>>
>> Cc: Rob Herring <robh@kernel.org>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
> I think its best to just add them to bq27xxx.txt. Conversion to YAML
> would still be nice of course :)

Ack


> In any case the binding is incomplete, since batteries should contain
> a power-supplies node referencing their charger via a phandle, see
> power_suppliy.txt (which still needs to be converted to YAML).

Ack

Dan

