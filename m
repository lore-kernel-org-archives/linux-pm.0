From: david@lang.hm
Subject: Re: Hibernation considerations
Date: Sun, 15 Jul 2007 16:41:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707151633240.25614__4681.78228843517$1184543381$gmane$org@asgard.lang.hm>
References: <Pine.LNX.4.44L0.0707151914450.28934-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707151914450.28934-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: LKML <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>, Al Boldi <a1426z@gawab.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Sun, 15 Jul 2007, Alan Stern wrote:

> On Sun, 15 Jul 2007 david@lang.hm wrote:
>
>>>> for a pure hibernate mode, you will be powering off the box after saving
>>>> the suspend image. why are there any special ACPI modes involved?
>>>
>>> Because, for example, on my machine the status of power supply (present
>>> vs not present) is not updated correctly after the restore if ACPI callbacks
>>> aren't used during the hibernation.  That's just experience and it's in line
>>> with the ACPI spec.
>>
>> so if a machine is actually powered off the /dev/suspend process won't
>> work?
>>
>> remember that the system may run a different OS between the hibernate and
>> the resume, makeing any assumptions about what state the hardware is in
>> when you start the resume is a problem.
>
> As I understand it, running a different OS between the hibernate and
> the resume would violate the ACPI spec.

then we need a third mode of operation.

mode 1: Suspend-to-ram

   the system is paused and put into a low-power mode but data remains in 
memory and the system stays awake enough to keep the memory refreshed.

mode 2: new

   the system is paused, data is stored to permanent media, and the system 
is put into a ultra-low power mode.

mode 3: hibernate

   the system is paused, data is stored to permanent media, and the system 
is powered off

with mode 3 there are no requirements or limitations about what can be 
done with the hardware before a resume (the resume could even take place 
on a different piece of identical hardware)

mode 2 could be what you are talking about doing, although I don't see any 
advantage of creating it in additon to mode 3, it doesn't use any less 
power and it locks the system so that it can't be used for anything else 
in the meantime. I guess if it was significantly faster to do then mode 3 
there may be _some_ reason to consider it, but I don't see the speed 
difference.

David Lang
