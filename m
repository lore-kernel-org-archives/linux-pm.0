From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH -mm 3/3] PM: Improve handling of ACPI system
	state indicator (rev. 3)
Date: Wed, 29 Aug 2007 09:54:43 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A4031EFC32__19532.410198781$1188406538$gmane$org@orsmsx415.amr.corp.intel.com>
References: <200708272347.45438.rjw@sisk.pl> <200708272353.09380.rjw@sisk.pl>
	<B28E9812BAF6E2498B7EC5C427F293A4031EF65B@orsmsx415.amr.corp.intel.com>
	<200708290005.12323.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <200708290005.12323.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

No, it's not safe to run the AML interpreter with interrupts disabled.

I don't have any problem with introducing finer granularity enter/exit
sleep interfaces if they are required.

I would suggest that we rename things a bit however.

Currently:
acpi_enter_sleep_state_prep
acpi_enter_sleep_state_prep_late
acpi_enter_sleep_state

acpi_leave_sleep_state_prep
acpi_leave_sleep_state

I think we can truncate and clarify:

acpi_sleep_setup1
acpi_sleep_setup2
acpi_sleep

acpi_wake_setup1
acpi_wake


acpi_set_sleep_state_indicator:

I'm not sure if we have any external interfaces that simply execute a
control method, seems like overkill.

Please give me more information as to why _SSI needs to be moved (other
than executing it after _BFS)

Thanks,
Bob





-----Original Message-----
From: Rafael J. Wysocki [mailto:rjw@sisk.pl] 
Sent: Tuesday, August 28, 2007 3:05 PM
To: Moore, Robert
Cc: Andrew Morton; ACPI Devel Maling List; Len Brown; LKML; Pavel
Machek; pm list
Subject: Re: [PATCH -mm 3/3] PM: Improve handling of ACPI system state
indicator (rev. 3)

On Tuesday, 28 August 2007 21:57, Moore, Robert wrote:
> Since these changes appear to affect the ACPICA core in a fairly big
> way, I would like to see a short, concise description of each change
and
> why it is necessary.

All right.  I'll describe the changes made by the current version of the
patches, but please note that if it's safe to run the AML interpreter
with
IRQs disabled, it's better to do some of them in a different way.

1. Remove the execution of _GTS from acpi_enter_sleep_state_prep()

	acpi_enter_sleep_state_prep() is called before disabling the
nonboot
	CPUs and _GTS should be executed after that, according to the
spec.

2. Introduce acpi_enter_sleep_state_prep_late() that will execute _GTS

	Necessary because of 1.

3. Split acpi_leave_sleep_state() into two functions:
   acpi_leave_sleep_state_prep() and acpi_leave_sleep_state().

	acpi_leave_sleep_state_prep() contains the code that should be
executed
	before enabling the nonboot CPUs, most importantly the execution
of
	_BFS, and acpi_leave_sleep_state() contains the remaining code
(the
	enabling of GPEs, the execution of _WAK and the enabling of
power
	buttons)

4. Change the code ordering in acpi_leave_sleep_state_prep() (introduced
   in 3.) so that _SST is executed after _BFS

	According to the spec, _BFS should be the first ACPI method
executed
	after leaving a sleep state

5. Introduce acpi_set_sleep_state_indicator() that will execute _SST for
given
   ACPI sleep state

	Needed so that we can set the state indicator independently of
the
	other lower-level operations.

6. Remove the execution of _SST from acpi_leave_sleep_state()

	No longer needed, because we can use
acpi_set_sleep_state_indicator()
	to set the state indicator appropriately from higher level
routines.

The other changes affect only drivers/acpi/sleep/main.c and the files in
kernel/power .

Greetings,
Rafael
