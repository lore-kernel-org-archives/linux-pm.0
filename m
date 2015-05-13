From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
Date: Wed, 13 May 2015 10:35:59 +0530
Message-ID: <20150513050559.GE28858@linux>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
 <554FFFA3.1060801@ti.com>
 <20150512051633.GB32300@linux>
 <555224A2.7000308@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35468 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbbEMFGL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2015 01:06:11 -0400
Received: by pabtp1 with SMTP id tp1so38422839pab.2
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2015 22:06:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <555224A2.7000308@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: broonie@kernel.org, Nishanth Menon <nm@ti.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, arnd.bergmann@linaro.org, mike.turquette@linaro.org, sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, grant.likely@linaro.org, olof@lixom.net, Sudeep.Holla@arm.com, devicetree@vger.kernel.org, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com

On 12-05-15, 11:04, Nishanth Menon wrote:
> Just curious -> is'nt it better to just have min<->max range? binding
> as it stands right now is open to interpretation as to what will be
> attempted and in what sequence? with a valid min, target or max -
> is'nt it more power efficient always to go for a "min" than a target?
> 
> Further, min<->max implies anywhere in that range and is more
> consistent with "regulator like" description.

It came out after some discussions on the list, you may want to go
through that.

https://lists.linaro.org/pipermail/linaro-kernel/2015-January/019844.html

> True. one option might be to allow for vendor specific property
> extensions - that will let vendors add in additional quirky data
> custom to their SoCs as needed.

Yeah, I am planning to support them.

-- 
viresh
