Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED293C77B7A
	for <linux-pm@archiver.kernel.org>; Thu, 25 May 2023 09:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbjEYJSu (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 25 May 2023 05:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjEYJSu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 May 2023 05:18:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB63CA9
        for <linux-pm@vger.kernel.org>; Thu, 25 May 2023 02:18:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B57771042;
        Thu, 25 May 2023 02:19:33 -0700 (PDT)
Received: from bogus (unknown [10.57.96.86])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F329E3F67D;
        Thu, 25 May 2023 02:18:46 -0700 (PDT)
Date:   Thu, 25 May 2023 10:18:44 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [CfP] Power Management and Thermal Control MC (LPC2023)
Message-ID: <20230525091844.tbxrk5gcwr2lppfo@bogus>
References: <CAJZ5v0juUuy2xKZHMXAKSRtfQxMyL6z12AFdU8_ZbdFRKKrR=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0juUuy2xKZHMXAKSRtfQxMyL6z12AFdU8_ZbdFRKKrR=Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On Mon, May 22, 2023 at 07:12:39PM +0200, Rafael J. Wysocki wrote:
> Hi Folks,
> 
> I'm going to submit a Power Management and Thermal Control
> micro-conference proposal for LPC2023 along the lines of what happened
> in the previous iterations of it.
> 
> If you have topics that you'd like to be discussed there, please let
> me know by Friday, May 26.
> 
> Please note that LPC MC topics are expected to cover work in progress
> or at the concept stage.  They are not supposed to be about work that
> has been done already.
> 

One topic I am thinking of is possible ACPI extensions for device DVFS
something similar to CPU CPPC which I think both x86 and Arm community
are interested. There are also bunch of topics for Arm based laptop like
devices which probably x86 don't have to deal with. I am not sure if 
LPC uconf is the right forum but since many of the topics are now driven
by code first approach, I thought of bringing it up here and see if there
is any interest.

Let me know what do you think.

-- 
Regards,
Sudeep
