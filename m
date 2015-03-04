From: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: Re: [PATCH v8 15/18] cpufreq: Add cpufreq driver for Tegra124
Date: Wed, 04 Mar 2015 09:11:59 +0200
Message-ID: <54F6B03F.8080703@iki.fi>
References: <1425213881-5262-1-git-send-email-mikko.perttunen@kapsi.fi>	 <1425213881-5262-16-git-send-email-mikko.perttunen@kapsi.fi> <1425286186.24292.76.camel@x220> <54F59C16.2010401@kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54F59C16.2010401@kapsi.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Cc: Paul Bolle <pebolle@tiscali.nl>, swarren@wwwdotorg.org, thierry.reding@gmail.com, gnurou@gmail.com, pdeschrijver@nvidia.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, mturquette@linaro.org, pwalmsley@nvidia.com, vinceh@nvidia.com, pgaikwad@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tuomas Tynkkynen <ttynkkynen@nvidia.com>
List-Id: linux-pm@vger.kernel.org

On 03/03/2015 01:33 PM, Mikko Perttunen wrote:
> On 03/02/2015 10:49 AM, Paul Bolle wrote:
>> On Sun, 2015-03-01 at 14:44 +0200, Mikko Perttunen wrote:
>>
>> [...]
>>
>>> +static struct platform_driver tegra124_cpufreq_platdrv = {
>>> +    .driver = {
>>> +        .name    = "cpufreq-tegra124",
>>> +        .owner    = THIS_MODULE,
>>
>> .owner will always be, in short, NULL.
>>

Which reminds me: recently there have been cleanups that remove the 
.owner field assignments (e.g. 30f51f248c1d "cpufreq: drop owner 
assignment from platform_drivers"), so it can be removed from here as well.


>
> Well noticed! I changed the config symbol to be tristate.
>
> Thanks,
> Mikko Perttunen
>
