Return-Path: <SRS0=Evqw=EL=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55052C4741F
	for <linux-pm@archiver.kernel.org>; Thu,  5 Nov 2020 10:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ACC421734
	for <linux-pm@archiver.kernel.org>; Thu,  5 Nov 2020 10:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgKEK4j (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 5 Nov 2020 05:56:39 -0500
Received: from foss.arm.com ([217.140.110.172]:57398 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbgKEK4j (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Nov 2020 05:56:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0C9F142F;
        Thu,  5 Nov 2020 02:56:38 -0800 (PST)
Received: from e123083-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A4363F66E;
        Thu,  5 Nov 2020 02:56:35 -0800 (PST)
Date:   Thu, 5 Nov 2020 11:56:33 +0100
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        amitk@kernel.org, corbet@lwn.net, daniel.lezcano@linaro.org,
        Dietmar.Eggemann@arm.com, qperret@google.com,
        dianders@chromium.org, mka@chromium.org, rnayak@codeaurora.org,
        rafael@kernel.org, sudeep.holla@arm.com, viresh.kumar@linaro.org,
        sboyd@kernel.org, nm@ti.com
Subject: Re: [PATCH v4 1/4] PM / EM: Add a flag indicating units of power
 values in Energy Model
Message-ID: <20201105105633.GB8237@e123083-lin>
References: <20201103090600.29053-1-lukasz.luba@arm.com>
 <20201103090600.29053-2-lukasz.luba@arm.com>
 <20201105091759.GA8237@e123083-lin>
 <876ca521-1576-63c5-9af5-b000f52cc17b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <876ca521-1576-63c5-9af5-b000f52cc17b@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 05, 2020 at 10:09:05AM +0000, Lukasz Luba wrote:
> 
> 
> On 11/5/20 9:18 AM, Morten Rasmussen wrote:
> > On Tue, Nov 03, 2020 at 09:05:57AM +0000, Lukasz Luba wrote:
> > > @@ -79,7 +82,8 @@ struct em_data_callback {
> > >   struct em_perf_domain *em_cpu_get(int cpu);
> > >   struct em_perf_domain *em_pd_get(struct device *dev);
> > >   int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
> > > -				struct em_data_callback *cb, cpumask_t *span);
> > > +				struct em_data_callback *cb, cpumask_t *spani,
> > 
> > "spani" looks like a typo?
> > 
> 
> Good catch, yes, the vim 'i'.
> 
> Thank you Morten. I will resend this patch when you don't
> find other issues in the rest of patches.

The rest of the series looks okay to me.

Morten
