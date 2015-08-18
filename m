From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 0/6] ARM: berlin: add cpufreq support
Date: Tue, 18 Aug 2015 20:29:25 +0530
Message-ID: <20150818145925.GF31148@linux>
References: <1439898368-11543-1-git-send-email-antoine.tenart@free-electrons.com>
 <CAOh2x=ke9NWa-GjL=c+RgEWWfsNeKvE2O9CRHmW2dG5mj8ATCg@mail.gmail.com>
 <20150818143911.GB12017@kwain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150818143911.GB12017@kwain>
Sender: linux-kernel-owner@vger.kernel.org
To: Antoine Tenart <antoine.tenart@free-electrons.com>
Cc: sebastian.hesselbarth@gmail.com, zmxu@marvell.com, jszhang@marvell.com, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 18-08-15, 16:39, Antoine Tenart wrote:
> However, it seems the OPP-v2 table takes precedence over the old one.
> When a default OPP-v2 table is supplied in the device tree, if the
> bootloader supplies an OPP table the old way it won't be taken into
> account.
> 
> So if I understood correctly, this won't work here for the BG2Q.

Didn't understood it completely. Are you saying that your dtb will
have two operating-points tables ?

The deal is that for any device, parsing of opp-v2 will be attempted
first. If its not available, then opp-v1 will be tried. But this is
per-device. So, one device can have opp-v2 tables and other one can do
v1 type.

-- 
viresh
