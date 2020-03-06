Return-Path: <SRS0=Ttsr=4X=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F06C10DCE
	for <linux-pm@archiver.kernel.org>; Fri,  6 Mar 2020 15:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844152072A
	for <linux-pm@archiver.kernel.org>; Fri,  6 Mar 2020 15:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgCFPzy (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 6 Mar 2020 10:55:54 -0500
Received: from foss.arm.com ([217.140.110.172]:35806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbgCFPzx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Mar 2020 10:55:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4465630E;
        Fri,  6 Mar 2020 07:55:53 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA6CF3F237;
        Fri,  6 Mar 2020 07:55:51 -0800 (PST)
Date:   Fri, 6 Mar 2020 15:55:45 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Lina Iyer <ilina@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 4/4] cpuidle: psci: Allow WFI to be the only state for
 the hierarchical topology
Message-ID: <20200306155545.GA18983@bogus>
References: <20200305162321.GB53631@bogus>
 <CAPDyKFogjPG+mRsfPaxN7RjB7TQL9=qHNzA=K_t0F6M6Q9-TuA@mail.gmail.com>
 <20200306100431.GA16541@bogus>
 <CA+M3ks764moVU2h9iZJuN6B-e4wBUMymBfPnob_zraf50xqezA@mail.gmail.com>
 <20200306120646.GB44221@bogus>
 <CA+M3ks7+P=CjvUE28boANhrR6bhzLzyjBLovzWL_LjwL3UqmzQ@mail.gmail.com>
 <20200306134119.GB47929@bogus>
 <CA+M3ks5XBFcJqQozA=k6nU2XawRYT_qKnLW9t_GdkoRGNEd1yA@mail.gmail.com>
 <20200306144951.GA11624@bogus>
 <CA+M3ks6=gRj-5Qfe93+2BbECY=cGuj189MQu3yDnib-SbSM7Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+M3ks6=gRj-5Qfe93+2BbECY=cGuj189MQu3yDnib-SbSM7Og@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Mar 06, 2020 at 04:35:32PM +0100, Benjamin Gaignard wrote:

[...]

>
> CPU power domains are subdomains of the system power domain

Yes, that is platform specific.

> so they can vote for the targeting power domain.
>

Not when they are in WFI, it can't be powered down. I am going to say one
last time, add a CPU level state to workaround whatever you are trying to
and please stop hacking the psci domain like in the $subject patch.

If it was not any clear before, NACK.

--
Regards,
Sudeep
