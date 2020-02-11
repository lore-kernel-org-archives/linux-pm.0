Return-Path: <SRS0=vVHs=37=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A436C352A4
	for <linux-pm@archiver.kernel.org>; Tue, 11 Feb 2020 00:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A9020715
	for <linux-pm@archiver.kernel.org>; Tue, 11 Feb 2020 00:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581380082;
	bh=0LCckJNzxKBIUfrkDME6mQDSgP60vPmbEVhhRR1007U=;
	h=To:Cc:From:Subject:Date:List-ID:From;
	b=nIHI3pGct1aMAd5btiR03J8ISgzJve/ARKXBHJEqIKHXJUXXzK6rYAwN+grk0EJxu
	 t5G//5ODS+jGpFhWurYNxvwBeUulOFaV5EMiVp6n1+PIcwBRoaveMa79eRSfN9QJDC
	 xnGxs1jzGeMKyeZDPQA33Szzm7esC5URZeGhljPI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbgBKAOl (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 10 Feb 2020 19:14:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:37266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727455AbgBKAOl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 10 Feb 2020 19:14:41 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D629A20715;
        Tue, 11 Feb 2020 00:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581380081;
        bh=0LCckJNzxKBIUfrkDME6mQDSgP60vPmbEVhhRR1007U=;
        h=To:Cc:From:Subject:Date:From;
        b=a8hpQJkICEiDtKfnmrjAgogV53a2p7L2sopspIV35ynWtJPz3giFU3c5LHzHz36DX
         p6LgFnNz7YcTY52R7U64Y8sHlXsBg0vXE4xpO565S9swWbWGjUjBkysKHFZ/zAbm4X
         QQXmJNEwvBJVsGcOcE1kG/RLhb8HvWbE0R2YGLK4=
To:     floppym@gentoo.org
Cc:     Linux PM <linux-pm@vger.kernel.org>, shuah <shuah@kernel.org>
From:   shuah <shuah@kernel.org>
Subject: Re: [PATCH] cpupower: avoid multiple definition with gcc -fno-common
Message-ID: <34fe3383-07ab-9b8b-280b-afb1c0ce0c0f@kernel.org>
Date:   Mon, 10 Feb 2020 17:14:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Mike,

You submitted the following patch.

The -fno-common option will be enabled by default in GCC 10.

Bug: https://bugs.gentoo.org/707462

https://patchwork.kernel.org/patch/11361221/

Please resend it fixing the following problems and to to recipients
suggest by get_maintainers script.

WARNING: externs should be avoided in .c files
#65: FILE: tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c:85:
+extern struct timespec start_time;

thanks,
-- Shuah
