From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpufreq: fix garbage kobj on errors during suspend/resume
Date: Mon, 09 Dec 2013 12:18:06 +0530
Message-ID: <52A567A6.6000400@linux.vnet.ibm.com>
References: <1386069272-9250-1-git-send-email-bjorn@mork.no> <529F04B2.7050303@linaro.org>	<2628468.jr1aJZyvPu@vostro.rjw.lan> <CAOLK0pxW_AjtGNwW2G8-1SpJbYs_GWQDLV=7XzPfDHRj6tCxQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAOLK0pxW_AjtGNwW2G8-1SpJbYs_GWQDLV=7XzPfDHRj6tCxQQ@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Lan Tianyu <lantianyu1986@gmail.com>, ziegler@uni-freiburg.de
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, viresh kumar <viresh.kumar@linaro.org>, =?ISO-8859-1?Q?Bj=F8rn_Mork?= <bjorn@mork.no>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

On 12/09/2013 08:29 AM, Lan Tianyu wrote:
> 2013/12/5 Rafael J. Wysocki <rjw@rjwysocki.net>:
>> On Wednesday, December 04, 2013 04:02:18 PM viresh kumar wrote:
>>> On Tuesday 03 December 2013 04:44 PM, Bj=F8rn Mork wrote:
>>>> This is effectively a revert of commit 5302c3fb2e62 ("cpufreq: Per=
form
>>>> light-weight init/teardown during suspend/resume"), which enabled
>>>> suspend/resume optimizations leaving the sysfs files in place.
[...]
>> I took the Bjorn's patch for 3.13 and this one I can queued up for 3=
=2E14,
>> but for that I guess it should contain a revert of the change made b=
y the
>> Bjorn's patch.
>=20
> This patch causes a s3 regression. Cc:Martin Ziegler
> https://bugzilla.kernel.org/show_bug.cgi?id=3D66751
>=20

Hmm.. With Bjorn's patch applied, the cpufreq hotplug callback should b=
ecome
identical to what happens during regular CPU hotplug. So is regular CPU
hotplug also failing for you, Martin?

You can do CPU hotplug by:

CPU offline:
echo 0 > /sys/devices/system/cpu/cpu<num>/online

CPU online:
echo 1 > /sys/devices/system/cpu/cpu<num>/online


Bjorn's patch looks pretty innocuous to me.. I couldn't catch any obvio=
us
bug looking at the code. So answer to the above question should help us=
 dig
deeper.

Regards,
Srivatsa S. Bhat

