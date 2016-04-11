From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: cppc_cpufreq
Date: Mon, 11 Apr 2016 10:53:20 -0400
Message-ID: <CAJ5Y-eb9M7A7q+R9MtVn4wXFAJbW-jHCBTSC+Lbm76vd3P8HtQ@mail.gmail.com>
References: <1460072821.5409.5.camel@intel.com> <CAJ5Y-eaenct_KmZqGQsMdCeabdQqZBbzi9VCmOZHJ=snLy8XsA@mail.gmail.com>
 <1460237329.4491.12.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:36035 "EHLO
	mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754448AbcDKOxm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Apr 2016 10:53:42 -0400
Received: by mail-lf0-f53.google.com with SMTP id g184so160736331lfb.3
        for <linux-pm@vger.kernel.org>; Mon, 11 Apr 2016 07:53:41 -0700 (PDT)
In-Reply-To: <1460237329.4491.12.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>

On 9 April 2016 at 17:28, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On Fri, 2016-04-08 at 11:08 -0400, Ashwin Chaugule wrote:
>> On 7 April 2016 at 19:50, Pandruvada, Srinivas
>> <srinivas.pandruvada@intel.com> wrote:
>> > Hi Ashwin,
>> >
>> > I didn't see in the cppc_cpufreq.c
>> >
>> > MODULE_LICENSE()
>> >
>> > Is it intentional?
>>
>> Not intentional. Doesn't the absence of this default to GPLv2? or is
>> it required that the license be explicitly stated?
>>
> You are using symbols exported using EXPORT_SYMBOL_GPL
>
> I get following error during insmod:
>
> [   33.400861] cppc_cpufreq: module verification failed: signature
> and/or required key missing - tainting kernel
> [   33.400890] cppc_cpufreq: Unknown symbol cpufreq_register_driver
> (err 0)
> [   33.400901] cppc_cpufreq: Unknown symbol cppc_get_perf_ctrs (err 0)
> [   33.400914] cppc_cpufreq: Unknown symbol acpi_get_psd_map (err 0)
> [   33.400924] cppc_cpufreq: Unknown symbol cpufreq_freq_transition_end
> (err 0)
> [   33.400935] cppc_cpufreq: Unknown symbol cppc_get_perf_caps (err 0)
> [   33.400945] cppc_cpufreq: Unknown symbol
> cpufreq_freq_transition_begin (err 0)
> [   33.400954] cppc_cpufreq: Unknown symbol cppc_set_perf (err 0)
>
> I had to add MODULE_LICENSE(GPL).

Ok. Thanks for the heads up. Will post a patch soon, unless you want
to go ahead and send yours out.

Thanks,
Ashwin.
