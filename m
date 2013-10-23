From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 Resend 13/34] cpufreq: ia64: Convert to light weight
 ->target_index() routine
Date: Wed, 23 Oct 2013 09:56:30 +0530
Message-ID: <CAKohpomR1rtRFP2bLi2M6gf6sN6Rc5H8Q8v9mk9M7+9EWHxsnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:50217 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076Ab3JWE0a (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Oct 2013 00:26:30 -0400
Received: by mail-ob0-f169.google.com with SMTP id wp4so337175obc.28
        for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2013 21:26:30 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "rjw@sisk.pl" <rjw@sisk.pl>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "patches@linaro.org" <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 22 October 2013 22:02, Luck, Tony <tony.luck@intel.com> wrote:
>> This patch converts existing .target() to newly defined light weight
>> .target_index() routine for this driver.
>>
>> CPUFreq core will call cpufreq_frequency_table_target() before calling this
>> routine and will pass index to it.
>>
>> Cc: Tony Luck <tony.luck@intel.com>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> Tested-by: Tony Luck <tony.luck@intel.com>

Thanks Tony..

@Rafael: Count this Tested-by for 1/34 and 31/34 as he actually
tested both :)
