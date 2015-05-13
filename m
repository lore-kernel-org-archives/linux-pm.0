From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
Date: Wed, 13 May 2015 10:00:41 -0500
Message-ID: <55536719.5050208@ti.com>
References: <cover.1430394884.git.viresh.kumar@linaro.org> <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org> <554FFFA3.1060801@ti.com> <20150512051633.GB32300@linux> <555224A2.7000308@ti.com> <20150513050559.GE28858@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59944 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934434AbbEMPBg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 13 May 2015 11:01:36 -0400
In-Reply-To: <20150513050559.GE28858@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, broonie@kernel.org
Cc: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, arnd.bergmann@linaro.org, mike.turquette@linaro.org, sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, grant.likely@linaro.org, olof@lixom.net, Sudeep.Holla@arm.com, devicetree@vger.kernel.org, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com

On 05/13/2015 12:05 AM, Viresh Kumar wrote:
> On 12-05-15, 11:04, Nishanth Menon wrote:
>> Just curious -> is'nt it better to just have min<->max range? binding
>> as it stands right now is open to interpretation as to what will be
>> attempted and in what sequence? with a valid min, target or max -
>> is'nt it more power efficient always to go for a "min" than a target?
>>
>> Further, min<->max implies anywhere in that range and is more
>> consistent with "regulator like" description.
> 
> It came out after some discussions on the list, you may want to go
> through that.
> 
> https://lists.linaro.org/pipermail/linaro-kernel/2015-January/019844.html

I see the thread saying that voltage-tolerance is a crappy idea -> I
agree to that.

What I dont see in the thread, and the point I raised here, why have
nominal/typical voltage at all? min<->max should be sufficient,
correct? If the device cannot function at min, then it should not be
documented as part of valid range at all.


-- 
Regards,
Nishanth Menon
