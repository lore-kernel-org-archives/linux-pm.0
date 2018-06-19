From: Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ FW
 bindings
Date: Tue, 19 Jun 2018 13:23:19 +0530
Message-ID: <514eea88-1f98-7959-2341-3d57cff6f66b@codeaurora.org>
References: <1528801355-18719-1-git-send-email-tdas@codeaurora.org>
 <1528801355-18719-2-git-send-email-tdas@codeaurora.org>
 <0f3f0223-3539-dc66-5300-8f30d827445d@arm.com>
 <7abb2da6-c130-117a-5404-d07bb132d915@codeaurora.org>
 <f57f2708-28bb-dcdd-8b93-d41ade10fa18@arm.com>
 <bc6dc152-7def-fc1d-4535-11a44fd64310@codeaurora.org>
 <CAHLCerMCM1qf1MJ3bz+ZwBQMjshKSCWKXjHCiuqxJTDBdauamQ@mail.gmail.com>
 <32e8f874-a58b-8ba3-7a53-dc89cb34f7d9@codeaurora.org>
 <fad24065-bb2d-33f9-e877-425db3391e8f@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fad24065-bb2d-33f9-e877-425db3391e8f@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, Amit Kucheria <amit.kucheria@verdurent.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan <skannan@codeaurora.org>
List-Id: linux-pm@vger.kernel.org



On 6/18/2018 2:51 PM, Sudeep Holla wrote:
> 
> 
> On 15/06/18 18:40, Taniya Das wrote:
>>
>>
>> On 6/15/2018 5:29 PM, Amit Kucheria wrote:
> 
> [...]
> 
>>> A future version of the HW engine, or more likely, a firmware
>>> revision, will make more functionality available. Say, this needs
>>> access to another register or two. This will require changing the DT
>>> bindings. Instead, if you map the entire address space, you can just
>>> add offsets to the new registers.
>>>
>>> So in this case, I think you should define the following addresses
>>> (size 0x1400) for the two frequency domains
>>>
>>> 0x17d43000, 0x1400 (power cluster)
>>> 0x17d45800, 0x1400 (perf cluster)
>>>
>>> And in the driver simply add offsets as follows:
>>>
>>> #define ENABLE_OFFSET               0x0
>>> #define LUT_OFFSET                      0x110
>>> #define PERF_DESIRED_OFFSET 0x920
>>>
>>
>> The offsets could vary across versions of this IP and that is the reason
>> to provide them through the DT and not define any such offsets.
>>
> 
> Just get compatibles to identify the version of the hardware if it can't
> be probed and detected. Please don't use DT to get the addresses of each
> register you use in the driver. That's neither scalable nor nice
> solution to the problem.
> Hello Sudeep and Amit,

Thanks for the comments, I am consolidating the understanding from the 
other emails in a single one.

I understand that you are looking for this IP to map the full region and 
define offsets according to access them.

But I still not sure how do you want this common driver to scale in the 
cases where the offsets could vary across version change.

  DT
====
   freq-node {
	reg = < X x_size>;   Where X is the start of the IP address.
   }

Driver code (The below representation is just for example).
=============

V1
#define ENABLE	0x0
#define LUT_V1	0x110
#define PERF_V1	0x920

V2
#define LUT_V2	0x150
#define PERF_V2	0x980

V3
#define LUT_V3	0x120
....

Do you want me to use "compatible" flag to

if (compatible == v1)
  enable =  readl_relaxed(X + LUT_V1);
else if (compatible == v2)
  enable = readl_relaxed(X + LUT_V2);
else if (compatible == v3)
  enable = readl_relaxed(X + LUT_V2);

With the current design I do not need such compatible checks and unmap 
the ones which are not required after probe. Please let me know your 
comments.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
