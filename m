From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [BUG] sleeping function called from invalid context during resume
Date: Fri, 7 Jul 2006 20:21:55 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6ECF8BD@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: johnstul@us.ibm.com, linux-kernel@vger.kernel.org, pavel@suse.cz, linux-acpi@vger.kernel.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


>> >> I think we need to get rid of the acpi_in_resume hack
>> >> and use system_state != SYSTEM_RUNNING to address this.
>> >
>> >Well if hacks are OK it'd actually be reliable to do
>> >
>> >	/* comment goes here */
>> >	kmalloc(size, irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);
>> >
>> >because the irqs_disabled() thing happens for well-defined reasons. 
>> >Certainly that's better than looking at system_state (and I 
>> >don't think we
>> >leave SYSTEM_RUNNING during suspend/resume anyway).
>> 
>> If system_state != SYSTEM_RUNNING on resume, theen __might_sleep()
>> would not have spit out the dump_stack() above.
>> 
>> This is exactly like boot -- we are bringing up the system
>> and we need to configure interrupts, which runs AML,
>> which calls kmalloc in a variety of ways, all of which call
>> __might_sleep.
>> 
>> It seems simplest to have resume admit that it is like boot
>> and that the early allocations with interrupts off simply
>> must succeed or it is game-off.
>> 
>
>No, we shouldn't expand the use of system_state.  Code continues to be
>merged which uses it.  If we also merge code which enhances 
>its semantics then we're getting into quadratically-increasing
>nastiness rather than linearly-increasing.
>
>Callers should tell callees what to do.  Callees shouldn't be 
>peeking at globals to work out what to do.
>
>Lacking any other caller-passed indication, it would be much better for
>acpi to look at irqs_disabled().  That's effectively a task-local,
>cpu-local argument which was passed down to callees.  It's hacky - it's
>like the PF_foo flags.  But it's heaps better than having all 
>the kernel fight over the state of a global.

I didn't propose that kmalloc callers peek at system_state.
I proposed that system_state be set properly on resume
exactly like it is set on boot -- SYSTEM_RUNNING means
we are up with interrupts enabled.

Note that this issue is not specific to ACPI, any other code
that calls kmalloc during resume will hit __might_sleep().
This is taken care of by system_state in the case of boot
and the callers don't know anything about it -- resume
is the same case and should work the same way.

-Len
