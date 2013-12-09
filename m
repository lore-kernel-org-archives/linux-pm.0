From: Martin Ziegler <ziegler@email.mathematik.uni-freiburg.de>
Subject: Re: [PATCH] cpufreq: fix garbage kobj on errors during
 suspend/resume
Date: Mon, 09 Dec 2013 12:24:51 +0100
Message-ID: <alpine.DEB.2.10.1312091228130.13468@zertz.mathematik.uni-freiburg.de>
References: <1386069272-9250-1-git-send-email-bjorn@mork.no> <529F04B2.7050303@linaro.org> <2628468.jr1aJZyvPu@vostro.rjw.lan> <CAOLK0pxW_AjtGNwW2G8-1SpJbYs_GWQDLV=7XzPfDHRj6tCxQQ@mail.gmail.com> <52A567A6.6000400@linux.vnet.ibm.com>
Reply-To: Martin Ziegler <ziegler@uni-freiburg.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-427531234-1658468389-1386588848=:13468"
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <52A567A6.6000400@linux.vnet.ibm.com>
Sender: cpufreq-owner@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: Lan Tianyu <lantianyu1986@gmail.com>, ziegler@uni-freiburg.de, "Rafael J. Wysocki" <rjw@rjwysocki.net>, viresh kumar <viresh.kumar@linaro.org>, =?ISO-8859-15?Q?Bj=F8rn_Mork?= <bjorn@mork.no>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, martin.ziegler@math.uni-freiburg.de
List-Id: linux-pm@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---427531234-1658468389-1386588848=:13468
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

This works fine for cpu{1,2,3} after

  Revert "cpufreq: fix garbage kobjects on
  errors during suspend/resume"

  This reverts commit
  2167e2399dc5e69c62db56d933e9c8cbe107620a.

is applied to v3.13-rc3. There is no file=20
cpu0/online.


I can check the behaviour of v3.13-rc3 itself only tomorrow,
since I am travelling.

Regards
Martin

Am Mo 09 Dez 2013 12:18:00 CET schrieb Srivatsa S. Bhat:

> On 12/09/2013 08:29 AM, Lan Tianyu wrote:
>> 2013/12/5 Rafael J. Wysocki <rjw@rjwysocki.net>:
>>> On Wednesday, December 04, 2013 04:02:18 PM viresh kumar wrote:
>>>> On Tuesday 03 December 2013 04:44 PM, Bj=F8rn Mork wrote:
>>>>> This is effectively a revert of commit 5302c3fb2e62 ("cpufreq: Perfor=
m
>>>>> light-weight init/teardown during suspend/resume"), which enabled
>>>>> suspend/resume optimizations leaving the sysfs files in place.
> [...]
>>> I took the Bjorn's patch for 3.13 and this one I can queued up for 3.14=
,
>>> but for that I guess it should contain a revert of the change made by t=
he
>>> Bjorn's patch.
>>
>> This patch causes a s3 regression. Cc:Martin Ziegler
>> https://bugzilla.kernel.org/show_bug.cgi?id=3D66751
>>
>
> Hmm.. With Bjorn's patch applied, the cpufreq hotplug callback should bec=
ome
> identical to what happens during regular CPU hotplug. So is regular CPU
> hotplug also failing for you, Martin?
>
> You can do CPU hotplug by:
>
> CPU offline:
> echo 0 > /sys/devices/system/cpu/cpu<num>/online
>
> CPU online:
> echo 1 > /sys/devices/system/cpu/cpu<num>/online
>
>
> Bjorn's patch looks pretty innocuous to me.. I couldn't catch any obvious
> bug looking at the code. So answer to the above question should help us d=
ig
> deeper.
>
> Regards,
> Srivatsa S. Bhat
>
>
---427531234-1658468389-1386588848=:13468--
