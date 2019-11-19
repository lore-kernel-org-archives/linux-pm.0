Return-Path: <SRS0=8f1A=ZL=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC11BC43215
	for <linux-pm@archiver.kernel.org>; Tue, 19 Nov 2019 20:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC2022448
	for <linux-pm@archiver.kernel.org>; Tue, 19 Nov 2019 20:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfKSUWp (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 19 Nov 2019 15:22:45 -0500
Received: from ms.lwn.net ([45.79.88.28]:40092 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbfKSUWo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 19 Nov 2019 15:22:44 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 015962B2;
        Tue, 19 Nov 2019 20:22:43 +0000 (UTC)
Date:   Tue, 19 Nov 2019 13:22:43 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Artur =?UTF-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <vireshk@kernel.org>, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] docs: Add initial documentation for devfreq
Message-ID: <20191119132243.0429c1bb@lwn.net>
In-Reply-To: <e32fa9de8a60060a6ee5fc42f163111034f9a550.1574181341.git.leonard.crestez@nxp.com>
References: <e32fa9de8a60060a6ee5fc42f163111034f9a550.1574181341.git.leonard.crestez@nxp.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 19 Nov 2019 18:38:56 +0200
Leonard Crestez <leonard.crestez@nxp.com> wrote:

> The devfreq subsystem has plenty of kernel-doc comments but they're not
> currently included in sphinx documentation.
> 
> Add a minimal devfreq.rst file which mostly just includes kernel-doc
> comments from devfreq source. This also exposes a number of kernel-doc
> warnings on `make htmldocs`
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  Documentation/driver-api/devfreq.rst | 30 ++++++++++++++++++++++++++++
>  Documentation/driver-api/index.rst   |  1 +
>  2 files changed, 31 insertions(+)
>  create mode 100644 Documentation/driver-api/devfreq.rst

Applied, thanks.

jon
