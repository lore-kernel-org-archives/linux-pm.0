From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 1/4] cpufreq: exynos: Adding cpufreq driver for exynos5440
Date: Wed, 6 Mar 2013 14:21:53 +0800
Message-ID: <CAKohpon6w6i0X4wJRE-FG8bfYMk2aMVCa6pOgbBwWPHy=Dttwg@mail.gmail.com>
References: <1362216854-6633-1-git-send-email-amit.daniel@samsung.com>
	<CAKohpomHoDSNVyc21VVif8BrDKyZ=fSeCnWCZjDHL+64Bo+dgg@mail.gmail.com>
	<CADGdYn7RXks+Xvv__NeKu8o9ZsaEp15F6zDMtL158tFcKkxxEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CADGdYn7RXks+Xvv__NeKu8o9ZsaEp15F6zDMtL158tFcKkxxEw@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: amit kachhap <amit.kachhap@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kgene.kim@samsung.com, Thomas Abraham <thomas.abraham@linaro.org>, cpufreq@vger.kernel.org, Inderpal Singh <inderpal.singh@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 6 March 2013 13:35, amit kachhap <amit.kachhap@gmail.com> wrote:
> On Tue, Mar 5, 2013 at 6:48 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

>>> +static void exynos_cpufreq_work(struct work_struct *work)
>>> +{
>>> +       unsigned int cur_pstate, index;
>>> +       struct cpufreq_policy *policy = cpufreq_cpu_get(0); /* boot CPU */
>>> +       struct cpufreq_frequency_table *freq_table = dvfs_info->freq_table;
>>> +
>>> +       if (policy == NULL)
>>> +               goto skip_work;
>>
>> How can that be true? And if it can be, you will miss POSTCHANGE notifications
>> too.
> This skip of POSTCHANGE notifications is needed in one case where
> bootup frequency does not match with any elements of cpufreq table and
> hence I simply assign the highest frequency. Also cpufreq driver is
> not registered at this point.

I will keep a variable for that then, otherwise its misleading... So keep a
variable like cpufreq_enabled for it and set it to 1 as soon as this first
interrupt is gone... keep it in unlikely() too.

>>> +       dvfs_info = kzalloc(sizeof(struct exynos_dvfs_data), GFP_KERNEL);
>>
>> sizeof(*dvfs_info) ??
> Isn't both same?

You need to read Documentation/CodingStyle.
