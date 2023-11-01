Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F07C001B2
	for <linux-pm@archiver.kernel.org>; Wed,  1 Nov 2023 11:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbjKALHi (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 1 Nov 2023 07:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235067AbjKALHh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Nov 2023 07:07:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA97ED;
        Wed,  1 Nov 2023 04:07:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D075C433CA;
        Wed,  1 Nov 2023 11:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698836851;
        bh=FpYGREr0r2q03KNrsg6xFSDgTmphiss/PYjEsRpTcIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YzssRzmBTGlNAfXtVDEXaXuRugDWUcmNSEQaAkVbBL9MEcu32GGMtpO4l7Vi7rGVy
         7HxZVxk5McUWigkNa3LLxWJYb5+5jmaoWfIXvD9UvcepdTvqzcp7uOHPN0u+hOiHax
         GvR4Lc989p7hOkNQatmg/pJAaNBC2SErAIrpg3As=
Date:   Wed, 1 Nov 2023 12:07:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-media@vger.kernel.org,
        Taniya Das <quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
Subject: Re: [PATCH RESEND v3 0/5] PM: domains: Add control for switching
 back and forth to HW control
Message-ID: <2023110106-shabby-stagnant-9a6a@gregkh>
References: <20231101-gdsc-hwctrl-v3-0-0740ae6b2b04@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101-gdsc-hwctrl-v3-0-0740ae6b2b04@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 01, 2023 at 11:04:06AM +0200, Abel Vesa wrote:
> This is just a resend of v3:
> https://lore.kernel.org/lkml/20230923115008.1698384-1-abel.vesa@linaro.org/

Why?

It's the middle of the merge window, not much we can do until -rc1 is
out...

thanks,

greg k-h
