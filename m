From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 4/5] cpufreq: arm_big_little_dt: enhance OPP error
 checking
Date: Thu, 3 Oct 2013 09:26:27 -0500
Message-ID: <524D7E93.8040005@ti.com>
References: <1380634382-15609-1-git-send-email-Sudeep.KarkadaNagesha@arm.com> <1380634382-15609-5-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380634382-15609-5-git-send-email-Sudeep.KarkadaNagesha-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha-5wv7dgnIgG8@public.gmane.org>, cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 10/01/2013 08:33 AM, Sudeep KarkadaNagesha wrote:
> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha-5wv7dgnIgG8@public.gmane.org>
> 
> Since the OPPs can be specified either through 'operating-points'
> as tuples or through 'operating-points-phandle' as phandle to the
> node containing tuples, we need to check for both the properties.
> 
> Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
> Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/cpufreq/arm_big_little_dt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/arm_big_little_dt.c b/drivers/cpufreq/arm_big_little_dt.c
> index 480c0bd..b03d4fe 100644
> --- a/drivers/cpufreq/arm_big_little_dt.c
> +++ b/drivers/cpufreq/arm_big_little_dt.c
> @@ -35,7 +35,8 @@ static struct device_node *get_cpu_node_with_valid_op(int cpu)
>  {
>  	struct device_node *np = of_cpu_device_node_get(cpu);
>  
> -	if (!of_get_property(np, "operating-points", NULL)) {
> +	if (!of_get_property(np, "operating-points", NULL) &&
> +		!of_get_property(np, "operating-points-phandle", NULL)) {
>  		of_node_put(np);
>  		np = NULL;
>  	}
> 
generated checkpatch --strict warning:
CHECK: Alignment should match open parenthesis
#28: FILE: drivers/cpufreq/arm_big_little_dt.c:39:
+	if (!of_get_property(np, "operating-points", NULL) &&
+		!of_get_property(np, "operating-points-phandle", NULL)) {

otherwise,
Reviewed-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>

-- 
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
