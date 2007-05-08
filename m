From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: 2.6.21-mm1 hwsusp: BUG at workqueue.c:106
Date: Tue, 08 May 2007 13:09:27 +0200
Message-ID: <46405A67.8020105__9162.82994808189$1178622635$gmane$org@gmail.com>
References: <46403B7F.1050009@gmail.com>
	<20070508021131.438cee31.akpm@linux-foundation.org>
	<20070508105528.GA86@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070508105528.GA86@tv-sign.ru>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Pavel Machek <pavel@ucw.cz>, Linux kernel mailing list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Oleg Nesterov napsal(a):
> On 05/08, Andrew Morton wrote:
>> On Tue, 08 May 2007 10:57:35 +0200 Jiri Slaby <jirislaby@gmail.com> wrote:
>>
>>> this occured in dmesg during resuming from hwsusp in 2.6.21-mm1 (captured
>>> through netconsole). Perfectly reproducible, it simply happens each time I
>>> try it.
>> Let's cc Oleg.
>>
>>> usb_endpoint usbdev5.1_ep00: PM: resume from 0, parent usb5 still 2
>>> ------------[ cut here ]------------
>>> kernel BUG at /home/l/latest/xxx/kernel/workqueue.c:106!
>>> invalid opcode: 0000 [#1]
>>> SMP
>>> Modules linked in: ipv6 floppy ohci1394 ieee1394 parport_pc parport usbhid
>>> ehci_hcd pata_acpi ff_memless sr_mod cdrom
>>> CPU:    1
>>> EIP:    0060:[<c0132161>]    Not tainted VLI
>>> EFLAGS: 00010046   (2.6.21-mm1 #272)
>>> EIP is at insert_work+0x6d/0x71
>>> eax: c1c3b3c0   ebx: c1814aa0   ecx: 00000001   edx: c1814aa0
>>> esi: c1c3b340   edi: 00000282   ebp: c04d2f68   esp: c04d2f50
>>> ds: 007b   es: 007b   fs: 00d8  gs: 0000  ss: 0068
>>> Process swapper (pid: 0, ti=c04d2000 task=c1c26030 task.ti=c1c20000)
>>> Stack: c4685f54 c18148ac c04d2f98 c013816f c1c3b340 c1814aa0 c04d2f88 c013256c
>>>        00000066 c1814880 c1c5e000 c04d2fc4 c01325a1
>>> c1c5e000 00000100 c012ba35 00000000 c04d2fb8 c01333f4 Call Trace:
>>>  [<c0104f27>]  [<c0104fe2>] show_stack_log_lvl+0xa5/0xca
>>> show_registers+0x1e2/0x2da
>>>  [<c01053f5>]  [<c010559a>] do_trap+0x84/0xaa
>>> do_invalid_op+0x88/0x92
>>>  [<c0378662>]  [<c013256c>] __queue_work+0x22/0x33
>>> delayed_work_timer_fn+0x24/0x2a
>>>  [<c012ba35>]  [<c01288a9>] __do_softirq+0x75/0xe6
>>> do_softirq+0x63/0xac
>>>  [<c0128713>]  [<c0116d7e>] smp_apic_timer_interrupt+0x5c/0x88
>>> apic_timer_interrupt+0x28/0x30

>> hm, how come it's so messy?

I have no idea, this is how it appeared in the `nc -ul' output...

> queue_delayed_work().
> 
> Probably, cancel_delayed_work(&delayed_work->work) was called with the ->timer
> pending. This is wrong, cancel_delayed_work() clears _PENDING unconditionally,
> that is why the comment says
> 
> 	it is expected that, prior to calling cancel_work_sync(), the caller has
> 	arranged for the work to not be requeued.
> 
> (Just in case, after make-cancel_rearming_delayed_work-reliable.patch this is still
>  wrong (as documented) to do cancel_delayed_work() before cancel_delayed_timer(),
>  but should work correctly).
> 
> ata_port_flush_task() and ata_port_detach() do this, I sent the patch to fix this
> twice. The last one is
> 
> 	[PATCH -mm] libata-core: convert to use cancel_rearming_delayed_work()
> 	http://marc.info/?l=linux-kernel&m=117840349108505
> 	
> 
> Jiri, any chance you can re-test with the patch below?

Yes. In the meantime I investigated, that the regression is between
broken-out-2007-04-28-05-06
and
special -js edition:
I guess it's time to end the staircase experiment in -mm.
http://userweb.kernel.org/~akpm/js.bz2 is my current rollup (against
2.6.21) minus staircase and related things.

I don't know if it's possible to dig out the patch list from it, otherwise,
2.6.21-mm1 list may be used...

> --- OLD/kernel/workqueue.c~	2007-05-06 00:01:06.000000000 +0400
> +++ OLD/kernel/workqueue.c	2007-05-08 14:50:39.000000000 +0400
> @@ -103,7 +103,10 @@ static inline void set_wq_data(struct wo
>  {
>  	unsigned long new;
>  
> -	BUG_ON(!work_pending(work));
> +	if (!work_pending(work)) {
> +		printk(KERN_ERR "BUG: set_wq_data ");
> +		print_symbol("%s\n", (unsigned long) work->func);
> +	}
>  
>  	new = (unsigned long) cwq | (1UL << WORK_STRUCT_PENDING);
>  	new |= WORK_STRUCT_FLAG_MASK & *work_data_bits(work);

building and will report,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
