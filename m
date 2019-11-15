Return-Path: <SRS0=udh8=ZH=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6608BC43141
	for <linux-pm@archiver.kernel.org>; Fri, 15 Nov 2019 17:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4094420733
	for <linux-pm@archiver.kernel.org>; Fri, 15 Nov 2019 17:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfKORMq (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 15 Nov 2019 12:12:46 -0500
Received: from foss.arm.com ([217.140.110.172]:33974 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727528AbfKORMq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 15 Nov 2019 12:12:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F243D31B;
        Fri, 15 Nov 2019 09:12:45 -0800 (PST)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4D973F6C4;
        Fri, 15 Nov 2019 09:12:43 -0800 (PST)
Date:   Fri, 15 Nov 2019 17:12:38 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v2 02/13] dt: psci: Update DT bindings to support
 hierarchical PSCI states
Message-ID: <20191115171238.GA27170@bogus>
References: <20191029164438.17012-1-ulf.hansson@linaro.org>
 <20191029164438.17012-3-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029164438.17012-3-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 29, 2019 at 05:44:27PM +0100, Ulf Hansson wrote:
> Update PSCI DT bindings to allow to represent idle states for CPUs and the
> CPU topology, by using a hierarchical layout. Primarily this is done by
> re-using the existing DT bindings for PM domains [1] and for PM domain idle
> states [2].
> 
> Let's also add an example into the document for the PSCI DT bindings, to
> clearly show the new hierarchical based layout. The currently supported
> flattened layout, is already described in the ARM idle states bindings [3],
> so let's leave that as is.
> 
> [1] Documentation/devicetree/bindings/power/power_domain.txt
> [2] Documentation/devicetree/bindings/power/domain-idle-state.txt
> [3] Documentation/devicetree/bindings/arm/idle-states.txt
> 

I thought I had given reviewed by to this. Or may be I confused you
giving the big standard example that I want to add here.

Anyways,

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
