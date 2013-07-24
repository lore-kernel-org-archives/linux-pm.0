From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 1/3 v6] cpufreq: Add debugfs directory for cpufreq
Date: Wed, 24 Jul 2013 18:14:31 +0900
Message-ID: <51EF9AF7.60007@samsung.com>
References: <1374146275-5758-1-git-send-email-cw00.choi@samsung.com>
 <1374146275-5758-2-git-send-email-cw00.choi@samsung.com>
 <CAKohpo=oTsEjzi_51UaZ8ww8UEfZ6hwKAnu9rFgGBkt=TfHi8A@mail.gmail.com>
 <51EF2D06.7000704@samsung.com>
 <CAKohpok7B6DaqFPWZcODEgK5GRSoAQYZ27-h2=AQ1HBBP4gH8Q@mail.gmail.com>
 <51EF8590.7030405@samsung.com>
 <CAKohpom19C7JHSX6w31pSDrwcAR_PZn1HzP0Jui5iZL=bALDPQ@mail.gmail.com>
 <51EF945E.3080802@samsung.com>
 <CAKohpo=_3iR44XfxuRAmw-9DDk9APniWH=efd72v845wH3C-DQ@mail.gmail.com>
 <51EF98DD.4010607@samsung.com>
 <CAKohpon02iZpB7BVwdJR69Ne=8GbL0z76D7ExtAahCE-R_vnnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <CAKohpon02iZpB7BVwdJR69Ne=8GbL0z76D7ExtAahCE-R_vnnA@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, kyungmin.park@samsung.com, myungjoo.ham@samsung.com, Lists linaro-kernel <linaro-kernel@lists.linaro.org>
List-Id: linux-pm@vger.kernel.org

On 07/24/2013 06:09 PM, Viresh Kumar wrote:
> On 24 July 2013 14:35, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>> And, I add additional step on below:
>>
>>> - Remove symlink for new policy->cpu, i..e cpu1 in your example
>>> - rename debugfs entry to give it to cpu1 instead of cpu0.
>>   - Store renamed cpu0 pointer to cpu1 pointer
>>   - Create new link for CPU[2-3] to CPU1's debugfs directory
>>         because debugfs use string path to create symbolic link.
>>         It isn't automatically connected with new CPU1 debugfs directory.
> 
> Honestly speaking I am not the best at debugfs core, but I still think
> the link is connected to a struct debugfs node and not to any path..
> This node is connected to a path though. And so even after rename
> things should stay stable without your new step...
> 
> Just try and see if I am right or wrong.. Otherwise what you already
> did is correct as you need to remove links for 2-3 as well..
> 

OK, I'll try it according to your suggestion. Thanks.

Best Regards,
Chanwoo Choi
