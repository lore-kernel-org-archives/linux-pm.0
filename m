Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A686FCCA47E
	for <linux-pm@archiver.kernel.org>; Thu, 30 Jun 2022 07:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiF3H1D (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 30 Jun 2022 03:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiF3H1C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jun 2022 03:27:02 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CEB3879C;
        Thu, 30 Jun 2022 00:27:01 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 73BC52223E;
        Thu, 30 Jun 2022 09:26:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1656574018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zjrfyTV5MhZ/ZdhkEC7JgGAqSs/5JnxfS2vRsmrz01Y=;
        b=EJK731q8CqsM1mgdMNjEaM2dgFiziXDifqo3WToZDaj4/VuCqHc8NQ6d5qwFH80aM3N59p
        jvx3lH9jp+d3AC+Rkmk/cmITFnlJN6830y8jsk7n+X6Y+2iH7n71q2SEHMb5wFKQiwSamH
        8sIQet4ySkEdu3YoS2gQ0l2gXUZY71o=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 30 Jun 2022 09:26:55 +0200
From:   Michael Walle <michael@walle.cc>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com, lars@metafoo.de,
        rafael@kernel.org, quic_gurus@quicinc.com,
        sebastian.reichel@collabora.com, andy.shevchenko@gmail.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 13/16] pinctrl: Add AXP192 pin control driver
In-Reply-To: <me4ummrWKIPseIG4ay7yCfrumN8sIdvc@localhost>
References: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com>
 <20220618214009.2178567-14-aidanmacdonald.0x0@gmail.com>
 <cafd8a40ad35dcf8a35350261af6031c@walle.cc>
 <me4ummrWKIPseIG4ay7yCfrumN8sIdvc@localhost>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <01a338e8f94b077df3fe2c4f13d4da28@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Am 2022-06-27 15:12, schrieb Aidan MacDonald:

>> I *think* what is needed for gpio-regmap to support this is:
>>  - support values and masks for the direction, for now, we
>>    only support single bits.
>>  - support the pinctrl_gpio_direction_{input,output} calls
>> 
>> -michael
> 
> That sounds about right, thanks for taking a look.

I thought you were trying to add these to gpio-regmap? Unless
I'm missing something, that should be easy enough.

-michael
