From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 1/2] PM / OPP: Remove OF dependency on
 dev_pm_opp_of_{cpumask_,}remove_table
Date: Thu, 28 Apr 2016 12:22:02 +0100
Message-ID: <5721F25A.8050505@arm.com>
References: <1461839114-29857-1-git-send-email-sudeep.holla@arm.com>
 <20160428111221.GB2915@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20160428111221.GB2915@vireshk-i7>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 28/04/16 12:12, Viresh Kumar wrote:
> On 28-04-16, 11:25, Sudeep Holla wrote:
>> + * dev_pm_opp_remove_table() - Free OPP table static entries associated with
>> + *			       the device
>
> Its not about static entries anymore, right? We will end up removing everything
> we had in the table.
>

No, not yet. I have not made that change yet. I just asked that question
in patch 2. I still remove individually but wanted to know if removing
dynamic opp is any issue ?

The OPP added using dev_pm_opp_add are marked dynamic and are not
deleted by dev_pm_opp_{,cpumask_}remove_table. If it does, then
scpi_free_opp_table can be assigned that instead of what I have in patch
2/2.

> Can you please update comments also in the same patch ?
>

Sure once you agree and I make that change  ;)

-- 
Regards,
Sudeep
