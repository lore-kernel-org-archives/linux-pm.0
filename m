From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: System will not suspend with highest numbered CPU offline [REGRESSION][BISECTED]
Date: Sat, 5 Sep 2015 00:46:40 -0700
Message-ID: <001601d0e7af$01a22140$04e663c0$@net>
References: <001401d0e691$302127b0$90637710$@net>	<3237049.urJsZkC6Rf@vostro.rjw.lan>	<20150904144241.GJ29194@linux>	<000701d0e741$5933c580$0b9b5080$@net>	<CAJZ5v0iqX+Sh6rDNKW+Nm2hNnEnC7uvzhZ6ta9Qxc3Rs2CZPJg@mail.gmail.com>	<000e01d0e766$2f07dfb0$8d179f10$@net> <CAJZ5v0gvq5KF9jZobHFkXiAe=WfN=B=oSVt7o2ui-Wdx7_8Umg@mail.gmail.com> <000f01d0e783$6fe75cf0$4fb616d0$@net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta12.telus.net ([209.171.16.85]:44410 "EHLO cmta12.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750704AbbIEHqp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 5 Sep 2015 03:46:45 -0400
In-Reply-To: <000f01d0e783$6fe75cf0$4fb616d0$@net>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc: 'Viresh Kumar' <viresh.kumar@linaro.org>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Saravana Kannan' <skannan@codeaurora.org>, linux-pm@vger.kernel.org

On 2015.09.05 19:35 Doug Smythies wrote:
> On 2015.09.04 17:23 Rafael J. Wysocki wrote:
>> On Sat, Sep 5, 2015 at 1:05 AM, Doug Smythies <dsmythies@telus.net> wrote:
>>> On 2015.09.04 15:26 Rafael J. Wysocki wrote:
>>>> On Fri, Sep 4, 2015 at 8:41 PM, Doug Smythies <dsmythies@telus.net> wrote:
>>>>> On 2015.09.04 07:43 Viresh Kumar wrote:
>>>>>> On 04-09-15, 16:59, Rafael J. Wysocki wrote:
>>>>>>> On Thursday, September 03, 2015 02:40:43 PM Doug Smythies wrote:
>>>>>>>> As of, or about, Kernel 4.2RC1 if I take my highest numbered
>>>>>>>> CPU offline (7 in my case), the system will not suspend.

>>>> Hmm.
>>>> I suspect that your user space does something that fails during the pm-suspend.
>>>
>>> Are you saying that the patch might be O.K., but reveals
>>> and issue with pm-suspend that was always there?
>>
>> Or it breaks something that pm-suspend does before suspending.
>>
>> It would be good to know what it is. :-)

> While researching pm-utils bugs, I found reference to
> /var/log/pm-suspend.log, which I had not noticed before.
> Relevant extract attached.

> It is not clear to me why that echo line (there is only one)
> would fail.

The echo line fails because the related CPU is offline.
If the failed echo is the last pass through the loop,
then the script interprets the overall execution of
94cpufreq as a failure and aborts the suspend. If the
failed echo is not the last pass through the loop, then
the bad exit code gets overwritten with a good one before
the loop exits.

Since the loop is merely setting a temporary governor,
to test I just used performance mode anyway, and commented
out the echo. pm-suspend with CPU 7 offline then worked fine.

I have not yet gone back to any before the patch kernel
to determine why it used to work (it is late in my time zone).
However, I would have to assume that before the commit in
question, the echo worked even if the CPU was offline.

Could someone please confirm or deny the above conclusion.

The relevant code segment, with some added debug
echo stuff, from /usr/lib/pm-utils/sleep.d/94cpufreq 

hibernate_cpufreq()
{
  ( cd /sys/devices/system/cpu/
  for x in cpu[0-9]*; do
     # if cpufreq is a symlink, it is handled by another cpu. Skip.
     [ -L "$x/cpufreq" ] && continue
     gov="$x/cpufreq/scaling_governor"
     # if we do not have a scaling_governor file, skip.
     [ -f "$gov" ] || continue
     # if our temporary governor is not available, skip.
     grep -q "$TEMPORARY_CPUFREQ_GOVERNOR" \
     "$x/cpufreq/scaling_available_governors" || continue
     savestate "${x}_governor" < "$gov"
# I added the next 3 lines
     echo "$x"
     echo "$TEMPORARY_CPUFREQ_GOVERNOR"
     echo "$gov"
# For a test, do not do the echo, as I already set performance mode
#    echo "$TEMPORARY_CPUFREQ_GOVERNOR" > "$gov"
  done )
}


