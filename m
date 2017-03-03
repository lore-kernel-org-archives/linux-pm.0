From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] PM / OPP: Documentation: Fix opp-microvolt in examples
Date: Fri, 3 Mar 2017 00:21:38 -0600
Message-ID: <20170303062138.5gwbkbw4g33d4bvc@rob-hp-laptop>
References: <e527318dc8b5a1acf260499c65cf025732d9fc51.1488365712.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e527318dc8b5a1acf260499c65cf025732d9fc51.1488365712.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 01, 2017 at 04:39:55PM +0530, Viresh Kumar wrote:
> The triplet present in "opp-microvolt" property should be in the order
> <target min max>, while all the examples have it in the order
> <min target max>.
> 
> Fix it.
> 
> Luckily all of the users of "opp-microvolt" property have applied brain
> instead of copying the examples from documentation and none of the
> actual dts files have it wrong.
> 
> Reported-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  Documentation/devicetree/bindings/opp/opp.txt | 44 +++++++++++++--------------
>  1 file changed, 22 insertions(+), 22 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
