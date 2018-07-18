From: Wei Xu <xuwei5@hisilicon.com>
Subject: Re: [PATCH 0/2] dt: thermal: Fix broken cooling-maps
Date: Wed, 18 Jul 2018 16:34:24 +0100
Message-ID: <5B4F5E00.5050800@hisilicon.com>
References: <cover.1530766981.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1530766981.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, robh@kernel.org
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, olof@lixom.net, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Viresh,

On 2018/7/5 6:09, Viresh Kumar wrote:
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
> 
> --
> viresh
> 
> Viresh Kumar (2):
>   dt-bindings: thermal: Allow multiple devices to share cooling map
>   arm64: dts: hi6220: Add all CPUs in cooling maps
> 
>  Documentation/devicetree/bindings/thermal/thermal.txt | 11 +++--------
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi             |  9 ++++++++-
>  2 files changed, 11 insertions(+), 9 deletions(-)
> 

Thanks!
Applied both to the hisilicon dt tree.

Best Regards,
Wei
