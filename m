Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F70C433E9
	for <linux-pm@archiver.kernel.org>; Tue,  9 Mar 2021 09:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FB636523C
	for <linux-pm@archiver.kernel.org>; Tue,  9 Mar 2021 09:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbhCIJT2 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 9 Mar 2021 04:19:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:50992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229948AbhCIJTG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Mar 2021 04:19:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 24BBB6522E;
        Tue,  9 Mar 2021 09:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615281546;
        bh=iX5Ic4F1TQ9OsADSxd3DzW3ka+qK+zltIfosLa1xPnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KWXvM8qnjXRUrFChgfgfN8wrAg2Zw7mugk8o9/AZ6IM+OHZ2oZcY/0M8HhvLIxGvq
         KRB6N0igFA3GEUaU02gMZTAl6wApANR6GSU4d2B0k4/wq9iuYQiFYy6CNckjCp3vVB
         7bSEI+S9y7vbZkBpkQqUVl5uMUpR2yaIyI3/jnIsm0yWGIMPw7HN4jMehiFIbI2qU5
         df0vWg1qG89M36dTl33cX6hHZwRAT2g3pdUF1pqlDB3UNApreiu4RU2L8Yl4KiHWKT
         eo+JcoxU9vwVMkpscPY67n9xt6Y+Lwju0e0DKayD0gZKJq9p1voN6UqafKPKv2HDJf
         autnRGTGsHx5A==
Date:   Tue, 9 Mar 2021 09:19:00 +0000
From:   Will Deacon <will@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 1/2] topology: Allow multiple entities to provide
 sched_freq_tick() callback
Message-ID: <20210309091900.GA27747@willie-the-truck>
References: <cover.1614580695.git.viresh.kumar@linaro.org>
 <a34f549bc75eecd4804aebb7b7794b45769eccf0.1614580695.git.viresh.kumar@linaro.org>
 <20210308145209.GA26458@willie-the-truck>
 <20210309041643.tcyv6rpto4k3sv5v@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309041643.tcyv6rpto4k3sv5v@vireshk-i7>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 09, 2021 at 09:46:43AM +0530, Viresh Kumar wrote:
> On 08-03-21, 14:52, Will Deacon wrote:
> > On Mon, Mar 01, 2021 at 12:21:17PM +0530, Viresh Kumar wrote:
> > > +EXPORT_SYMBOL_GPL(topology_set_scale_freq_source);
> > 
> > I don't get why you need to export this in this patch. The arm64 topology
> > code is never built as a module.
> > 
> > > +EXPORT_SYMBOL_GPL(topology_clear_scale_freq_source);
> > 
> > Same here.
> > 
> > > +EXPORT_SYMBOL_GPL(freq_scale);
> > 
> > And here.
> 
> After this patch, any part of the kernel can use these
> helpers/variables to run their own implementation of tick-freq-scale
> and so this patch looked to be the right place for that to me.
> 
> And the second patch in the series updates the CPPC cpufreq driver
> (tristate) to use these exported symbols, so we have the first user
> who needs the exported symbols as well.

Ok, then how about putting the exports in their own patch that immediately
precedes the patch which uses them? I think that would make it much clearer.

> > This one probably wants a less generic name as well if it's going
> > to be exported.
> 
> x86 names it arch_freq_scale, perhaps we should stick to that instead.

Sounds like a improvement, thanks.

Will
