From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v4] cpufreq: stats: Add 'load_table' debugfs file to show
 accumulated data of CPUs
Date: Fri, 28 Jun 2013 18:24:13 +0900
Message-ID: <51CD563D.9010809@samsung.com>
References: <1372405697-13556-1-git-send-email-cw00.choi@samsung.com>
 <CAKohpomk7tC4xZ32sOh4NQR-qNOM=xHj43GcMu_squ1nFELGpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <CAKohpomk7tC4xZ32sOh4NQR-qNOM=xHj43GcMu_squ1nFELGpg@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, kyungmin.park@samsung.com, myungjoo.ham@samsung.com
List-Id: linux-pm@vger.kernel.org

On 06/28/2013 05:27 PM, Viresh Kumar wrote:
> On 28 June 2013 13:18, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>>  drivers/cpufreq/Kconfig            |   6 +
>>  drivers/cpufreq/cpufreq.c          |   4 +
>>  drivers/cpufreq/cpufreq_governor.c |  15 +++
>>  drivers/cpufreq/cpufreq_stats.c    | 241 +++++++++++++++++++++++++++++++++----
>>  include/linux/cpufreq.h            |   6 +
>>  5 files changed, 246 insertions(+), 26 deletions(-)
> 
> Please update Documentation/cpu-freq/cpufreq-stats.txt for this as well.

OK. I'll add description.

Best Regards,
Chanwoo Choi

