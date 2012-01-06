From: Antti P Miettinen <amiettinen@nvidia.com>
Subject: Re: [PATCH 0/6] RFC: CPU frequency min/max as PM QoS
	params
Date: Fri, 06 Jan 2012 21:38:39 +0200 (EET)
Message-ID: <20120106.213839.2153351629911262951.apm@brigitte.kvy.fi>
References: <1325810186-28986-1-git-send-email-amiettinen@nvidia.com>
	<20120106154613.GI12530@mgross-G62>
Reply-To: ananaza@iki.fi
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

[seems that posting via gmane is broken - resending (heehee - I do
resent the gmane problem :) manually via mail - sorry if you get
duplicates]

mark gross <markgross@thegnar.org> writes:
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 987a165..4cbd58b 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
[..]
> +	
> +	if (policy->min < pm_qos_request(PM_QOS_CPU_THROUGHPUT))
> +		policy->min = pm_qos_request(PM_QOS_CPU_THROUGHPUT);
>  

Consider the following sequence

- say original min is 100MHz
- PM QoS requests 1GHz minimum
- user requests 500MHz minimum via sysfs
- PM QoS request is canceled

After this the policy->min will be 1GHz. I'm not really happy with the
min/max save/restore etc but something is needed to enable restoring the
policy min/max when PM QoS constraints dissappear.

	--Antti
