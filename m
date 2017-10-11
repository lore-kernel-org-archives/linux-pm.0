From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2] PM / OPP: add missing of_node_put() for
 of_get_cpu_node()
Date: Wed, 11 Oct 2017 12:21:21 +0100
Message-ID: <4808bf86-c90e-dbc0-e3fa-53af158f58f7@arm.com>
References: <1507632519-19648-1-git-send-email-sudeep.holla@arm.com>
 <1507716661-27146-1-git-send-email-sudeep.holla@arm.com>
 <20171011102146.GB32532@vireshk-i7>
 <62886e65-5bed-9a17-e1e0-0012ebc742ec@arm.com>
 <20171011103646.GD32532@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58662 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751888AbdJKLVZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Oct 2017 07:21:25 -0400
In-Reply-To: <20171011103646.GD32532@vireshk-i7>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>



On 11/10/17 11:36, Viresh Kumar wrote:
> On 11-10-17, 11:35, Sudeep Holla wrote:
>> Generally Greg pulls them based on fixes tags, so I didn't bother
>> to specify that explicitly :)
> 
> Hmm, I didn't knew that :)
> 

It's more than just that. Check this thread [1]

-- 
Regards,
Sudeep

[1] https://lkml.org/lkml/2017/10/6/923
