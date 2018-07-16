From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: thermal: Allow multiple devices to
 share cooling map
Date: Mon, 16 Jul 2018 16:02:45 -0600
Message-ID: <20180716220245.GA20750@rob-hp-laptop>
References: <cover.1530766981.git.viresh.kumar@linaro.org>
 <bdd735da9a3c8159756b084ca96b555437057fa4.1530766981.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bdd735da9a3c8159756b084ca96b555437057fa4.1530766981.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, olof@lixom.net, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jul 05, 2018 at 10:39:23AM +0530, Viresh Kumar wrote:
> Allow cooling devices sharing same trip point with same contribution
> value to share the cooling map as well. Otherwise the same information
> will be duplicated for each device sharing the trip point.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  Documentation/devicetree/bindings/thermal/thermal.txt | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
