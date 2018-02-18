From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 10/10] dt-bindings: thermal: Remove
 "cooling-{min|max}-level" properties
Date: Sun, 18 Feb 2018 17:29:06 -0600
Message-ID: <20180218232906.jkpymin3a4qxjhnc@rob-hp-laptop>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
 <0ec53640f1a09e6e0d7aa1a21d1a3266c3c209c7.1518166039.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <0ec53640f1a09e6e0d7aa1a21d1a3266c3c209c7.1518166039.git.viresh.kumar@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org, daniel.lezcano@linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 09, 2018 at 02:28:10PM +0530, Viresh Kumar wrote:
> The "cooling-min-level" and "cooling-max-level" properties are not
> parsed by any part of kernel currently and the max cooling state of a
> CPU cooling device is found by referring to the cpufreq table instead.

What about non-CPU devices? A fan for example.

> 
> Remove the unused bindings.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  Documentation/devicetree/bindings/thermal/thermal.txt | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
> index 1719d47a5e2f..cc553f0952c5 100644
> --- a/Documentation/devicetree/bindings/thermal/thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/thermal.txt
> @@ -55,8 +55,7 @@ of heat dissipation). For example a fan's cooling states correspond to
>  the different fan speeds possible. Cooling states are referred to by
>  single unsigned integers, where larger numbers mean greater heat
>  dissipation. The precise set of cooling states associated with a device
> -(as referred to by the cooling-min-level and cooling-max-level
> -properties) should be defined in a particular device's binding.
> +should be defined in a particular device's binding.
>  For more examples of cooling devices, refer to the example sections below.
>  
>  Required properties:
> @@ -69,15 +68,6 @@ For more examples of cooling devices, refer to the example sections below.
>  			See Cooling device maps section below for more details
>  			on how consumers refer to cooling devices.
>  
> -Optional properties:
> -- cooling-min-level:	An integer indicating the smallest
> -  Type: unsigned	cooling state accepted. Typically 0.
> -  Size: one cell
> -
> -- cooling-max-level:	An integer indicating the largest
> -  Type: unsigned	cooling state accepted.
> -  Size: one cell
> -
>  * Trip points
>  
>  The trip node is a node to describe a point in the temperature domain
> @@ -226,8 +216,6 @@ cpus {
>  			396000  950000
>  			198000  850000
>  		>;
> -		cooling-min-level = <0>;
> -		cooling-max-level = <3>;
>  		#cooling-cells = <2>; /* min followed by max */
>  	};
>  	...
> @@ -241,8 +229,6 @@ cpus {
>  	 */
>  	fan0: fan@48 {
>  		...
> -		cooling-min-level = <0>;
> -		cooling-max-level = <9>;
>  		#cooling-cells = <2>; /* min followed by max */
>  	};
>  };
> -- 
> 2.15.0.194.g9af6a3dea062
> 
