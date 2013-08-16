From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 02/34] cpufreq: acpi: remove calls to cpufreq_notify_transition()
Date: Fri, 16 Aug 2013 13:29:58 +0530
Message-ID: <CAKohpom7yk3Zq5JABZ6T+Z_AcMn5G1hoswZK8T=viYv0fp0mcg@mail.gmail.com>
References: <cover.1376619363.git.viresh.kumar@linaro.org>
	<333bf5868dfbfb6de474f060dc216fa6d33848e2.1376619363.git.viresh.kumar@linaro.org>
	<CAOLK0pz7e8nQVnZY0a-j_Fd_kFOqF8ZS4tRfYw1S+25Lv8GoFQ@mail.gmail.com>
	<CAOLK0pyVDSc6x1u8Ro6ng1dH8ELqc3P9jPHamgiXBn6sWDgm8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAOLK0pyVDSc6x1u8Ro6ng1dH8ELqc3P9jPHamgiXBn6sWDgm8w@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Lan Tianyu <lantianyu1986@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 16 August 2013 13:24, Lan Tianyu <lantianyu1986@gmail.com> wrote:
> Sorry for misoperation.

No Problem...

>                 One concern. Target() callback may return before changing
> cpufreq actually due to some check failures. After this change, prechange
> event will be triggered when these check failures take place. I am not sure
> whether this should be took into account.

Yes, if you see the first patch of this series, it takes this into
account.. In case
target() failed and returned an error, we simply notify the POST CHANGE
notification with old frequencies instead of new ones. I believe that would be
enough..

This is exactly what acpi-cpufreq and others are doing currently.

Hope I answered your question well?

--
viresh
