From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ FW
 bindings
Date: Mon, 18 Jun 2018 10:21:41 +0100
Message-ID: <fad24065-bb2d-33f9-e877-425db3391e8f@arm.com>
References: <1528801355-18719-1-git-send-email-tdas@codeaurora.org>
 <1528801355-18719-2-git-send-email-tdas@codeaurora.org>
 <0f3f0223-3539-dc66-5300-8f30d827445d@arm.com>
 <7abb2da6-c130-117a-5404-d07bb132d915@codeaurora.org>
 <f57f2708-28bb-dcdd-8b93-d41ade10fa18@arm.com>
 <bc6dc152-7def-fc1d-4535-11a44fd64310@codeaurora.org>
 <CAHLCerMCM1qf1MJ3bz+ZwBQMjshKSCWKXjHCiuqxJTDBdauamQ@mail.gmail.com>
 <32e8f874-a58b-8ba3-7a53-dc89cb34f7d9@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <32e8f874-a58b-8ba3-7a53-dc89cb34f7d9@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Taniya Das <tdas@codeaurora.org>, Amit Kucheria <amit.kucheria@verdurent.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan <skannan@codeaurora.org>
List-Id: linux-pm@vger.kernel.org



On 15/06/18 18:40, Taniya Das wrote:
> 
> 
> On 6/15/2018 5:29 PM, Amit Kucheria wrote:

[...]

>> A future version of the HW engine, or more likely, a firmware
>> revision, will make more functionality available. Say, this needs
>> access to another register or two. This will require changing the DT
>> bindings. Instead, if you map the entire address space, you can just
>> add offsets to the new registers.
>>
>> So in this case, I think you should define the following addresses
>> (size 0x1400) for the two frequency domains
>>
>> 0x17d43000, 0x1400 (power cluster)
>> 0x17d45800, 0x1400 (perf cluster)
>>
>> And in the driver simply add offsets as follows:
>>
>> #define ENABLE_OFFSET               0x0
>> #define LUT_OFFSET                      0x110
>> #define PERF_DESIRED_OFFSET 0x920
>>
> 
> The offsets could vary across versions of this IP and that is the reason
> to provide them through the DT and not define any such offsets.
> 

Just get compatibles to identify the version of the hardware if it can't
be probed and detected. Please don't use DT to get the addresses of each
register you use in the driver. That's neither scalable nor nice
solution to the problem.

-- 
Regards,
Sudeep
