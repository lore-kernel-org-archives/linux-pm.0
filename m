From: david@lang.hm
Subject: Re: Hibernation considerations
Date: Sun, 15 Jul 2007 16:49:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707151644270.25614@asgard.lang.hm>
References: <200707151433.34625.rjw@sisk.pl> <200707160047.28420.rjw@sisk.pl>
	<Pine.LNX.4.64.0707151538130.25614@asgard.lang.hm>
	<200707160122.09840.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707160122.09840.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>, Al Boldi <a1426z@gawab.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Mon, 16 Jul 2007, Rafael J. Wysocki wrote:

> On Monday, 16 July 2007 00:42, david@lang.hm wrote:
>> On Mon, 16 Jul 2007, Rafael J. Wysocki wrote:
>>
>>> On Sunday, 15 July 2007 22:13, david@lang.hm wrote:
>>>> On Sun, 15 Jul 2007, Rafael J. Wysocki wrote:
>>>>
>>>>>    The ACPI specification requires us to invoke some global ACPI methods
>>>>>    during the hibernation and during the restore.  Moreover, the ordering of
>>>>>    code related to these ACPI methods may not be arbitrary (eg. some of
>>>>>    them have to be executed after devices are put into low power states etc.).
>>>>
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
>
> No, it sort of works as usual, but after the restore the platform is not in the
> correct state.

this is not hibernate as I and many others are thinking of it.

hibernate as we are thinking would work on basicly any hardware, including 
things with no ACPI or power savings support. and the system could be in 
hibernate mode for any time period.

for that matter, after a system is put into hibernate mode the system 
could be completely disassembled and any components replaced and the 
system would work after a resume (assuming you still have access to the 
suspend image)

>> remember that the system may run a different OS between the hibernate and
>> the resume, makeing any assumptions about what state the hardware is in
>> when you start the resume is a problem.
>
> True, that's problematic.

putting it mildly.

David Lang
