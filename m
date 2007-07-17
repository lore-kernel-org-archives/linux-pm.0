From: david@lang.hm
Subject: Re: Hibernation considerations
Date: Mon, 16 Jul 2007 21:28:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707162119500.19248@asgard.lang.hm>
References: <200707151433.34625.rjw@sisk.pl> <200707161406.28539.rjw@sisk.pl>
	<20070716123849.GC14212@grifter.jdc.home>
	<200707161729.16440.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707161729.16440.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jim Crilly <jim@why.dont.jablowme.net>, LKML <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>, Al Boldi <a1426z@gawab.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Mon, 16 Jul 2007, Rafael J. Wysocki wrote:

> On Monday, 16 July 2007 14:38, Jim Crilly wrote:
>> On 07/16/07 02:06:27PM +0200, Rafael J. Wysocki wrote:
>>> On Monday, 16 July 2007 01:49, david@lang.hm wrote:
>>>> On Mon, 16 Jul 2007, Rafael J. Wysocki wrote:
>>>>
>>>>> On Monday, 16 July 2007 00:42, david@lang.hm wrote:
>>>>>> On Mon, 16 Jul 2007, Rafael J. Wysocki wrote:
>>>>>>
>>>>>>> On Sunday, 15 July 2007 22:13, david@lang.hm wrote:
>>>>>>>> On Sun, 15 Jul 2007, Rafael J. Wysocki wrote:
>>>>>>>>
>>>>>>>>>    The ACPI specification requires us to invoke some global ACPI methods
>>>>>>>>>    during the hibernation and during the restore.  Moreover, the ordering of
>>>>>>>>>    code related to these ACPI methods may not be arbitrary (eg. some of
>>>>>>>>>    them have to be executed after devices are put into low power states etc.).
>>>>>>>>
>>>>>>>> for a pure hibernate mode, you will be powering off the box after saving
>>>>>>>> the suspend image. why are there any special ACPI modes involved?
>>>>>>>
>>>>>>> Because, for example, on my machine the status of power supply (present
>>>>>>> vs not present) is not updated correctly after the restore if ACPI callbacks
>>>>>>> aren't used during the hibernation.  That's just experience and it's in line
>>>>>>> with the ACPI spec.
>>>>>>
>>>>>> so if a machine is actually powered off the /dev/suspend process won't
>>>>>> work?
>>>>>
>>>>> No, it sort of works as usual, but after the restore the platform is not in the
>>>>> correct state.
>>>>
>>>> this is not hibernate as I and many others are thinking of it.
>>>>
>>>> hibernate as we are thinking would work on basicly any hardware, including
>>>> things with no ACPI or power savings support. and the system could be in
>>>> hibernate mode for any time period.
>>>>
>>>> for that matter, after a system is put into hibernate mode the system
>>>> could be completely disassembled and any components replaced and the
>>>> system would work after a resume (assuming you still have access to the
>>>> suspend image)
>>>
>>> Well, this is not how ACPI defines the S4 sleep state.  If the system is in
>>> S4, that corresponds to our hibernation, you are _not_ allowed to disassemble
>>> it.
>>>
>>> I've just done an experiment on my test desktop.  I had enabled suspend support
>>> in the CMOS setup and afterwards I made Linux hibernate in the "platform" mode.
>>> Then, when the system was powred on, the BIOS showed me a nice "Resume from
>>> hibernation" screen that is not normally displayed during boot.  This clearly
>>> means that some information has been preserved by the platform across the
>>> hibernate/restore cycle.  We are supposed to handle that.
>>>
>>
>> What I believe he's getting at is that Linux hibernation shouldn't be tied
>> to any ACPI states. Yes, when available and working most people will want
>> to enter ACPI S4 but we should still have the option of doing a normal
>> poweroff. With the latter method it would look just like regular power off/on
>> cycle to the firmware. And that would definitely be useful for things like
>> working around buggy ACPI implementations or supporting platforms that don't
>> do ACPI at all. That is the difference between the platform and shutdown
>> options in /sys/power/disk, isn't it?
>
> Yes, but this is not my point.
>
> The point is that there are systems that _require_ the ACPI handling to work
> correctly after the restore and we need to that _that_ into consideration.
>
> IOW, there are poeple for whom the non-ACPI framework won't work as expected.

why would the type of hibernate that I'm talking about (power off, not S4 
mode) not work on a box that has ACPI?

you are saying that it wouldn't work right after a restore, but that's 
only if the restored image is expecting to have it's devices in ACPI sleep 
modes. my answer is "don't do that then" S4 mode does not save power 
compared to powering off, and when doing a hibernate you should be 
prepared to run out of battery before you wake up, which would then look 
like a power-on

the S4 mode sounds like a deeper version of suspend-to-ram, with all of 
the limitations of STR becouse you still require power continuously and 
must remain in complete control of the machine.

if you want to do a suspend to S4 mode, go for it, but we need to have a 
different name for that then for the suspend-to-disk-and-poer-off mode 
that I thought was hibernate

David Lang
