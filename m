Return-Path: <SRS0=2z6l=B5=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805CFC433DF
	for <linux-pm@archiver.kernel.org>; Wed, 19 Aug 2020 23:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B70120FC3
	for <linux-pm@archiver.kernel.org>; Wed, 19 Aug 2020 23:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597881427;
	bh=Z5hn4H4ZvyhXgv02/fBxCxLA88wbrpC1HZyB5g2nP1s=;
	h=Date:From:To:To:To:To:Cc:Cc:Subject:In-Reply-To:References:
	 List-ID:From;
	b=oR3Uz9/yBreJRHg30zVaFGOVMjVcY6aE9UH8pAW0JWe3e6wRm2hEjOQHIKV66nCmf
	 w2t0PvEbmTaE5iSMuDRyFCTR7hD6Sigp0pUuSm/Es8AYDMoZBlguHYPq6B90XcwoR2
	 G/BGZ6jyKhPKtX919C48TA+TkiXTUZfAd6dqQGVQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgHSX5F (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 19 Aug 2020 19:57:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726715AbgHSX45 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 19 Aug 2020 19:56:57 -0400
Received: from localhost (unknown [70.37.104.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45FC4214F1;
        Wed, 19 Aug 2020 23:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597881417;
        bh=Z5hn4H4ZvyhXgv02/fBxCxLA88wbrpC1HZyB5g2nP1s=;
        h=Date:From:To:To:To:To:Cc:Cc:Subject:In-Reply-To:References:From;
        b=cssiTjIuJPntuFjgaM485t3pKL5LnIlsyILozqgLn6oP7gvjDxknF/o8esyneHzOu
         99lcHJKdlvnRwUsXIjdmN9NO7PpI2PkPllcanm+8mLVLud+WiDqSFpAHixUAd1LUM1
         8rIoe9rgP35ijerb002GjZ0BIGzSLBjWbo3GPGFM=
Date:   Wed, 19 Aug 2020 23:56:56 +0000
From:   Sasha Levin <sashal@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH V2 1/4] opp: Enable resources again if they were disabled earlier
In-Reply-To: <c6bba235a9a6fd777255bb4f1d16492fdcabc847.1597292833.git.viresh.kumar@linaro.org>
References: <c6bba235a9a6fd777255bb4f1d16492fdcabc847.1597292833.git.viresh.kumar@linaro.org>
Message-Id: <20200819235657.45FC4214F1@mail.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag
fixing commit: cd7ea582866f ("opp: Make dev_pm_opp_set_rate() handle freq = 0 to drop performance votes").

The bot has tested the following trees: v5.8.1, v5.7.15, v5.4.58.

v5.8.1: Build OK!
v5.7.15: Build failed! Errors:
    drivers/opp/core.c:849:17: error: ‘struct opp_table’ has no member named ‘paths’
    drivers/opp/core.c:849:17: error: ‘struct opp_table’ has no member named ‘paths’
    drivers/opp/core.c:849:17: error: ‘struct opp_table’ has no member named ‘paths’
    drivers/opp/core.c:849:17: error: 'struct opp_table' has no member named 'paths'
    drivers/opp/core.c:849:17: error: ‘struct opp_table’ has no member named ‘paths’
    drivers/opp/core.c:849:17: error: ‘struct opp_table’ has no member named ‘paths’
    drivers/opp/core.c:849:17: error: 'struct opp_table' has no member named 'paths'
    drivers/opp/core.c:849:17: error: 'struct opp_table' has no member named 'paths'
    drivers/opp/core.c:849:17: error: ‘struct opp_table’ has no member named ‘paths’
    drivers/opp/core.c:849:17: error: ‘struct opp_table’ has no member named ‘paths’
    drivers/opp/core.c:849:17: error: 'struct opp_table' has no member named 'paths'
    drivers/opp/core.c:849:17: error: 'struct opp_table' has no member named 'paths'

v5.4.58: Build failed! Errors:
    drivers/opp/core.c:847:17: error: ‘struct opp_table’ has no member named ‘paths’
    drivers/opp/core.c:847:17: error: 'struct opp_table' has no member named 'paths'
    drivers/opp/core.c:847:17: error: ‘struct opp_table’ has no member named ‘paths’
    drivers/opp/core.c:847:17: error: 'struct opp_table' has no member named 'paths'
    drivers/opp/core.c:847:17: error: ‘struct opp_table’ has no member named ‘paths’
    drivers/opp/core.c:847:17: error: ‘struct opp_table’ has no member named ‘paths’
    drivers/opp/core.c:847:17: error: 'struct opp_table' has no member named 'paths'
    drivers/opp/core.c:847:17: error: ‘struct opp_table’ has no member named ‘paths’
    drivers/opp/core.c:847:17: error: ‘struct opp_table’ has no member named ‘paths’
    drivers/opp/core.c:847:17: error: 'struct opp_table' has no member named 'paths'
    drivers/opp/core.c:847:17: error: ‘struct opp_table’ has no member named ‘paths’
    drivers/opp/core.c:847:17: error: 'struct opp_table' has no member named 'paths'


NOTE: The patch will not be queued to stable trees until it is upstream.

How should we proceed with this patch?

-- 
Thanks
Sasha
