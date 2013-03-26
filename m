From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] cpufreq: cpu0: Fix mistake in Documentation example
Date: Tue, 26 Mar 2013 23:50:03 +0100
Message-ID: <1473108.YvH7sY4Gsu@vostro.rjw.lan>
References: <225d20676ec96aa81683f23485f0339e32a22917.1364308732.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <225d20676ec96aa81683f23485f0339e32a22917.1364308732.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: shawn.guo@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, arvind.chauhan@arm.com, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, rob.herring@calxeda.com
List-Id: linux-pm@vger.kernel.org

On Tuesday, March 26, 2013 08:10:46 PM Viresh Kumar wrote:
> "clock-latency" is incorrectly written as "transition-latency" in an example
> present in Documentation of cpufreq-cpu0. Fix it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Am I supposed to take this?

Rafael


> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
> index 4416ccc..051f764 100644
> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
> @@ -32,7 +32,7 @@ cpus {
>  			396000  950000
>  			198000  850000
>  		>;
> -		transition-latency = <61036>; /* two CLK32 periods */
> +		clock-latency = <61036>; /* two CLK32 periods */
>  	};
>  
>  	cpu@1 {
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
