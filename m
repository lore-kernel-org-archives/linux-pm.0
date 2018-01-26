From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: Re: [PATCH] base: power: domain: Replace mdelay with msleep
Date: Fri, 26 Jan 2018 18:28:29 +0800
Message-ID: <bc936aa3-ce69-2531-b5bf-686425a784fd@gmail.com>
References: <1516955899-31810-1-git-send-email-baijiaju1990@gmail.com>
 <20180126102604.GB13775@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180126102604.GB13775@amd>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org, len.brown@intel.com, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 2018/1/26 18:26, Pavel Machek wrote:
> On Fri 2018-01-26 16:38:19, Jia-Ju Bai wrote:
>> After checking all possible call chains to genpd_dev_pm_detach() and
>> genpd_dev_pm_attach() here,
>> my tool finds that these functions are never called in atomic context,
>> namely never in an interrupt handler or holding a spinlock.
>> Thus mdelay can be replaced with msleep to avoid busy wait.
>>
>> This is found by a static analysis tool named DCNS written by
> myself.
>
> Well, cond_resched() just after msleep certainly looks like that.
>
> Did the patch receive any testing?
>

Thanks for reply :)

I only perform compilation testing but did not run it in real execution.


Thanks,
Jia-Ju Bai
