Return-Path: <SRS0=B1NY=3M=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA66BC32771
	for <linux-pm@archiver.kernel.org>; Thu, 23 Jan 2020 01:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B367E2465B
	for <linux-pm@archiver.kernel.org>; Thu, 23 Jan 2020 01:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgAWBlC (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 22 Jan 2020 20:41:02 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:41387 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725943AbgAWBlC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jan 2020 20:41:02 -0500
X-IronPort-AV: E=Sophos;i="5.70,351,1574092800"; 
   d="scan'208";a="82502304"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 23 Jan 2020 09:40:59 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id EBC1850A996A;
        Thu, 23 Jan 2020 09:31:43 +0800 (CST)
Received: from [10.167.226.60] (10.167.226.60) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Thu, 23 Jan 2020 09:40:56 +0800
Subject: Re: [RFC PATCH 0/2] x86/boot: early ACPI MADT processing cleanup
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
To:     <x86@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <rjw@rjwysocki.net>, <len.brown@intel.com>, <pavel@ucw.cz>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>
References: <20200123013238.19059-1-caoj.fnst@cn.fujitsu.com>
Message-ID: <f0467f12-4efd-2f1d-5871-72b1d185edcb@cn.fujitsu.com>
Date:   Thu, 23 Jan 2020 09:43:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200123013238.19059-1-caoj.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: EBC1850A996A.A9CB7
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/23/20 9:32 AM, Cao jin wrote:
> Logic in early_acpi_process_madt() & acpi_process_madt() is really hard to
> follow now. Clean them up.
> 
> Done basic boot test on my x86-64 PC.
> 
> CCed linux-acpi@vger.kernel.org
> 
I am sorry, I still missed that...
-- 
Sincerely,
Cao jin


