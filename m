From: Xiaoguang Chen <chenxg.marvell@gmail.com>
Subject: Re: [PATCH 2/2] cpufreq: Only do governor start after successful stop
Date: Wed, 14 Aug 2013 15:38:21 +0800
Message-ID: <CAFgnuDeZDo3oA-ZQ2qn6mGXJVQmGwax7g91-d-D6KFrChENfOg@mail.gmail.com>
References: <1376377766-2594-1-git-send-email-chenxg@marvell.com>
	<1376377766-2594-2-git-send-email-chenxg@marvell.com>
	<CAKohponW5GwnrL8EktnWb-U5V=eOFQQkbZrx=QgUpfuci3v-0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohponW5GwnrL8EktnWb-U5V=eOFQQkbZrx=QgUpfuci3v-0w@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Xiaoguang Chen <chenxg@marvell.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

2013/8/14 Viresh Kumar <viresh.kumar@linaro.org>:
> On 13 August 2013 12:39, Xiaoguang Chen <chenxg@marvell.com> wrote:
>> cpufreq_add_policy_cpu, __cpufreq_remove_dev and __cpufreq_set_policy
>> have operations for governor stop and start.
>> Only do the start operation when the previous stop operation succeeds.
>>
>> Signed-off-by: Xiaoguang Chen <chenxg@marvell.com>
>> ---
>>  drivers/cpufreq/cpufreq.c | 25 +++++++++++++++----------
>>  1 file changed, 15 insertions(+), 10 deletions(-)
>
> I hope you have seen this patch, which is already in Rafael's tree?
>
> https://lkml.org/lkml/2013/8/6/357

ohh, That is exactly what my patch tries to do. Sorry I just checked
mainline patch. I missed this one. Thank you very much!

Thanks
Xiaoguang
