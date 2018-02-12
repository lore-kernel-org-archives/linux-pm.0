From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Query] thermal: Who is using "cooling-{min|max}-level}"
 properties ?
Date: Mon, 12 Feb 2018 14:22:42 +0530
Message-ID: <20180212085242.GQ28462@vireshk-i7>
References: <20180207065959.GN28462@vireshk-i7>
 <c7bd6ed5-b93e-3a07-b4a2-4c3b1eef5fac@linaro.org>
 <20180207102446.GS28462@vireshk-i7>
 <11fbba25-7029-8a13-476e-ea2f2de6fbf9@linaro.org>
 <20180209064211.GY28462@vireshk-i7>
 <539699c7-9509-dea2-2b31-c5f6749c99c4@linaro.org>
 <20180209092421.GL28462@vireshk-i7>
 <5722441d-c8be-4d29-fab7-28b4e5716961@linaro.org>
 <20180212061015.GO28462@vireshk-i7>
 <0b73e1aa-a88f-fe4b-b33a-0f589000e148@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:46486 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932967AbeBLIwq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Feb 2018 03:52:46 -0500
Received: by mail-io0-f169.google.com with SMTP id k80so5118964ioe.13
        for <linux-pm@vger.kernel.org>; Mon, 12 Feb 2018 00:52:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <0b73e1aa-a88f-fe4b-b33a-0f589000e148@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org, Punit.Agrawal@arm.com, ionela.voinescu@arm.com

On 12-02-18, 09:39, Daniel Lezcano wrote:
> On 12/02/2018 07:10, Viresh Kumar wrote:
> > On 09-02-18, 13:14, Daniel Lezcano wrote:
> >> Putting apart the device binding changes discussion for the moment. Why
> >> not register the cpufreq driver in all the cases and then drop
> > 
> > s/cpufreq driver/cpufreq cooling driver/ ??
> 
> yes.
> 
> >> cooling-cells ? So when the opps are present, its registers in the
> >> cpufreq->ready callback.
> > 
> > How will someone tell if they don't need the cooling infrastructure ?
> > Specially for multiplatform thing.
> 
> They don't define a cooling device in the DT ?

Sorry but I am getting a bit confused on what you are suggesting.
Maybe you need to rephrase it once more for me, from the very
beginning :)

-- 
viresh
