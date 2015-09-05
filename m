From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: System will not suspend with highest numbered CPU offline [REGRESSION][BISECTED]
Date: Fri, 4 Sep 2015 19:34:48 -0700
Message-ID: <000f01d0e783$6fe75cf0$4fb616d0$@net>
References: <001401d0e691$302127b0$90637710$@net>	<3237049.urJsZkC6Rf@vostro.rjw.lan>	<20150904144241.GJ29194@linux>	<000701d0e741$5933c580$0b9b5080$@net>	<CAJZ5v0iqX+Sh6rDNKW+Nm2hNnEnC7uvzhZ6ta9Qxc3Rs2CZPJg@mail.gmail.com>	<000e01d0e766$2f07dfb0$8d179f10$@net> <CAJZ5v0gvq5KF9jZobHFkXiAe=WfN=B=oSVt7o2ui-Wdx7_8Umg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0010_01D0E748.C38884F0"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta6.telus.net ([209.171.16.79]:60794 "EHLO cmta6.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760402AbbIECex (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Sep 2015 22:34:53 -0400
In-Reply-To: <CAJZ5v0gvq5KF9jZobHFkXiAe=WfN=B=oSVt7o2ui-Wdx7_8Umg@mail.gmail.com>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc: 'Viresh Kumar' <viresh.kumar@linaro.org>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Saravana Kannan' <skannan@codeaurora.org>, linux-pm@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0010_01D0E748.C38884F0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit

On 2015.09.04 17:23 Rafael J. Wysocki wrote:
> On Sat, Sep 5, 2015 at 1:05 AM, Doug Smythies <dsmythies@telus.net> wrote:
>> On 2015.09.04 15:26 Rafael J. Wysocki wrote:
>>> On Fri, Sep 4, 2015 at 8:41 PM, Doug Smythies <dsmythies@telus.net> wrote:
>>>> On 2015.09.04 07:43 Viresh Kumar wrote:
>>>>> On 04-09-15, 16:59, Rafael J. Wysocki wrote:
>>>>>> On Thursday, September 03, 2015 02:40:43 PM Doug Smythies wrote:
>>>>>>> As of, or about, Kernel 4.2RC1 if I take my highest numbered
>>>>>>> CPU offline (7 in my case), the system will not suspend.
>>>
>>>>> @Doug: Can you please enable DEBUG for cpufreq with this:
>>>>>
>>>>> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
>>>>> index 9fde14544ead..c09945aa7f17 100644
>>>>> --- a/drivers/cpufreq/Makefile
>>>>> +++ b/drivers/cpufreq/Makefile
>>>>> @@ -1,3 +1,4 @@
>>>>> +subdir-ccflags-y  := -DDEBUG
>>>>> # CPUfreq core
>>>>> obj-$(CONFIG_CPU_FREQ)                 += cpufreq.o freq_table.o
>>>>>
>>>>>
>>>>> And give us the outputs of both successful and unsuccessful logs?
>>>>
>>>> Edited /var/log/kern.log attached (might get stripped for
>>>> on-list e-mail deliveries)
>>
>>> Hmm.
>>> I suspect that your user space does something that fails during the pm-suspend.
>>
>> Are you saying that the patch might be O.K., but reveals
>> and issue with pm-suspend that was always there?
>
> Or it breaks something that pm-suspend does before suspending.
>
> It would be good to know what it is. :-)

While researching pm-utils bugs, I found reference to
/var/log/pm-suspend.log, which I had not noticed before.
Relevant extract attached.

It is not clear to me why that echo line (there is only one)
would fail.

> The "setting new policy for" messages in your log are from
> cpufreq_set_policy() and the last thing printed before pm-suspend
> exits in the failing case is before calling
> cpufreq_driver->setpolicy().
>
> I guess we need to focus on that one, will send you a debug patch shortly.
>
>>> Instead of invoking the pm-suspend command, can you simply do (as root)
>>> # echo mem > /sys/power/state
>>> and see if that behaves in the same way?
>>
>> With CPU 7 offline, that method seems to suspend just fine.
>> I did not check any other scenarios.
>
> OK
>
> I'm now suspecting that the change in question might break something
> in intel_pstate which causes ->setpolicy() to fail for the last online
> CPU.

