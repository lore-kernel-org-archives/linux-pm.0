Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2681EE49A3
	for <linux-pm@archiver.kernel.org>; Wed, 23 Aug 2023 02:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjHWCyR (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 22 Aug 2023 22:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbjHWCyO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Aug 2023 22:54:14 -0400
X-Greylist: delayed 918 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Aug 2023 19:54:12 PDT
Received: from symantec4.comsats.net.pk (symantec4.comsats.net.pk [203.124.41.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79971CE9
        for <linux-pm@vger.kernel.org>; Tue, 22 Aug 2023 19:54:11 -0700 (PDT)
X-AuditID: cb7c291e-06dff70000002aeb-fd-64e55c557d14
Received: from iesco.comsatshosting.com (iesco.comsatshosting.com [210.56.28.11])
        (using TLS with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by symantec4.comsats.net.pk (Symantec Messaging Gateway) with SMTP id 4F.D7.10987.55C55E46; Wed, 23 Aug 2023 06:09:42 +0500 (PKT)
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns;
        d=iesco.com.pk; s=default;
        h=received:content-type:mime-version:content-transfer-encoding
          :content-description:subject:to:from:date:reply-to;
        b=Q1dMuOZyl7fzuG7n4LHM/FOwFLpbN00nn+SvD208TsctCOS3wFJy7s53nWPKraHGs
          41COXqzva7occDEDZE+PbCKzGB1kTuG2CWAAw1M7amnaexJNUPGKw/lzOg/dgqT16
          tBUVIdUDX9kRiiA9Cxywa7MbKfC9sZxljRD9gDrvI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iesco.com.pk; s=default;
        h=reply-to:date:from:to:subject:content-description
          :content-transfer-encoding:mime-version:content-type;
        bh=GMzYzcyTxDsE6wX/XHG6MHqAdAiHrhqbmmLQ/TZ1QnQ=;
        b=BJVxdWvR6NZlP82lRm4tmCMNswPcimAJDMV/xvs4TMbkwhhLt2qrPNr4iAQBSxHYk
          yFk1r452JjzjPIZ7U+AanqMy8ReU3zBFZE8hGueIZ+KwZ0+YJ9tJTCZW2D1yYXk32
          iDWv484QuqAfkJ/dtizSL9wW7xsPtWImNu2Y+cE6Y=
Received: from [94.156.6.90] (UnknownHost [94.156.6.90]) by iesco.comsatshosting.com with SMTP;
   Wed, 23 Aug 2023 04:31:05 +0500
Message-ID: <4F.D7.10987.55C55E46@symantec4.comsats.net.pk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re; Interest,
To:     linux-pm@vger.kernel.org
From:   "Chen Yun" <pso.chairmanbod@iesco.com.pk>
Date:   Tue, 22 Aug 2023 16:31:19 -0700
Reply-To: chnyne@gmail.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsVyyUKGWzcs5mmKwbGTLBafe48wOjB6fN4k
        F8AYxWWTkpqTWZZapG+XwJWxZN0FloLdzBVt/YtYGhgfM3UxcnBICJhI9G1K6mLk4hAS2MMk
        0b39KWsXIycHi8BqZokvW21BEiwCD5klHl6ZwwpR1cwoMefELxaQKl4Ba4kjf2eCdTAL6Enc
        mDqFDSIuKHFy5hMWiLi2xLKFr5lBtjELqEl87SoBCQsLiEl8mraMHcQWEZCRmHplP9gYNgF9
        iRVfmxkhjlCV6JzzA8wWEpCS2HhlPdsERv5ZSLbNQrJtFpJtsxC2LWBkWcUoUVyZmwgMtGQT
        veT83OLEkmK9vNQSvYLsTYzAIDxdoym3g3HppcRDjAIcjEo8vD/XPUkRYk0sA+o6xCjBwawk
        wiv9/WGKEG9KYmVValF+fFFpTmrxIUZpDhYlcV5boWfJQgLpiSWp2ampBalFMFkmDk6pBsa1
        09o2OPe3NAYc5CpQ/fG01NpXb/adPzNXn1jjbvYt9p1YxPTG9emxnnvOlgu68Dl+vdbMcu+p
        HdetL49FnjLOW3z8SWRi84KNLQZbtv2942rz8vPkc6sXzSzo9Vvzcf1FNgW9BUve6UzmvDr3
        nFDDuv/fih7f3aHzqF7np4JWrd5+UZn9jjOZlFiKMxINtZiLihMB73h66T4CAAA=
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Re; Interest,

I am interested in discussing the Investment proposal as I explained
in my previous mail. May you let me know your interest and the
possibility of a cooperation aimed for mutual interest.

Looking forward to your mail for further discussion.

Regards

------
Chen Yun - Chairman of CREC
China Railway Engineering Corporation - CRECG
China Railway Plaza, No.69 Fuxing Road, Haidian District, Beijing, P.R.
China

