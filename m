From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Query] thermal: Who is using "cooling-{min|max}-level}"
 properties ?
Date: Mon, 12 Feb 2018 15:47:46 +0530
Message-ID: <20180212101746.GT28462@vireshk-i7>
References: <20180207102446.GS28462@vireshk-i7>
 <11fbba25-7029-8a13-476e-ea2f2de6fbf9@linaro.org>
 <20180209064211.GY28462@vireshk-i7>
 <539699c7-9509-dea2-2b31-c5f6749c99c4@linaro.org>
 <20180209092421.GL28462@vireshk-i7>
 <5722441d-c8be-4d29-fab7-28b4e5716961@linaro.org>
 <20180212061015.GO28462@vireshk-i7>
 <0b73e1aa-a88f-fe4b-b33a-0f589000e148@linaro.org>
 <20180212085242.GQ28462@vireshk-i7>
 <f361b9a0-08ac-9d19-76b2-83e67a6a2406@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:41202 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933006AbeBLKRu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Feb 2018 05:17:50 -0500
Received: by mail-pg0-f48.google.com with SMTP id t4so6168372pgp.8
        for <linux-pm@vger.kernel.org>; Mon, 12 Feb 2018 02:17:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <f361b9a0-08ac-9d19-76b2-83e67a6a2406@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org, Punit.Agrawal@arm.com, ionela.voinescu@arm.com

On 12-02-18, 10:52, Daniel Lezcano wrote:
> Just to clarify my comment above, I understood you were asking how to
> not use the cpu as a cooling device. As the binding between the cooling
> device and the thermal zone happens when the DT nodes are the same, when
> registering the cpufreq driver as a cooling device and when the
> cooling-device registers itself at the cooling-map parsing time, if we
> remove the cooling-device in the cooling-map, the binding never happens
> thus the cpu is never used as a cooling device.

Ahh, understood your comment now.

> However, these are all
> required fields, so the only way to do that is to remove the entire
> thermal zone node, not sure it is what we want :)

Yeah, so thing stay as is for now :)

-- 
viresh
