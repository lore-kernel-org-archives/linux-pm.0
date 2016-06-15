From: chenyu <yu.chen.surf@gmail.com>
Subject: Re: [RFC PATCH] x86: Move away from /dev/cpu/*/msr
Date: Wed, 15 Jun 2016 18:22:59 +0800
Message-ID: <CADjb_WSTH6b2vpM2A=Kp_NKdUzVEoAhPNAQgU0jCuLS2_o55xw@mail.gmail.com>
References: <20160615100029.GB32588@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34133 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753285AbcFOKXB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jun 2016 06:23:01 -0400
In-Reply-To: <20160615100029.GB32588@pd.tnic>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Renninger <trenn@suse.com>, Kan Liang <kan.liang@intel.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Linux PM list <linux-pm@vger.kernel.org>

On Wed, Jun 15, 2016 at 6:00 PM, Borislav Petkov <bp@alien8.de> wrote:
> Comments are, as always, appreciated.
>
> ---
> From: Borislav Petkov <bp@suse.de>
> Date: Wed, 15 Jun 2016 11:20:41 +0200
> Subject: [PATCH] Move away from msr.ko
>
> Take care of MSR_IA32_ENERGY_PERF_BIAS.
>
> Not-yet-signed-off-by: Borislav Petkov <bp@suse.de>
[cut]
> +static ssize_t
> +energy_policy_pref_hint_show(struct device *dev, struct device_attribute *attr,
> +                            char *buf)
> +{
> +       u64 epb;
> +
> +       rdmsrl(MSR_IA32_ENERGY_PERF_BIAS, epb);
MSR_IA32_ENERGY_PERF_BIAS is of core scope, should we use rdmsr_on_cpu?
> +
> +       return sprintf(buf, "%d\n", (unsigned int)(epb & 0xFULL));
> +}
> +
> +static ssize_t
> +energy_policy_pref_hint_store(struct device *dev, struct device_attribute *attr,
> +                             const char *buf, size_t count)
> +{
> +       u32 val;
> +       u64 epb;
> +
> +       if (kstrtou32(buf, 10, &val) < 0)
> +               return -EINVAL;
> +
> +       if (val > 15)
> +               return -EINVAL;
> +
> +       rdmsrl(MSR_IA32_ENERGY_PERF_BIAS, epb);
rdmsr_on_cpu?
> +
> +       if ((epb & 0xf) == val)
> +               return count;
> +
> +       wrmsrl(MSR_IA32_ENERGY_PERF_BIAS, (epb & ~0xFULL) | val);
wrmsr_on_cpu?



thanks,
Yu
