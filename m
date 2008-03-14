From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH] cpuidle: avoid singing capacitors
Date: Fri, 14 Mar 2008 14:15:46 -0700
Message-ID: <924EFEDD5F540B4284297C4DC59F3DEEB34783__27171.1472109475$1205529636$gmane$org@orsmsx423.amr.corp.intel.com>
References: <Pine.LNX.4.44L0.0803031804330.8280-100000@iolanthe.rowland.org><20080310100008.GA9520@elf.ucw.cz><20080310134915.45ae7446@mjolnir.drzeus.cx><200803121511.17389.lenb@kernel.org><20080313173437.5f00f70e@mjolnir.drzeus.cx>
	<20080314204041.6e376568@mjolnir.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <20080314204041.6e376568@mjolnir.drzeus.cx>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pierre Ossman <drzeus-list@drzeus.cx>, Len Brown <lenb@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Adam Belay <abelay@novell.com>, Andi Kleen <andi@firstfloor.org>, Lee Revell <rlrevell@joe-job.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

 

>-----Original Message-----
>From: Pierre Ossman [mailto:drzeus-list@drzeus.cx] 
>Sent: Friday, March 14, 2008 12:41 PM
>To: Len Brown; Pallipadi, Venkatesh
>Cc: linux-pm@lists.linux-foundation.org; Pavel Machek; LKML; 
>Adam Belay; Andi Kleen; Lee Revell
>Subject: Re: [linux-pm] [PATCH] cpuidle: avoid singing capacitors
>
>On Thu, 13 Mar 2008 17:34:37 +0100
>Pierre Ossman <drzeus-list@drzeus.cx> wrote:
>
>> On Wed, 12 Mar 2008 15:11:17 -0400
>> Len Brown <lenb@kernel.org> wrote:
>> 
>> > 
>> > You'll see "desc" change if ACPI pulls a _CST change on you.
>> > 
>> 
>> It does not. But my C3 desc looks like this:
>> 
>> state3/desc:ACPI FFH INTEL MWAIT 0x50
>> 
>
>I must have done something wrong. I now see a switch between C6 and C3
>when I play with the AC cord.
>

BIOSes do that on some platforms, exposing deeper C-states on battery.

>On that theme, I've tested fiddling with the real C-states. I've added
>a new max_hwcstate that makes ACPI downgrade MWAIT hints. I also made
>some odd discoveries:
>
>C3: More or less completely silent (I haven't tested it in a really
>quiet environment yet).
>C4: Constant noise
>C5: Constant noise
>C6: Intermittent noise
>
>When I say constant, I mean that the noise is not generated as a result
>of switching between modes (to any extent I can see at least). The
>average time spent in C3 (as reported by Powertop) is over 200 ms. So
>that would give a frequency of around 5 Hz, not a consistent tone of
>several kHz.
>
>Here's said patch. Please comment as I hope this can be merged:
>
>diff --git a/arch/x86/kernel/acpi/cstate.c 
>b/arch/x86/kernel/acpi/cstate.c
>index 8ca3557..389ea8b 100644
>--- a/arch/x86/kernel/acpi/cstate.c
>+++ b/arch/x86/kernel/acpi/cstate.c
>@@ -47,6 +47,9 @@ EXPORT_SYMBOL(acpi_processor_power_init_bm_check);
> 
> /* The code below handles cstate entry with monitor-mwait 
>pair on Intel*/
> 
>+static unsigned int max_hwcstate __read_mostly = -1;
>+module_param(max_hwcstate, uint, 0644);
>+
> struct cstate_entry {
> 	struct {
> 		unsigned int eax;
>@@ -80,6 +83,7 @@ int acpi_processor_ffh_cstate_probe(unsigned int cpu,
> 	unsigned int edx_part;
> 	unsigned int cstate_type; /* C-state type and not ACPI 
>C-state type */
> 	unsigned int num_cstate_subtype;
>+	unsigned int hint;
> 
> 	if (!cpu_cstate_entry || c->cpuid_level < CPUID_MWAIT_LEAF )
> 		return -1;
>@@ -100,16 +104,40 @@ int 
>acpi_processor_ffh_cstate_probe(unsigned int cpu,
> 	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &edx);
> 
> 	/* Check whether this particular cx_type (in CST) is 
>supported or not */
>-	cstate_type = (cx->address >> MWAIT_SUBSTATE_SIZE) + 1;
>-	edx_part = edx >> (cstate_type * MWAIT_SUBSTATE_SIZE);
>-	num_cstate_subtype = edx_part & MWAIT_SUBSTATE_MASK;
>+	hint = cx->address;
>+	for (;;) {
>+		/* Compute main C-state */
>+		cstate_type = (hint >> MWAIT_SUBSTATE_SIZE) + 1;
>+
>+		/* Determine number of sub-states for this C-state */
>+		edx_part = edx >> (cstate_type * MWAIT_SUBSTATE_SIZE);
>+		num_cstate_subtype = edx_part & MWAIT_SUBSTATE_MASK;
>+
>+		/* Check if it's within constraints, and supported */
>+		if ((cstate_type > max_hwcstate) ||
>+			(num_cstate_subtype <=
>+				(hint & MWAIT_SUBSTATE_MASK))) {
>+			/* Move down a C-state and drop sub-state */

Why go only one C-state down. Why not directly drop to max_hwcstate? We
don't need to loop through that way.

There are few other concerns which make me feel that the patch will be
not as simple as this.
1) BIOS may already be exporting the lower C-states as separate states.
In which case we just have to ignore this deep C-state and return. I
mean, on your system if BIOS exports C1, C3 and C6 hardware C-states and
you give max_hwcstate as C3, then we don't want to have C1, C3 and C3 in
our list.

2) On same lines the other information in ACPI like (low power of 100
and higher latency for C6 on your system) corresponds to hardware C6
state. If we change the hardware C-state here to C3, then continue to
use latency info from ACPI for hw C6, that may lead to inefficient state
selection in the governor. Also, ther are assumptions related DMA,
lapic, TSC etc in upper level ACPI based on "ACPI C-state" and changing
underlying hardware C-state to C1 for example will change some of those
behavior.


Thanks,
Venki
