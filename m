From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/2] dt: thermal: Fix broken cooling-maps
Date: Tue, 31 Jul 2018 10:21:51 +0530
Message-ID: <20180731045151.gqsgsm6l3gwr5m4z@vireshk-i7>
References: <cover.1530766981.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1530766981.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, robh@kernel.org, Wei Xu <xuwei5@hisilicon.com>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, olof@lixom.net, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 05-07-18, 10:39, Viresh Kumar wrote:
> Hi,
> 
> This is an attempt to fix the broken or partially defined DT bindings
> for cooling-maps. We should list every device that participates in
> cooling down at a certain trip point, instead of just the first in the
> list as that depends on certain ordering of events to work properly.
> 
> The first patch extends the binding to allow a list of phandles in
> "cooling-device" property and the second patch fixes one of the
> platform's DT.
> 
> This will be followed up by fixing all platform DT bindings that have
> these issues after this set is accepted.
> 
> The kernel also requires some changes to handle the phandle list, but
> wouldn't break with these changes as it reads the first phandle in the
> list for now. We can update that separately.

@Zhang: Are you going to apply this for 4.19-rc1 ? There are lot of patches that
I am holding up until this gets merged.

-- 
viresh
