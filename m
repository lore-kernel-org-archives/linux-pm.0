Return-Path: <SRS0=unav=Z3=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43F7C43603
	for <linux-pm@archiver.kernel.org>; Thu,  5 Dec 2019 17:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9199424249
	for <linux-pm@archiver.kernel.org>; Thu,  5 Dec 2019 17:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfLERM5 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 5 Dec 2019 12:12:57 -0500
Received: from comms.puri.sm ([159.203.221.185]:50624 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfLERM4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Dec 2019 12:12:56 -0500
X-Greylist: delayed 451 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Dec 2019 12:12:56 EST
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 090F6DFD7F;
        Thu,  5 Dec 2019 09:05:24 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Uk-qKAYI0nFN; Thu,  5 Dec 2019 09:05:23 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     daniel.lezcano@linaro.org
Cc:     mathieu.poirier@linaro.org, mingo@redhat.com, peterz@infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: Re: [PATCH V6 2/3] cpuidle: play_idle: Specify play_idle with an idle state
Date:   Thu,  5 Dec 2019 18:04:38 +0100
Message-Id: <20191205170438.4318-1-martin.kepplinger@puri.sm>
In-Reply-To: <20191030075141.1039-2-daniel.lezcano@linaro.org>
References: <20191030075141.1039-2-daniel.lezcano@linaro.org>
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

hi Daniel,

Since there's been quite some changes in cpuidle recently, how's your plans
to move this patchset forward? I, at least, need it.

thanks for that,

                               martin

