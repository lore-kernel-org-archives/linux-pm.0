From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH v2] cpupower: Fix no-rounding MHz frequency output
Date: Thu, 2 Nov 2017 15:43:11 -0400
Message-ID: <e5ce4cc2-a67f-92d0-7ac5-d5ad4e04ea70@redhat.com>
References: <20171025135132.16324-1-prarit@redhat.com>
 <54215387-96b8-07d3-0b0e-4df4a0b0dca6@kernel.org>
 <CAJZ5v0hKmVeAbPtr06_JCDMd1U5TXxs+VW-7jYUnAwseXaiX7A@mail.gmail.com>
 <5a15dfc3-9dca-92a3-063c-b9a653ccbf0b@osg.samsung.com>
 <CAJZ5v0j6hC=eUnNKFO3dgTBd572AOngtnetGNjjm1kXWjeCrOg@mail.gmail.com>
 <a6f19fbd-3bc8-f8a1-4515-1a1bcecddce7@osg.samsung.com>
 <CAJZ5v0gkFYyJPewqHrCFQsfVHyqzn=H_mbUtqNEmDmPDpVGuVA@mail.gmail.com>
 <0023af85-a643-edaf-f6d4-fba1c3756e6e@osg.samsung.com>
 <cc10ec84-e016-3f1b-163f-21cea09f7173@redhat.com>
 <126a1373-cd76-3f1e-2f91-5b5ea8a664ec@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51472 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934065AbdKBTnN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Nov 2017 15:43:13 -0400
In-Reply-To: <126a1373-cd76-3f1e-2f91-5b5ea8a664ec@osg.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shuah Khan <shuahkh@osg.samsung.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Stafford Horne <shorne@gmail.com>, Shuah Khan <shuah@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Thomas Renninger <trenn@suse.com>



On 11/02/2017 02:59 PM, Shuah Khan wrote:
> On 11/01/2017 06:42 PM, Prarit Bhargava wrote:
>>
>>
>> On 11/01/2017 06:30 PM, Shuah Khan wrote:
>>> On 11/01/2017 04:07 PM, Rafael J. Wysocki wrote:
>>>> On Wed, Nov 1, 2017 at 10:49 PM, Shuah Khan <shuahkh@osg.samsung.com> wrote:
>>>>> On 11/01/2017 03:46 PM, Rafael J. Wysocki wrote:
>>>>>> On Wed, Nov 1, 2017 at 10:38 PM, Shuah Khan <shuahkh@osg.samsung.com> wrote:
>>>>>>> On 11/01/2017 03:33 PM, Rafael J. Wysocki wrote:
>>>>>>>> On Wed, Nov 1, 2017 at 10:00 PM, Shuah Khan <shuah@kernel.org> wrote:
>>>>>>>>> On 10/25/2017 07:51 AM, Prarit Bhargava wrote:
>>>>>>>>>> 'cpupower frequency-info -ln' returns kHz values on systems with MHz range
>>>>>>>>>> minimum CPU frequency range.  For example, on a 800MHz to 4.20GHz system
>>>>>>>>>> the command returns
>>>>>>>>>>
>>>>>>>>>> hardware limits: 800000 MHz - 4.200000 GHz
>>>>>>>>>>
>>>>>>>>>> The code that causes this error can be removed.  The next else if clause
>>>>>>>>>> will handle the output correctly such that
>>>>>>>>>>
>>>>>>>>>> hardware limits: 800.000 MHz - 4.200000 GHz
>>>>>>>>>>
>>>>>>>>>> is displayed correctly.
>>>>>>>>>>
>>>>>>>>>> [v2]: Remove two lines instead of fixing broken code.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>>>>>>>>>> Cc: Thomas Renninger <trenn@suse.com>
>>>>>>>>>> Cc: Stafford Horne <shorne@gmail.com>
>>>>>>>>>> Cc: Shuah Khan <shuah@kernel.org>
>>>>>>>>>> ---
>>>>>>>>>>  tools/power/cpupower/utils/cpufreq-info.c | 2 --
>>>>>>>>>>  1 file changed, 2 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
>>>>>>>>>> index 3e701f0e9c14..df43cd45d810 100644
>>>>>>>>>> --- a/tools/power/cpupower/utils/cpufreq-info.c
>>>>>>>>>> +++ b/tools/power/cpupower/utils/cpufreq-info.c
>>>>>>>>>> @@ -93,8 +93,6 @@ static void print_speed(unsigned long speed)
>>>>>>>>>>               if (speed > 1000000)
>>>>>>>>>>                       printf("%u.%06u GHz", ((unsigned int) speed/1000000),
>>>>>>>>>>                               ((unsigned int) speed%1000000));
>>>>>>>>>> -             else if (speed > 100000)
>>>>>>>>>> -                     printf("%u MHz", (unsigned int) speed);
>>>>>>>>>>               else if (speed > 1000)
>>>>>>>>>>                       printf("%u.%03u MHz", ((unsigned int) speed/1000),
>>>>>>>>>>                               (unsigned int) (speed%1000));
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Thanks.  I will queue this up for 4.15-rc1.
>>>>>>>>
>>>>>>>> OK
>>>>>>>>
>>>>>>>> So are you going to maintain this utility going forward?
>>>>>>>>
>>>>>>>
>>>>>>> oops. I was on auto-pilot responding to patches sitting in my Inbox.
>>>>>>> Wrong email response. Sorry about that.
>>>>>>>
>>>>>>> Please ignore. Mu bad.
>>>>>>
>>>>>> OK :-)
>>>>>>
>>>>>> But that said, from my perspective, cpupower is basically not maintained.
>>>>>>
>>>>>> Thomas, who sort of maintained it, but then basically became a patch
>>>>>> reviewer for it, does not respond to patches any more and I am not
>>>>>> sufficiently familiar with the code to be able to effectively review
>>>>>> the patches myself, nor I have the time to get more familiar with it.
>>>>>>
>>>>>> For this reason, I'm inclined to drop this code from the kernel source
>>>>>> tree unless somebody steps in to fill the gap.
>>>>>>
>>>>>
>>>>> Please don't drop this from kernel sources.. I think this is useful. If you
>>>>> are looking for a maintainer, I will be happy to step up to maintain it.
>>>>
>>>> Cool, please do that then. :-)
>>>>
>>>> I will be happy to take pull requests with cpupower changes so that
>>>> they go in along with the other PM material.
>>>>
>>>
>>> Sounds like a plan. I can do that. I will work on getting git setup and
>>> send pull requests. We can get that going for 4.15 unless you think it is
>>> late for you to get pull requests.
>>
>> Shuah, I have two other cleanup patches that should be applied to cpupower.  I
>> will post them shortly.
>>
> 
> Hi Prarit,
> 
> Does this tool build for you? I am seeing:
> 
> utils/helpers/amd.c:7:21: fatal error: pci/pci.h: No such file or directory
>  #include <pci/pci.h>
>                      ^
> compilation terminated.
> Makefile:221: recipe for target 'utils/helpers/amd.o' failed
> make: *** [utils/helpers/amd.o] Error 1
> 

It does not build on latest due to some other unrelated change.  I'm looking at
it now.

P.

> thanks,
> -- Shuah
> 
