Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9154EC433E4
	for <linux-pm@archiver.kernel.org>; Tue, 23 Mar 2021 16:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60B5D619C1
	for <linux-pm@archiver.kernel.org>; Tue, 23 Mar 2021 16:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbhCWQ5z (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 23 Mar 2021 12:57:55 -0400
Received: from vern.gendns.com ([98.142.107.122]:49246 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233135AbhCWQ5q (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Mar 2021 12:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ypmXjp6yQmaGEu4BKgnUk0zdpDTaBHD/Az+2mZr26LU=; b=U4w0N+gACqfZpDRr8wf0glVVt/
        XP8mfYsPGfpNoOsXUp95hDVHTRlCqgZA0QGqhdiztxd2M3ZAZO+l1RVYH7cnq+/SjyeonNGvlI1c1
        /oGMpxAOCfNp3PABoqytQWNXskqPvWKt+nai7ZXII5HhG8qcOMK+Nlb0mwhs/zJ7tJqSbtj5zXEpt
        Ae/gKZTWuL6NyJZEP3btZB03EfD8fWNHxy832vGgoHpD24rTCZ59DtxsoK0X9Z+OMyPyPVJFnL0a7
        tMfEgiAHj3RkddNfW93301mI/a3zFzLf5t6/jnwR2s4K+c1gW0/0Q+jD2G1Sr7BBG9oMZBcyNb4qU
        J/OpcDWQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:58020 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1lOkLf-0000Uo-VF; Tue, 23 Mar 2021 12:57:44 -0400
Subject: Re: [PATCHv2 19/38] dt-bindings: power: supply: lego-ev3-battery:
 Convert to DT schema format
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20210317134904.80737-1-sebastian.reichel@collabora.com>
 <20210317134904.80737-20-sebastian.reichel@collabora.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <74ead4fb-232b-43a7-3bed-c834b4299cc9@lechnology.com>
Date:   Tue, 23 Mar 2021 11:57:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210317134904.80737-20-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/17/21 8:48 AM, Sebastian Reichel wrote:
> Convert the binding to DT schema format.
> 
> Cc: David Lechner <david@lechnology.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---

Reviewed-by: David Lechner <david@lechnology.com>

