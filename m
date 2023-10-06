Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B722EE92FFB
	for <linux-pm@archiver.kernel.org>; Fri,  6 Oct 2023 09:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjJFJnp (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 6 Oct 2023 05:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbjJFJnp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Oct 2023 05:43:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31FEBE4;
        Fri,  6 Oct 2023 02:43:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FBD8C15;
        Fri,  6 Oct 2023 02:44:22 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7C473F5A1;
        Fri,  6 Oct 2023 02:43:41 -0700 (PDT)
Date:   Fri, 6 Oct 2023 10:43:39 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] firmware: arm_scmi: Add generic OPP support to the
 SCMI performance domain
Message-ID: <20231006094339.i6kbotlsbdqmgxb6@bogus>
References: <20230925131715.138411-1-ulf.hansson@linaro.org>
 <20230925131715.138411-10-ulf.hansson@linaro.org>
 <20230929162522.zjoh5d2tqspzm3nc@bogus>
 <20231003082133.xyu46szs3jfm6fks@vireshk-i7>
 <20231003112647.bbqwnre5bzijw5sg@bogus>
 <20231004050806.sba3ogq76yiylrro@vireshk-i7>
 <20231005150649.p6viyorcucq2irsi@bogus>
 <20231006070923.hf3izdazuwng7uv5@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006070923.hf3izdazuwng7uv5@vireshk-i7>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 06, 2023 at 12:39:23PM +0530, Viresh Kumar wrote:
> On 05-10-23, 16:06, Sudeep Holla wrote:
> > Thanks, I wasn't expecting these patches in the branch, but if you are
> > aware off and are fine with it, I have no objections.
> > 
> > 	dt-bindings: opp: opp-v2-kryo-cpu: Allow opp-peak-kBps
> > 	OPP: debugfs: Fix warning with W=1 builds
> > 	OPP: Remove doc style comments for internal routines
> > 	OPP: Add dev_pm_opp_find_level_floor()
> 
> Ahh, I didn't create a fresh branch for this but added them on top of
> OPP changes. Fixed it now. Fetch the repo again.

Thanks, glad I asked, initially assumed you were aware of it :).

-- 
Regards,
Sudeep
