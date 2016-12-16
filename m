From: Mason <slash.tmp@free.fr>
Subject: Re: Linux fails to start secondary cores when system resumes from
 Suspend-to-RAM
Date: Fri, 16 Dec 2016 08:25:23 +0100
Message-ID: <8c3c6592-1e9a-10d3-2a89-c22a2a23cf4b@free.fr>
References: <d4db03ce-80fc-2968-c5c2-84f79272ce8d@free.fr>
 <CADjb_WQ8ZTtcXYQ_3iobLCW7+rnG8FqyFQ1E47AZVGxP0JyB0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CADjb_WQ8ZTtcXYQ_3iobLCW7+rnG8FqyFQ1E47AZVGxP0JyB0w@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Yu Chen <yu.chen.surf@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Len Brown <len.brown@intel.com>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, linux-pm <linux-pm@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gambier <thomas_gambier@sigmadesigns.com>, Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>, Sebastian Frias <sf84@laposte.net>, Robin Murphy <robin.murphy@arm.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 16/12/2016 06:14, Yu Chen wrote:

> On Thu, Dec 15, 2016 at 11:18 PM, Mason wrote:
>
>> I'm playing with suspend-to-RAM on the tango platform:
>>
>>   http://lxr.free-electrons.com/source/arch/arm/mach-tango/platsmp.c
>>
>> When the system is suspended, the CPU is completely powered down
>> (receives no power whatsoever). When the system receives a wake-up
>> event, the CPU is powered up, and starts up exactly the same way
>> as for a cold boot (I think).
>>
>> However, while Linux successfully starts the secondary cores when
>> the system first boots, it fails when the system resumes from "S3".
>>
>> I added printascii() calls inside secondary_start_kernel() and I can
>> see that the following instruction are "properly" run:
>>
>>         cpu_switch_mm(mm->pgd, mm);
>>         local_flush_bp_all();
>>         enter_lazy_tlb(mm, current);
>>
>> but it seems local_flush_tlb_all(); never returns... :-(
>>
>>   http://lxr.free-electrons.com/source/arch/arm/include/asm/tlbflush.h#L332
>>
>>
>> Looking more closely at that function, it seems to be failing in:
>>
>>         tlb_op(TLB_V7_UIS_FULL, "c8, c7, 0", zero);
>>
>> (meaning: I get a log before, but not after)
>>
>> On my system, tlb_op(TLB_V7_UIS_FULL, "c8, c7, 0", zero);
>> resolves to:
>>
>> c010ce18:       e3170602        tst     r7, #2097152    ; 0x200000
>> c010ce1c:       1e086f17        mcrne   15, 0, r6, cr8, cr7, {0}
>>
>> What could be happening?
>> Can a core "hang" on this instruction?
>> Can a core "crash" on this instruction (meaning, an exception
>> is raised, and the core loops inside the exception code without
>> Linux noticing... that seems unlikely)
>>
>> I'm stumped. Could someone throw me a clue?
>
> try online/offline the nonboot CPUs via
> /sys/devices/system/cpu/cpuX/online

offline + online secondary core works.

Note: all cores are in the same power domain, so even if all
secondary cores are offline, the CPU block remains powered up
(secondary cores are just held in reset, or spinning in WFI,
depending on the firmware version).

When the system is suspended, the CPU block (as well as 99%
of the system) is powered down. Thus, upon resume, all cores
will run the boot sequence (again).

I'm guessing that something goes wrong during this second
boot sequence. Could there be a race condition between the
primary core and one of the secondary cores?

What is different in the Linux boot sequence between cold
boot and resume? I'm thinking that the state stored in RAM
is in fact incompatible with what Linux expects when it resumes...

Regards.
