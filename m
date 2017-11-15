From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: Re: [PATCH v2] cpupowerutils: bench - Fix cpu online check
Date: Wed, 15 Nov 2017 08:21:02 -0700
Message-ID: <d62d3807-18d2-04ac-7cdb-adf24144c41e@osg.samsung.com>
References: <20171107094755.49440-1-huntbag@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171107094755.49440-1-huntbag@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Abhishek Goel <huntbag@linux.vnet.ibm.com>, trenn@suse.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>, Shuah Khan <shuah@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 11/07/2017 02:47 AM, Abhishek Goel wrote:
> cpupower_is_cpu_online was incorrectly checking for 0. This patch fixes
> this by checking for 1 when the cpu is online.
> 
> Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
> ---
> v2: Commit message rephrased.
> ---
>  tools/power/cpupower/bench/system.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/power/cpupower/bench/system.c b/tools/power/cpupower/bench/system.c
> index c25a74a..2bb3eef 100644
> --- a/tools/power/cpupower/bench/system.c
> +++ b/tools/power/cpupower/bench/system.c
> @@ -61,7 +61,7 @@ int set_cpufreq_governor(char *governor, unsigned int cpu)
> 
>  	dprintf("set %s as cpufreq governor\n", governor);
> 
> -	if (cpupower_is_cpu_online(cpu) != 0) {
> +	if (cpupower_is_cpu_online(cpu) != 1) {
>  		perror("cpufreq_cpu_exists");
>  		fprintf(stderr, "error: cpu %u does not exist\n", cpu);
>  		return -1;
> 

Thanks. I will queue this up for 4.15-rc2

-- Shuah
