From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] power: supply: act8945a_charger: fix of_irq_get() error
 check
Date: Sun, 16 Jul 2017 20:55:13 +0300
Message-ID: <c0a5fce5-4185-249b-e206-4964d41ab05a@cogentembedded.com>
References: <20170716175244.300670810@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:35790 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751216AbdGPRzQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 16 Jul 2017 13:55:16 -0400
Received: by mail-lf0-f41.google.com with SMTP id w198so7410373lff.2
        for <linux-pm@vger.kernel.org>; Sun, 16 Jul 2017 10:55:15 -0700 (PDT)
In-Reply-To: <20170716175244.300670810@cogentembedded.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: Wenyou Yang <wenyou.yang@atmel.com>

Forgot to mention that this patch is against Linus' repo as Sebastian's repo 
lags behind at 4.10-rc1...
