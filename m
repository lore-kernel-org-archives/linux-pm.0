Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E2FE7D0A7
	for <linux-pm@archiver.kernel.org>; Thu, 21 Sep 2023 19:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjIUT6w (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 21 Sep 2023 15:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjIUT6l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Sep 2023 15:58:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 202DC46DC0;
        Thu, 21 Sep 2023 10:13:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC3BD168F;
        Thu, 21 Sep 2023 06:34:23 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E02E23F5A1;
        Thu, 21 Sep 2023 06:33:45 -0700 (PDT)
Date:   Thu, 21 Sep 2023 14:33:43 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH] firmware: arm_scmi: Move power-domain driver to the
 pmdomain dir
Message-ID: <20230921133343.h3chbszl2iuf2b55@bogus>
References: <20230919121605.7304-1-ulf.hansson@linaro.org>
 <20230921113328.3208651-1-sudeep.holla@arm.com>
 <CAPDyKFrGDZzyp4G1fS5PGCE95b3_w4kJyZfnDs=BEuYLzJ7uXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrGDZzyp4G1fS5PGCE95b3_w4kJyZfnDs=BEuYLzJ7uXA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 21, 2023 at 03:10:56PM +0200, Ulf Hansson wrote:
> On Thu, 21 Sept 2023 at 13:33, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > To simplify with maintenance let's move the Arm SCMI power-domain driver
> > to the new pmdomain directory.
> >
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Cristian Marussi <cristian.marussi@arm.com>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Feel free to take it through your scmi tree!
> 
> Note that, we should move the Kconfig options too, but that requires
> changes that I am carrying in my pmdomain tree. We can either wait
> until the next cycle or you could send your pull-request to me this
> time (instead of through arm-soc), then we can fix this as a late
> minute change. The decision is yours.
> 

OK. Lets us just delay SCMI Kconfig changes for the next cycle then. I assume
you would have other changes merged by then. Or may be as a fix as it would
be hardlt 10-15 line with 2 Kconfig options. Let me know if you disagree or
have other ideas.

-- 
Regards,
Sudeep
