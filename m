From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: tests: Providing cpufreq regression test
Date: Wed, 23 Jul 2014 10:36:15 +0530
Message-ID: <CAKohpondk7Cty8MhTcjyzZW8Z0o4AVupYE0rRnG4YJf+SmDyjg@mail.gmail.com>
References: <1405678985-21677-1-git-send-email-l.majewski@samsung.com>
	<1405926154-27214-1-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:54808 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754537AbaGWFGQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jul 2014 01:06:16 -0400
Received: by mail-oi0-f46.google.com with SMTP id i138so483116oig.33
        for <linux-pm@vger.kernel.org>; Tue, 22 Jul 2014 22:06:16 -0700 (PDT)
In-Reply-To: <1405926154-27214-1-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Thomas Abraham <ta.omasab@gmail.com>, "thomas.ab@samsung.com" <thomas.ab@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tomasz Figa <t.figa@samsung.com>, Sachin Kamat <spk.linux@gmail.com>

Hi Lukasz,

I haven't replied yet as I wanted to see what the general feed of Rafael
is going to be :)

As this is something new and wasn't sure if we really want this..

On 21 July 2014 12:32, Lukasz Majewski <l.majewski@samsung.com> wrote:
> This commit adds first regression test "cpufreq_freq_test.sh" for the
> cpufreq subsystem.

That's not enough, Tell us why we should continue reading this mail..

> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
>
> ---
> Changes for v2:
> - Replace *_PATCH with *_PATH for variables names
> - Corrected mistakes in the README file
> - Providing detailed explanation of the patch in the README file
> ---
>  drivers/cpufreq/tests/README               |  33 +++++++
>  drivers/cpufreq/tests/cpufreq_freq_test.sh | 149 +++++++++++++++++++++++++++++

Probably a better place would be tools/power/cpufreq/

@Rafael?

>  2 files changed, 182 insertions(+)
>  create mode 100644 drivers/cpufreq/tests/README
>  create mode 100755 drivers/cpufreq/tests/cpufreq_freq_test.sh
>
> diff --git a/drivers/cpufreq/tests/README b/drivers/cpufreq/tests/README
> new file mode 100644
> index 0000000..3e9cd80
> --- /dev/null
> +++ b/drivers/cpufreq/tests/README
> @@ -0,0 +1,33 @@
> +This file contains list of cpufreq's available regression tests with a short
> +usage description.
> +
> +1. cpufreq_freq_test.sh
> +
> +Description:
> +------------
> +This script is supposed to test if cpufreq attributes exported by sysfs are
> +exposing correct values.
> +
> +To achieve this goal it saves the current governor and changes it to
> +"performance". Afterwards, it reads the "scaling_available_frequencies"
> +property. With the list of supported frequencies it is able to enforce each of
> +them by writing to "scaling_max_freq" attribute. To make the test more reliable
> +a superfluous load with gzip is created to be sure that we are running with
> +highest possible frequency. This high load is regulated with the 'sleep'
> +duration. After this time the "cpufreq_cur_freq" is read and compared with the
> +original value. As the last step the original governor is restored.

I couldn't make out the purpose of this test and why we need it. How do
we ensure that "cpufreq attributes exported by sysfs are exposing
correct values"?

And actually what do we mean by this statement even? What kind of errors can
be there in exposing these values.

I want to understand the purpose of this script very clearly first and then only
will look at the details.