While, by far, most of my work on this has been done using the intel_pstate
scaling driver, I have also tested using the acpi-cpufreq scaling driver,
with the same results.

> Can you try to offline CPU7 and try to play with min and max for CPU6?

Yes. I did, on a kernel with your intel_pstate.c patch from your
subsequent e-mail. I didn't notice any problem, but maybe didn't
do it correctly to manifest the issue.
small /var/log/kern.log segment attached.

... Doug


------=_NextPart_000_0010_01D0E748.C38884F0
Content-Type: text/plain;
	name="pm_log.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="pm_log.txt"

Running hook /usr/lib/pm-utils/sleep.d/60_wpa_supplicant suspend suspend:=0A=
Failed to connect to non-global ctrl_ifname: (null)  error: No such file =
or directory=0A=
/usr/lib/pm-utils/sleep.d/60_wpa_supplicant suspend suspend: success.=0A=
=0A=
Running hook /usr/lib/pm-utils/sleep.d/75modules suspend suspend:=0A=
/usr/lib/pm-utils/sleep.d/75modules suspend suspend: not applicable.=0A=
=0A=
Running hook /usr/lib/pm-utils/sleep.d/90clock suspend suspend:=0A=
/usr/lib/pm-utils/sleep.d/90clock suspend suspend: not applicable.=0A=
=0A=
Running hook /usr/lib/pm-utils/sleep.d/94cpufreq suspend suspend:=0A=
sh: echo: I/O error=0A=
/usr/lib/pm-utils/sleep.d/94cpufreq suspend suspend: Returned exit code =
1.=0A=
=0A=
Fri Sep  4 18:25:00 PDT 2015: Inhibit found, will not perform suspend=0A=
Fri Sep  4 18:25:00 PDT 2015: Running hooks for resume=0A=
Running hook /usr/lib/pm-utils/sleep.d/90clock resume suspend:=0A=
/usr/lib/pm-utils/sleep.d/90clock resume suspend: not applicable.=0A=
=0A=
Running hook /usr/lib/pm-utils/sleep.d/75modules resume suspend:=0A=
Reloaded unloaded modules.=0A=
/usr/lib/pm-utils/sleep.d/75modules resume suspend: success.=0A=

------=_NextPart_000_0010_01D0E748.C38884F0
Content-Type: text/plain;
	name="log_2.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="log_2.txt"

Sep  4 19:14:31 s15 kernel: [  115.529407] cpufreq: =
__cpufreq_remove_dev_prepare: unregistering CPU 7=0A=
Sep  4 19:14:31 s15 kernel: [  115.529413] intel_pstate: CPU 7 exiting=0A=
Sep  4 19:14:31 s15 kernel: [  115.542754] smpboot: CPU 7 is now offline=0A=
Sep  4 19:20:19 s15 kernel: [  463.426743] cpufreq: setting new policy =
for CPU 6: 1600000 - 2400000 kHz=0A=
Sep  4 19:20:19 s15 kernel: [  463.426750] cpufreq: new min and max =
freqs are 1600000 - 2400000 kHz=0A=
Sep  4 19:20:19 s15 kernel: [  463.426752] cpufreq: setting range=0A=
Sep  4 19:23:05 s15 kernel: [  628.598506] cpufreq: setting new policy =
for CPU 6: 1600000 - 2200000 kHz=0A=
Sep  4 19:23:05 s15 kernel: [  628.598511] cpufreq: new min and max =
freqs are 1600000 - 2200000 kHz=0A=
Sep  4 19:23:05 s15 kernel: [  628.598513] cpufreq: setting range=0A=

------=_NextPart_000_0010_01D0E748.C38884F0--

