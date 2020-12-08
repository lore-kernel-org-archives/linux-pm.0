Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6F9C433FE
	for <linux-pm@archiver.kernel.org>; Tue,  8 Dec 2020 11:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65A3A23A1D
	for <linux-pm@archiver.kernel.org>; Tue,  8 Dec 2020 11:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbgLHLW0 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 8 Dec 2020 06:22:26 -0500
Received: from foss.arm.com ([217.140.110.172]:47550 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbgLHLW0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Dec 2020 06:22:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E2FF1FB;
        Tue,  8 Dec 2020 03:21:40 -0800 (PST)
Received: from bogus (unknown [10.57.33.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41C8F3F68F;
        Tue,  8 Dec 2020 03:21:38 -0800 (PST)
Date:   Tue, 8 Dec 2020 11:21:35 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Nicola Mazzucato <nicola.mazzucato@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        rjw@rjwysocki.net, vireshk@kernel.org, robh+dt@kernel.org,
        sboyd@kernel.org, nm@ti.com, daniel.lezcano@linaro.org,
        morten.rasmussen@arm.com, chris.redpath@arm.com
Subject: Re: [PATCH v4 3/4] scmi-cpufreq: get opp_shared_cpus from opp-v2 for
 EM
Message-ID: <20201208112135.eivmitaigkrjnsq5@bogus>
References: <20201202172356.10508-1-nicola.mazzucato@arm.com>
 <20201202172356.10508-4-nicola.mazzucato@arm.com>
 <20201208055053.kggxw26kxtnpneua@vireshk-i7>
 <0e4d3134-f9b2-31fa-b454-fb30265a80b5@arm.com>
 <20201208072611.ptsqupv4y2wybs6p@vireshk-i7>
 <83b8400f-8dc4-000e-d790-0bf584a75f48@arm.com>
 <20201208110148.7scxsjlkbzmxr43f@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208110148.7scxsjlkbzmxr43f@vireshk-i7>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 08, 2020 at 04:31:48PM +0530, Viresh Kumar wrote:
> On 08-12-20, 10:58, Nicola Mazzucato wrote:
> > 
> > 
> > On 12/8/20 7:26 AM, Viresh Kumar wrote:
> > > On 08-12-20, 07:22, Nicola Mazzucato wrote:
> > >> On 12/8/20 5:50 AM, Viresh Kumar wrote:
> > >>> On 02-12-20, 17:23, Nicola Mazzucato wrote:
> > >>>>  	nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
> > >>>>  	if (nr_opp <= 0) {
> > >>>> -		dev_dbg(cpu_dev, "OPP table is not ready, deferring probe\n");
> > >>>> -		ret = -EPROBE_DEFER;
> > >>>> -		goto out_free_opp;
> > >>>> +		ret = handle->perf_ops->device_opps_add(handle, cpu_dev);
> > >>>> +		if (ret) {
> > >>>> +			dev_warn(cpu_dev, "failed to add opps to the device\n");
> > >>>> +			goto out_free_cpumask;
> > >>>> +		}
> > >>>> +
> > >>>> +		ret = dev_pm_opp_set_sharing_cpus(cpu_dev, opp_shared_cpus);
> > >>>> +		if (ret) {
> > >>>> +			dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
> > >>>> +				__func__, ret);
> > >>>> +			goto out_free_cpumask;
> > >>>> +		}
> > >>>> +
> > >>>
> > >>> Why do we need to call above two after calling
> > >>> dev_pm_opp_get_opp_count() ?
> > >>
> > >> Sorry, I am not sure to understand your question here. If there are no opps for
> > >> a device we want to add them to it
> > > 
> > > Earlier we used to call handle->perf_ops->device_opps_add() and
> > > dev_pm_opp_set_sharing_cpus() before calling dev_pm_opp_get_opp_count(), why is
> > > the order changed now ?
> > 
> > True. The order has changed to take into account the fact that when we have
> > per-cpu + opp-shared, we don't need to add opps for devices which already have them.
> 
> The opp-shared thing is mostly a dummy thing to get you some information here.
> What else has changed here ? I still don't understand why the OPPs would get
> added and so the duplicate OPPs messages. Does this already happen ?
> 

Yes, details in my earlier response.

-- 
Regards,
Sudeep
