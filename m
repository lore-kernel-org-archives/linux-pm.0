Return-Path: <SRS0=WlAP=6N=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C82C83000
	for <linux-pm@archiver.kernel.org>; Wed, 29 Apr 2020 15:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64B5F20B80
	for <linux-pm@archiver.kernel.org>; Wed, 29 Apr 2020 15:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgD2PuH (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:50:07 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:44078 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgD2PuH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 11:50:07 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id bb23fa4412e3993e; Wed, 29 Apr 2020 17:50:04 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     viresh.kumar@linaro.org, hugues.fruchet@st.com, mchehab@kernel.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, pavel@ucw.cz,
        len.brown@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [RFC 0/3] Introduce cpufreq minimum load QoS
Date:   Wed, 29 Apr 2020 17:50:04 +0200
Message-ID: <7657495.QyJl4BcWH5@kreacher>
In-Reply-To: <20200424114058.21199-1-benjamin.gaignard@st.com>
References: <20200424114058.21199-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday, April 24, 2020 1:40:55 PM CEST Benjamin Gaignard wrote:
> When start streaming from the sensor the CPU load could remain very low 
> because almost all the capture pipeline is done in hardware (i.e. without 
> using the CPU) and let believe to cpufreq governor that it could use lower 
> frequencies. If the governor decides to use a too low frequency that 
> becomes a problem when we need to acknowledge the interrupt during the 
> blanking time.
> The delay to ack the interrupt and perform all the other actions before
> the next frame is very short and doesn't allow to the cpufreq governor to
> provide the required burst of power. That led to drop the half of the frames.
> 
> To avoid this problem, DCMI driver informs the cpufreq governors by adding
> a cpufreq minimum load QoS resquest.

This seems to be addressing a use case that can be addressed with the help of
utilization clamps with less power overhead.

Thanks!



