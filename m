Return-Path: <SRS0=YTwn=65=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5C0C433DF
	for <linux-pm@archiver.kernel.org>; Fri, 15 May 2020 09:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A40A20709
	for <linux-pm@archiver.kernel.org>; Fri, 15 May 2020 09:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgEOJ6P (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 15 May 2020 05:58:15 -0400
Received: from foss.arm.com ([217.140.110.172]:52370 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728032AbgEOJ6P (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 15 May 2020 05:58:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F5B92F;
        Fri, 15 May 2020 02:58:14 -0700 (PDT)
Received: from bogus (unknown [10.37.12.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AAD183F71E;
        Fri, 15 May 2020 02:58:12 -0700 (PDT)
Date:   Fri, 15 May 2020 10:58:02 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>, rui.zhang@intel.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "open list:CPU IDLE TIME MANAGEMENT FRAMEWORK" 
        <linux-pm@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CPUIDLE DRIVER - ARM PSCI" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 4/4] thermal: cpuidle: Register cpuidle cooling device
Message-ID: <20200515095751.GA25267@bogus>
References: <20200429103644.5492-1-daniel.lezcano@linaro.org>
 <20200429103644.5492-4-daniel.lezcano@linaro.org>
 <99b3bc79-f48a-3d51-a8ae-8b9ca4856d36@arm.com>
 <04b5da25-d591-b08a-e554-6e084d7ea908@linaro.org>
 <f3cee834-4946-10bd-a504-df6cf62d9e90@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f3cee834-4946-10bd-a504-df6cf62d9e90@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 04, 2020 at 08:00:01PM +0200, Daniel Lezcano wrote:
>
> Hi,
>
> On 29/04/2020 23:01, Daniel Lezcano wrote:
> > On 29/04/2020 22:02, Lukasz Luba wrote:
> >>
> >>
> >> On 4/29/20 11:36 AM, Daniel Lezcano wrote:
> >>> The cpuidle driver can be used as a cooling device by injecting idle
> >>> cycles. The DT binding for the idle state added an optional
> >>>
> >>> When the property is set, register the cpuidle driver with the idle
> >>> state node pointer as a cooling device. The thermal framework will do
> >>> the association automatically with the thermal zone via the
> >>> cooling-device defined in the device tree cooling-maps section.
> >>>
> >>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >>> ---
> >>>   - V4:
> >>>     - Do not check the return value as the function does no longer
> >>> return one
> >>> ---
> >
> > [ ... ]
> >
> >> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> >
> > Thanks Lukasz for the review.
> >
> > Rafael, as Lorenzo and Sudeep are not responsive, could you consider ack
> > this patch so I can merge the series through the thermal tree ?
>
> Gentle ping ... Sudeep, Lorenzo or Rafael ?
>

Sorry for the delay. I ignore this as it was generic and I was fine with
it. Didn't know you were waiting me, sorry for that.

FWIW:

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
