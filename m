From: Laura Abbott <labbott@redhat.com>
Subject: Re: [REGRESSION] 774ac8b7eff6 ("Thermal: initialize thermal zone
 device correctly") causes performance drop
Date: Wed, 16 Mar 2016 17:00:07 -0700
Message-ID: <56E9F387.9080703@redhat.com>
References: <56E9DDED.7000805@redhat.com> <20160316224634.GA3580@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:34988 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935230AbcCQAAM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2016 20:00:12 -0400
Received: by mail-qg0-f44.google.com with SMTP id y89so59022414qge.2
        for <linux-pm@vger.kernel.org>; Wed, 16 Mar 2016 17:00:11 -0700 (PDT)
In-Reply-To: <20160316224634.GA3580@kroah.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Javi Merino <javi.merino@arm.com>, Chen Yu <yu.c.chen@intel.com>, Manuel Krause <manuelkrause@netscape.net>, szegad <szegadlo@poczta.onet.pl>, prash <prash.n.rao@gmail.com>, amish <ammdispose-arch@yahoo.com>, Matthias <morpheusxyz123@yahoo.de>, linux-pm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 03/16/2016 03:46 PM, Greg Kroah-Hartman wrote:
> On Wed, Mar 16, 2016 at 03:27:57PM -0700, Laura Abbott wrote:
>> Hi,
>>
>> Fedora received a bug report (https://bugzilla.redhat.com/show_bug.cgi?id=1317190)
>> of a major performance drop on various bench marks and general system
>> sluggishness with the 4.4.4 kernel update. The benchmarks were showing
>> a reduction to about 18% performance (not minor).
>>
>> Bisection showed the first bad commit was
>>
>> commit 774ac8b7eff69e0786970157de2157e68b22f456
>> Author: Zhang Rui <rui.zhang@intel.com>
>> Date:   Fri Oct 30 16:31:47 2015 +0800
>>
>>      Thermal: initialize thermal zone device correctly
>>      commit bb431ba26c5cd0a17c941ca6c3a195a3a6d5d461 upstream.
>>      After thermal zone device registered, as we have not read any
>>      temperature before, thus tz->temperature should not be 0,
>>      which actually means 0C, and thermal trend is not available.
>>      In this case, we need specially handling for the first
>>      thermal_zone_device_update().
>>      Both thermal core framework and step_wise governor is
>>      enhanced to handle this. And since the step_wise governor
>>      is the only one that uses trends, so it's the only thermal
>>      governor that needs to be updated.
>>      Tested-by: Manuel Krause <manuelkrause@netscape.net>
>>      Tested-by: szegad <szegadlo@poczta.onet.pl>
>>      Tested-by: prash <prash.n.rao@gmail.com>
>>      Tested-by: amish <ammdispose-arch@yahoo.com>
>>      Tested-by: Matthias <morpheusxyz123@yahoo.de>
>>      Reviewed-by: Javi Merino <javi.merino@arm.com>
>>      Signed-off-by: Zhang Rui <rui.zhang@intel.com>
>>      Signed-off-by: Chen Yu <yu.c.chen@intel.com>
>>      Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>
>>
>>
>> Reverting this plus to other commits in the series (a67208e94d94
>> "Thermal: handle thermal zone device properly during system sleep"
>> and 27f356149d59 "Thermal: do thermal zone update after a cooling
>> device registered") confirmed the performance was back to normal.
>>
>> Bugzilla has the full discussion but this comment from one of the
>> reporters sums it up:
>>
>> "In 4.4.3 and prior, my 2.40 MHz processor would fluctuate between
>> 1000 and 3400 MHz.  In 4.4.4, the processor would fluctuate between
>> 400 and 700 MHz, according to /proc/cpuinfo.
>>
>> Setting /sys/devices/system/cpu/cpufreq/policy0/scaling_governor to
>> performance, instead of the default "powersave" forces the CPU to
>> 2400 MHz, and improves performance greatly, but still not to the
>> same level as in 4.4.3."
>>
>> Any ideas?
>
> Is this same "slowdown" also seen in 4.5?
>
> thanks,
>
> greg k-h
>

Yes, the same issue is seen on 4.5 according to the reporter.

Thanks,
Laura
