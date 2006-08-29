From: Matthew Locke <matt@nomadgs.com>
Subject: Re: PowerOP, Intro 0/3
Date: Tue, 29 Aug 2006 00:28:21 -0700
Message-ID: <dfc4e6d130c1725cbac211fa940a4d5d@nomadgs.com>
References: <ADE4D9DBCFC3A345AAA95C195F62B6DD01A948CF@de01exm64.ds.mot.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <ADE4D9DBCFC3A345AAA95C195F62B6DD01A948CF@de01exm64.ds.mot.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Preece Scott-PREECE <scott.preece@motorola.com>
Cc: pm list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Scott, Pavel,


On Aug 28, 2006, at 9:59 AM, Preece Scott-PREECE wrote:

> Hi, Matt,
>
> Can you (and David, if his thoughts are different) clarify for me the
> scope of the "arbitrary subset of power parameters" managed by PowerOP?

Scott does a pretty good job of clarifying, so my comments are below.

>
> I had visualized this as managing CPU speed, voltage, and some
> associated clock and bus speeds and voltages, as opposed to "devices",
> though there would be some interaction with devices indirectly through
> dependencies on specific speeds and voltages. I put "devices" in quotes
> because it's a somewhat ambiguous - it covers both things that you =

> would
> normally think of as devices (like disk drives) and things that are
> modeled by device drivers but are actually just part of the system
> infrastructure (like the power management IC).
>
> Put another way, I had been thinking of PowerOP as managing =

> system-level
> power control, but that device-level controls would still be layered on
> that. Pavel's comments suggest that he thinks it would be managing
> devices as well (thereby creating a state explosion).

> What model did you have in mind?
>

Basically, PowerOP is a building block for managing system-level power =

control as you describe.  Its for controlling bus, clocks, and voltages =

that affect the entire system.  Devices are not controlled directly by =

PowerOP.   Device state should be managed by the devices themselves and =

some other higher level software.  The connection between devices and =

powerop is not device state control; it is notification and =

constraints.

PowerOP does not automatically lead to an explosion of states/points.  =

As you can see from the cpufreq patches, PowerOP provides the same =

number points currently available in cpufreq.  It gives the kernel =

developer and/or system designer the choice how to define the operating =

points.

> Thanks,
> scott
>
>> -----Original Message-----
>> From: linux-pm-bounces@lists.osdl.org
>> [mailto:linux-pm-bounces@lists.osdl.org] On Behalf Of Matthew Locke
>> Sent: Monday, August 28, 2006 2:38 AM
>> To: Pavel Machek
>> Cc: pm list
>> Subject: Re: [linux-pm] PowerOP, Intro 0/3
>>
>>
>> On Aug 26, 2006, at 1:38 PM, Pavel Machek wrote:
>>
>>> Hi!
>>>
>>>>>> PowerOP Core upper layer interface provides the following
>>>>>> capabilities:
>>>>>> - to register an operating point by passing an
>> idenificator of the
>>>>>> point represened by a string and arbitrary substet of power
>>>>>> paremeters available on a certain platform by a string
>> (parameter
>>>>>> name) and value pairs.
>>>>>> - to unregister operating point by name
>>>>>> - to set operating point by name
>>>>>> - to get values of arbitrary subset of platform power parameters
>>>>>> associated this  a point (point is passed by name or NULL to get
>>>>>> current parameter values from hw)
>>>>>
>>>>> I do not think this can work in notebook world, sorry.
>>>>> You'll just get
>>>>> way too many operating points.
>>>> The only feature for notebook world currently presented in
>> the kernel
>>>> is CPUFreq. CPUFreq PowerOP integration
>>>
>>> Actually no. In the notebook world, we do cpufreq,
>> selective powerdown
>>> of devices (/sys/**/power/state), and suspend-to-ram/disk
>> (not sure if
>>> it applies to you, but at least some powerop versions wanted to
>>> replace that).
>>
>>
>> The main point is that you won't get too many operating
>> points.  You will get the number of operating points the x86
>> port of PowerOP chooses to have.  In the cpufreq/PowerOP
>> integration patches you get the same
>> number of operating points you have today in cpufreq.   We query ACPI
>> for the list or use the hardcoded table.  Also, if we provide
>> a userspace API for creating operating points,  distro's can
>> create additional operating points that make sense for some
>> specific use cases they would like to optimize around.
>>
>>
>> Matt
>>
>> _______________________________________________
>> linux-pm mailing list
>> linux-pm@lists.osdl.org
>> https://lists.osdl.org/mailman/listinfo/linux-pm
>>
>
