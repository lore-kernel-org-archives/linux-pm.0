Return-Path: <SRS0=eR+e=6A=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582E5C3815B
	for <linux-pm@archiver.kernel.org>; Thu, 16 Apr 2020 01:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40E1520725
	for <linux-pm@archiver.kernel.org>; Thu, 16 Apr 2020 01:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730899AbgDPBdu (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 15 Apr 2020 21:33:50 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:40742 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729564AbgDPBdq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Apr 2020 21:33:46 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.15]) by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee35e97b5ea310-745f5; Thu, 16 Apr 2020 09:33:30 +0800 (CST)
X-RM-TRANSID: 2ee35e97b5ea310-745f5
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [172.20.146.139] (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee85e97b5e8b09-04b4c;
        Thu, 16 Apr 2020 09:33:29 +0800 (CST)
X-RM-TRANSID: 2ee85e97b5e8b09-04b4c
Subject: Re: [PATCH] power: supply: axp288_charger: Omit superfluous
 errormessage
To:     Hans de Goede <hdegoede@redhat.com>, sre@kernel.org, wens@csie.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200415042727.13496-1-tangbin@cmss.chinamobile.com>
 <8f9ae92b-9aab-34a2-dc15-a9c3514c7ca8@redhat.com>
From:   Tang Bin <tangbin@cmss.chinamobile.com>
Message-ID: <f5b2b7e5-234f-352d-846e-f9ec5508a21f@cmss.chinamobile.com>
Date:   Thu, 16 Apr 2020 09:35:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <8f9ae92b-9aab-34a2-dc15-a9c3514c7ca8@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Hans:

On 2020/4/15 16:07, Hans de Goede wrote:
> Hi,
>
> On 4/15/20 6:27 AM, Tang Bin wrote:
>> In the axp288_charger_probe(), when get irq failed, the function
>> platform_get_irq() logs an error message, so remove redundant
>> message here.
>>
>> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
>> Signed-off-by: Shengju Zhang <zhangshengju@cmss.chinamobile.com>
>
> Thank you for this nice cleanup patch:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>
Thanks,

Tang Bin

>
>
>
>


