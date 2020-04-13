Return-Path: <SRS0=Imah=55=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B94EC2BB55
	for <linux-pm@archiver.kernel.org>; Mon, 13 Apr 2020 02:01:58 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F292206C3
	for <linux-pm@archiver.kernel.org>; Mon, 13 Apr 2020 02:01:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F292206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pm-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbgDMCB4 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 12 Apr 2020 22:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgDMCB4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Apr 2020 22:01:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D41C0A3BE0
        for <linux-pm@vger.kernel.org>; Sun, 12 Apr 2020 19:01:57 -0700 (PDT)
IronPort-SDR: 9JnDo3NnYiBPctInxECexVwjtklfPP5HT1xqI3OWB0zjjvZyVVowDLYb0juTnDE8F9yDep5GcM
 U/d/fXivs5eg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2020 19:01:56 -0700
IronPort-SDR: IoTa00alKS8kHCgbI1kAiiRabnGK18B+IzYMOVk474GOY6TlcL6smnteSCbho6p3Imkl2h5aNX
 5ClnAwQaeSFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,377,1580803200"; 
   d="scan'208";a="399474922"
Received: from lzhang2-mobl2.ccr.corp.intel.com ([10.255.28.254])
  by orsmga004.jf.intel.com with ESMTP; 12 Apr 2020 19:01:54 -0700
Message-ID: <17727142fac13f641d7cd5c3713cfadef77aa75c.camel@intel.com>
Subject: Re: [RFC PATCH 5/5] ACPI: processor: do update when maximum cooling
 state changed
From:   Zhang Rui <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     tiwai@suse.de, viresh.kumar@linaro.org
Date:   Mon, 13 Apr 2020 10:01:48 +0800
In-Reply-To: <e264d4a2-b0d9-8adf-b44f-7501c4407029@linaro.org>
References: <20200408041917.2329-1-rui.zhang@intel.com>
         <20200408041917.2329-5-rui.zhang@intel.com>
         <5cd80df7-775e-96bd-cec5-b14965de2a67@linaro.org>
         <2bef9553fcf7ccd7c9811ad1d572af2e5a811917.camel@intel.com>
         <a15dee60-8d20-0f56-0037-276830c613cd@linaro.org>
         <fee68438572796c71089571e0ff0add6cbbd3e0c.camel@intel.com>
         <e264d4a2-b0d9-8adf-b44f-7501c4407029@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 2020-04-12 at 12:07 +0200, Daniel Lezcano wrote:
> 
> 
> 
> 
> Hi Rui,
> 
> On 12/04/2020 08:13, Zhang Rui wrote:
> > On Fri, 2020-04-10 at 14:10 +0200, Daniel Lezcano wrote:
> 
> [ ... ]
> 
> > > > And to fix this, it's better to
> > > > a. unregister and re-register the cooling device as you
> > > > suggested.
> > > > or
> > > > b. introduce an API that updates the cooling device entirely
> > > > instead of
> > > > statistics table only.
> > > > 
> > > > For either of the above solutions, we'd better to cleanup the
> > > > code
> > > > to 
> > > > invoke .get_max_state() during registration/max_state_reset
> > > > phase,
> > > > once, and then always use cached value later.
> > > > And plus, if we want to follow solution a), it's better to
> > > > remove
> > > > .get_max_state() callback and use an integer instead so that
> > > > every
> > > > driver knows this limitation.
> > > > I'd vote for solution a) if there is no soc thermal driver that
> > > > may
> > > > return dynamic max_states.
> > > > 
> > > > Do I still miss something?
> > > 
> > > I agree for the a) solution too.
> > > 
> > > But regarding the get_max_state() callback being converted to a
> > > integer,
> > > the driver int3406_thermal.c computes the upper and lower limits
> > > which
> > > are updated on a INT3406_BRIGHTNESS_LIMITS_CHANGED notification
> > > and
> > > get_max_state() does uppper - lower.
> > 
> > Right, this is another case shows that it's better to support
> > dynamic
> > max_state.
> > IMO, this is not difficult to do. We just need to introduce a new
> > API,
> > which reuses the current cdev device, and reset its every thermal
> > instance, and update all the thermal zones the cdev is involved.
> > what do you think?
> 
> I like how the thermal framework is designed but I think there are
> too
> many API for the thermal framework and it deserves a simplification
> rather than adding more of them.

I agree.
> 
> There is no place where the get_max_state is cached except in the
> stats
> structure.

why we can not have a cdev->max_state field, and get it updated right
after .get_max_state().
and .get_max_state()  is only invoked
a) during cooling device registration
b) when cooling device update its max_state via the new API.

> 
> In the function thermal_cooling_device_stats_update():
> 
>   Is it possible to just compare the 'new_state' parameter with
> stats->max_state and if it is greater increase the stats table and
> update max_state to the new_state ?
> 
the problem is that thermal_cooling_device_stats_update() is invoked
only if thermal zone are updated or the cur_state sysfs attribute is
changed.
There is no way for a cooling device driver to tell thermal framework
that it has changed.
Say, for the problem on hand, the statistics table will not be updated
in time when cpufreq driver probed.

thanks,
rui

