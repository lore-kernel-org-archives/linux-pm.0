From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ FW
 bindings
Date: Tue, 19 Jun 2018 14:51:22 +0530
Message-ID: <20180619092122.ul56qnh5uangti3e@vireshk-i7>
References: <1528801355-18719-1-git-send-email-tdas@codeaurora.org>
 <1528801355-18719-2-git-send-email-tdas@codeaurora.org>
 <0f3f0223-3539-dc66-5300-8f30d827445d@arm.com>
 <7abb2da6-c130-117a-5404-d07bb132d915@codeaurora.org>
 <f57f2708-28bb-dcdd-8b93-d41ade10fa18@arm.com>
 <bc6dc152-7def-fc1d-4535-11a44fd64310@codeaurora.org>
 <CAHLCerMCM1qf1MJ3bz+ZwBQMjshKSCWKXjHCiuqxJTDBdauamQ@mail.gmail.com>
 <32e8f874-a58b-8ba3-7a53-dc89cb34f7d9@codeaurora.org>
 <fad24065-bb2d-33f9-e877-425db3391e8f@arm.com>
 <514eea88-1f98-7959-2341-3d57cff6f66b@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <514eea88-1f98-7959-2341-3d57cff6f66b@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Taniya Das <tdas@codeaurora.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Amit Kucheria <amit.kucheria@verdurent.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Stephen Boyd <sboyd@kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan <skannan@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On 19-06-18, 13:23, Taniya Das wrote:
> Driver code (The below representation is just for example).
> =============
> 
> V1
> #define ENABLE	0x0
> #define LUT_V1	0x110
> #define PERF_V1	0x920
> 
> V2
> #define LUT_V2	0x150
> #define PERF_V2	0x980
> 
> V3
> #define LUT_V3	0x120
> ....
> 
> Do you want me to use "compatible" flag to
> 
> if (compatible == v1)
>  enable =  readl_relaxed(X + LUT_V1);
> else if (compatible == v2)
>  enable = readl_relaxed(X + LUT_V2);
> else if (compatible == v3)
>  enable = readl_relaxed(X + LUT_V2);

You can have fields in a struct somewhere like enable_offset, which you can fill
based on compatible string only once during probe and then the rest of the code
would just do:

enable = readl_relaxed(X + struct->enable_offset);

-- 
viresh
