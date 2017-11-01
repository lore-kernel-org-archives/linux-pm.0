From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] cpupower: Fix no-rounding MHz frequency output
Date: Wed, 1 Nov 2017 22:33:40 +0100
Message-ID: <CAJZ5v0hKmVeAbPtr06_JCDMd1U5TXxs+VW-7jYUnAwseXaiX7A@mail.gmail.com>
References: <20171025135132.16324-1-prarit@redhat.com> <54215387-96b8-07d3-0b0e-4df4a0b0dca6@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:47223 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934159AbdKAVdm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Nov 2017 17:33:42 -0400
Received: by mail-oi0-f65.google.com with SMTP id h200so6612931oib.4
        for <linux-pm@vger.kernel.org>; Wed, 01 Nov 2017 14:33:41 -0700 (PDT)
In-Reply-To: <54215387-96b8-07d3-0b0e-4df4a0b0dca6@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shuah Khan <shuah@kernel.org>
Cc: Prarit Bhargava <prarit@redhat.com>, Linux PM <linux-pm@vger.kernel.org>, Thomas Renninger <trenn@suse.com>, Stafford Horne <shorne@gmail.com>, Shuah Khan <shuahkh@osg.samsung.com>

On Wed, Nov 1, 2017 at 10:00 PM, Shuah Khan <shuah@kernel.org> wrote:
> On 10/25/2017 07:51 AM, Prarit Bhargava wrote:
>> 'cpupower frequency-info -ln' returns kHz values on systems with MHz range
>> minimum CPU frequency range.  For example, on a 800MHz to 4.20GHz system
>> the command returns
>>
>> hardware limits: 800000 MHz - 4.200000 GHz
>>
>> The code that causes this error can be removed.  The next else if clause
>> will handle the output correctly such that
>>
>> hardware limits: 800.000 MHz - 4.200000 GHz
>>
>> is displayed correctly.
>>
>> [v2]: Remove two lines instead of fixing broken code.
>>
>> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>> Cc: Thomas Renninger <trenn@suse.com>
>> Cc: Stafford Horne <shorne@gmail.com>
>> Cc: Shuah Khan <shuah@kernel.org>
>> ---
>>  tools/power/cpupower/utils/cpufreq-info.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
>> index 3e701f0e9c14..df43cd45d810 100644
>> --- a/tools/power/cpupower/utils/cpufreq-info.c
>> +++ b/tools/power/cpupower/utils/cpufreq-info.c
>> @@ -93,8 +93,6 @@ static void print_speed(unsigned long speed)
>>               if (speed > 1000000)
>>                       printf("%u.%06u GHz", ((unsigned int) speed/1000000),
>>                               ((unsigned int) speed%1000000));
>> -             else if (speed > 100000)
>> -                     printf("%u MHz", (unsigned int) speed);
>>               else if (speed > 1000)
>>                       printf("%u.%03u MHz", ((unsigned int) speed/1000),
>>                               (unsigned int) (speed%1000));
>>
>
> Thanks.  I will queue this up for 4.15-rc1.

OK

So are you going to maintain this utility going forward?

Thanks,
Rafael
