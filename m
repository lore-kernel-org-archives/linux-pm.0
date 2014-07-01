From: Tuomas Tynkkynen <tuomas.tynkkynen-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCH 6/6] thermal: Add Tegra SOCTHERM thermal management driver
Date: Wed, 02 Jul 2014 02:47:58 +0300
Message-ID: <53B348AE.20605@iki.fi>
References: <1403856699-2140-1-git-send-email-mperttunen@nvidia.com> <1403856699-2140-7-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1403856699-2140-7-git-send-email-mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, mlongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 27/06/14 11:11, Mikko Perttunen wrote:
> +	/* Sign extend from 6 bits to 32 bits */
> +	shifted_cp = (s32)((val & 0x1f) | ((val & 0x20) ? 0xffffffe0 : 0x0));
> +	val = ((val & (0x1f << 21)) >> 21);
> +	/* Sign extend from 5 bits to 32 bits */
> +	shifted_ft = (s32)((val & 0xf) | ((val & 0x10) ? 0xfffffff0 : 0x0));

There's sign_extend32 in bitops.h
