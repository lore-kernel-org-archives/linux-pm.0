From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v6 05/12] ACPI/PPTT: Add Processor Properties Topology
 Table parsing
Date: Wed, 17 Jan 2018 18:00:34 +0000
Message-ID: <caa1bb6b-7338-a9b0-467e-d0cd09783a9c@arm.com>
References: <20180113005920.28658-1-jeremy.linton@arm.com>
 <20180113005920.28658-6-jeremy.linton@arm.com>
 <20180115154813.GB17664@e107155-lin>
 <096cdff0-d160-68ba-4cd2-0691dd04eac6@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <096cdff0-d160-68ba-4cd2-0691dd04eac6@arm.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, hanjun.guo@linaro.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org, lenb@kernel.org, vkilari@codeaurora.org, morten.rasmussen@arm.com
List-Id: linux-pm@vger.kernel.org



On 16/01/18 20:22, Jeremy Linton wrote:
> Hi,
> 

[..]

>>
>> I forgot to mention this earlier, I see you have used parentheses too
>> liberally at quite some place in this file like the above 4 line.
>> Please drop those unnecessary parentheses.
> 
> Yes, those tend to get leftover when I remove code, I realized not long
> after posting this that in one of the previous patches I actually added
> a pair where there wasn't one because I first shuffled something into
> the if condition, then a few revisions later dropped it, and when I
> squashed it before posting the result was some pointless churn.
> 
> I will rescan the whole set for this.
> 

Better, just to avoid keeping such things until the end, resulting in
churning up series just for that.

-- 
Regards,
Sudeep
