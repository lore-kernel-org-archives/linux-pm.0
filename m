From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] PM / Domains: restore calling of .suspend/resume_noirq()
 callbacks
Date: Thu, 13 Nov 2014 20:43:24 +0200
Message-ID: <5464FBCC.7060307@ti.com>
References: <1415808047-23455-1-git-send-email-grygorii.strashko@ti.com> <2997289.NEH22PNoYM@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2997289.NEH22PNoYM@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, khilman@linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, k.kozlowski@samsung.com
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On 11/13/2014 03:33 AM, Rafael J. Wysocki wrote:
> On Wednesday, November 12, 2014 06:00:47 PM Grygorii Strashko wrote:
>> Now .suspend/resume_noirq() callbacks will not be called during
>> system wide suspend/resume for devices which belongs to some GPD.
>> It seems, that this change was accidentally introduced by
>> commit d23b9b00cdde ("PM / Domains: Rework system suspend callback
>>   routines (v2)").
> 
> I'm not sure if that was really accidentally.
> 
> Can you describe the problem that the change below is attempting to
> address, without going to much into the history?  IOW, what's that
> doesn't work right now?

There are no real issues - now in Kernel there are no users of GPD
which use "noirq" callbacks.

As of now, I'm trying to use GPD for Keyatone2, so 
I'm studying it and playing with it to understand all benefits and 
disadvantages of such solution.

So, I've found this issue, but not found any description of why
calls of these callbacks have been removed.
I'd very appreciate if can point me on?

> 
>> This patch restores calling of .suspend/resume_noirq() callbacks
>> for devices from GPD during system wide suspend/resume.
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
>>   drivers/base/power/domain.c | 14 +++++++++++---
>>   1 file changed, 11 insertions(+), 3 deletions(-)
>>
...

Regards,
-grygorii
 
