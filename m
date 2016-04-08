From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: cppc_cpufreq
Date: Fri, 8 Apr 2016 11:08:15 -0400
Message-ID: <CAJ5Y-eaenct_KmZqGQsMdCeabdQqZBbzi9VCmOZHJ=snLy8XsA@mail.gmail.com>
References: <1460072821.5409.5.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:33324 "EHLO
	mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758421AbcDHPIm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 Apr 2016 11:08:42 -0400
Received: by mail-lf0-f53.google.com with SMTP id e190so79448875lfe.0
        for <linux-pm@vger.kernel.org>; Fri, 08 Apr 2016 08:08:36 -0700 (PDT)
In-Reply-To: <1460072821.5409.5.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>

On 7 April 2016 at 19:50, Pandruvada, Srinivas
<srinivas.pandruvada@intel.com> wrote:
> Hi Ashwin,
>
> I didn't see in the cppc_cpufreq.c
>
> MODULE_LICENSE()
>
> Is it intentional?

Not intentional. Doesn't the absence of this default to GPLv2? or is
it required that the license be explicitly stated?


Thanks,
Ashwin.
