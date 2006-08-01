From: Matthew Locke <mlocke@embeddedalley.com>
Subject: Re: PowerOp Design and working patch
Date: Tue, 1 Aug 2006 03:09:46 -0700
Message-ID: <a4209ca07b26444cc11cf6471986e7cf@embeddedalley.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Resent-To: david singleton <dsingleton@mvista.com>
Resent-Message-Id: <215c230e2979117fd14d83ea2fd83054@embeddedalley.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: david singleton <dsingleton@mvista.com>
Cc: David Singleton <daviado@gmail.com>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


On Jul 31, 2006, at 5:59 PM, david singleton wrote:

>
> On Jul 30, 2006, at 4:02 AM, Vitaly Wool wrote:
>
>> David,
>>
>> On 7/30/06, david singleton <dsingleton@mvista.com> wrote:
>>
>>> That's one of the simple parts of the concept.  There aren't any
>>> runtime operating
>>> point creation.  It's one of the things I like best about cpufreq,
>>> the
>>> frequency
>>> and voltages are taken from the hardware vendor data sheet and
>>> validated.
>>>
>>> The user just gets to use the operating points supported by the
>>> system,
>>> not
>>> choose the frequency or voltage to transition to.
>>>
>>> By just presenting the supported operating points to the user it
>>> removes the
>>> need for new APIs.  The user just reads the supported operating =

>>> points
>>> and decides the best use of the supported operating points.
>>
>> I see this approach as fundamentally wrong at least because it will
>> produce very long and hard to manage lists of operating points.
>> Suppose you have 20 hardware vendor approved core CPU frequency
>> values, 3 possible voltage values and 10 approved DSP CPU frequency
>> values (which are derived from the other PLL). Not too impossible is
>> that almost all combinations are available which makes is almost 600
>> operating points. I find it absolutely unreal that anyone enters all
>> that stuff without mistakes; managing those lists/searching thru them
>> will take significant time which will slow down the state transitions;
>> and, finally, it's gonna increase the kernel footprint  quite a bit.
>
> Actually in practice there aren't that many supported operating
> points, even on the hardware you and I are familiar with.  I've yet
> to construct a case where there are more than 16 to 20
> operating points.

Its not the number of operating points driving the need for run time =

creation.  Please read the thread that took place early last week on =

this topic.  Start from my post here: =

http://lists.osdl.org/pipermail/linux-pm/2006-July/003065.html and read =

backwards.

Its really the embedded device development and silicon vendor model =

driving it.  Run time creation is required and enabling run time =

creation doesn't prevent some architectures/board ports from hard =

coding their points.

>
> And the Linux device model allows the system to be set at
> a particular operating point and then suspending the LCD
> or unused USB if so desired.  So the combination flexibility
> is still available.
>
> If there were 600 supported operating points that would be a
> very good reason to use PowerOp.   I'm not sure I'd want
> the user passing all the frequencies, voltages, clock
> divisor and clock multiplier for all those operating points.

Well, no one is suggesting a user define and install that info.  =

Operating point creation will be done by someone who understands the =

system (system designer) regardless of the method used to get the =

operating points in the kernel.

>
> List manipulation takes place at compile time and list traversal
> is simple.  If a powerop were to become a kobject management
> and traversal would still be simple.
>
> The foot print actually shrinks if you take into account all the
> class, policy and governor code that wouldn't be needed if
> all supported states were simple operating points.
>
>>
>> It looks to me that the concept that the kernel can implement
>> rules/restrictions for operating points but shouldn't define them with
>> possible exception for the most essential ones far better suits both
>> embedded and non-embedded use cases.
>
> CPUFREQ shows that it can, and I believe should, define the operating
> points the system supports.  CPUFREQ does NOT let the user pass
> frequency or voltage values into the kernel.  It shows the hardware
> vendor certified and validated frequencies and voltages.
>
> I really like that concept.  It simplifies things greatly.
>
>>
>>>> 2) interface (kernel as well as userspace(sysfs)) for the rest of
>>> power
>>>>    parameters except cpu voltage and frequency
>>>
>>>
>>> The /sys/power/supported_states file shows the supported operating
>>> points
>>> and their parameters.
>>>
>>> The platform specific information is hidden through the md_data
>>> pointer,
>>> which in the case of embedded systems with complex clocking schemes,
>>> contains the clock divisor and multiplier information that the system
>>> needs
>>> to perform frequency and voltage scaling and clock manipulation.
>>>
>>> The machine dependent portion of a centrino operating point
>>> is only the perfctl msr bits for each frequency/voltage.  For
>>> a system with 5 power domains and various clocks the
>>> machine dependent portion contains the whole array
>>> of information for the different power domains and their clocks.
>>
>> Basically I don't see too much sense in your definition of
>> PM_FREQ_CHANGE and PM_VOLT_CHANGE. The latter one just isn't used
>> anywhere although the voltage differs between the operating points for
>> your centrino example. And it's quite a common thing when frequency
>> and voltage are changed within the same transition; so those either
>> should be bitfields or something like PM_STATE_CHANGE.
>
>
> The example patch isn't provided to show how it should be implemented.
>
> I've added a separate PowerOp state of PM_VOLT_CHANGE for
> hardware that may be changing states by changing a voltage rather
> than having the voltage changed as a side effect of changing the
> frequency explicitly.
>
>>
>>>>
>>>> 3) per platform nature of an operating point rather than per
>>>>    a pm control layer (cpufreq for ex.):
>>>>    - you have cpu freq and voltage defined in common code
>>>>       while it's still possible that on a certain platform one would
>>>>       not be interested in control of these parameters
>>>
>>> Correct, but on all of the hardware with which I'm familiar cpu
>>> frequency
>>> and voltage are common components to power management.
>>
>> I do agree, but there might be different voltages and different CPU
>> frequencies within the same SoC, so it will mean that you separate,
>> say, two CPU frequencies between common code and SoC-specific code.
>> Maybe it's still the way to go, but it makes things quite complicated
>> to understand from scratch.
>>
>
> After digging through all the PM,  CPUFREQ and Dynamic Power Management
> code it became apparent that when they get down to touching hardware
> they are just dealing with an operating point.  And they all change =

> from
> one opeating point to another in the same manner.
>
> Once you view all the states a system can be in as an operating point,
> wether
> its a suspend or frequency change,  things get much simpler.


> And
>
> David
>
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/linux-pm
>
