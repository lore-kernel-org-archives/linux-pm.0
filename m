Return-Path: <SRS0=GQM4=XO=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB97C3A5A6
	for <linux-pm@archiver.kernel.org>; Thu, 19 Sep 2019 19:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B62C121907
	for <linux-pm@archiver.kernel.org>; Thu, 19 Sep 2019 19:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404434AbfIST1y convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 19 Sep 2019 15:27:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:34322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404419AbfIST1y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Sep 2019 15:27:54 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1B022053B;
        Thu, 19 Sep 2019 19:27:52 +0000 (UTC)
Date:   Thu, 19 Sep 2019 15:27:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2] devfreq: Add tracepoint for frequency changes
Message-ID: <20190919152751.526cf09d@gandalf.local.home>
In-Reply-To: <20190919174423.105030-1-mka@chromium.org>
References: <20190919174423.105030-1-mka@chromium.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 19 Sep 2019 10:44:23 -0700
Matthias Kaehlcke <mka@chromium.org> wrote:

> Add a tracepoint for frequency changes of devfreq devices and
> use it.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

From the tracing point of view:

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

