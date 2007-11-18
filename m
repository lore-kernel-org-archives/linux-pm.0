From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: broken suspend [Was: 2.6.24-rc2-mm1]
Date: Sun, 18 Nov 2007 13:42:18 +0100
Message-ID: <4740332A.80002__18357.7887168669$1195389821$gmane$org@gmail.com>
References: <Pine.LNX.4.44L0.0711171649100.7748-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0711171649100.7748-100000@netrider.rowland.org>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Alan Stern napsal(a):
> On Sat, 17 Nov 2007, Rafael J. Wysocki wrote:
>> On Saturday, 17 of November 2007, Jiri Slaby wrote:
>>> On 11/16/2007 05:10 PM, Alan Stern wrote:
>>>> The thing to do is figure out which driver is causing the problem.
>>>> Jiri, try enabling CONFIG_DEBUG_DRIVER.  
>>> Sadly no output.

Nice update scripts wiped kern.* from syslog config file out, hence no
output before.

> Back to the main topic...  My system hibernates and resumes with no
> apparent problem.  Jiri, it looks like you'll have to do some debug
> tracing of the routines in drivers/base/power/main.c.

Beside this two nothing strange:

dpm_suspend: b 00:06
WARNING: at /home/l/latest/bughunt/kernel/resource.c:185 __release_resource()

Call Trace:
 [<ffffffff8023f7b5>] release_resource+0xb5/0xf0
 [<ffffffff8036cda0>] pnp_release_resources+0x70/0x130
 [<ffffffff8036db85>] pnp_stop_dev+0x45/0x90
 [<ffffffff8036c942>] pnp_bus_suspend+0x92/0xb0
 [<ffffffff803b9f73>] suspend_device+0x113/0x180
 [<ffffffff803ba330>] device_suspend+0x200/0x320
 [<ffffffff80266905>] suspend_devices_and_enter+0xa5/0x170
 [<ffffffff80266bd9>] enter_state+0x209/0x270
 [<ffffffff80266cef>] state_store+0xaf/0xf0
 [<ffffffff8032ca67>] kobj_attr_store+0x17/0x20
 [<ffffffff802e459e>] sysfs_write_file+0xce/0x140
 [<ffffffff80299cc7>] vfs_write+0xc7/0x170
 [<ffffffff8029a360>] sys_write+0x50/0x90
 [<ffffffff8020bcde>] system_call+0x7e/0x83

WARNING: at /home/l/latest/bughunt/kernel/resource.c:189 __release_resource()

Call Trace:
 [<ffffffff8023f7e0>] release_resource+0xe0/0xf0
 [<ffffffff8036cda0>] pnp_release_resources+0x70/0x130
 [<ffffffff8036db85>] pnp_stop_dev+0x45/0x90
 [<ffffffff8036c942>] pnp_bus_suspend+0x92/0xb0
 [<ffffffff803b9f73>] suspend_device+0x113/0x180
 [<ffffffff803ba330>] device_suspend+0x200/0x320
 [<ffffffff80266905>] suspend_devices_and_enter+0xa5/0x170
 [<ffffffff80266bd9>] enter_state+0x209/0x270
 [<ffffffff80266cef>] state_store+0xaf/0xf0
 [<ffffffff8032ca67>] kobj_attr_store+0x17/0x20
 [<ffffffff802e459e>] sysfs_write_file+0xce/0x140
 [<ffffffff80299cc7>] vfs_write+0xc7/0x170
 [<ffffffff8029a360>] sys_write+0x50/0x90
 [<ffffffff8020bcde>] system_call+0x7e/0x83
...
dpm_suspend: b 0000:00:1f.5
ACPI Error (psargs-0355): [FZHD] Namespace lookup failure, AE_NOT_FOUND
ACPI Error (psparse-0537): Method parse/execution failed
[\_SB_.PCI0.SAT1.CHN0._GTM] (Node FFFF81007D000220), AE_NOT_FOUND
ACPI Error (psargs-0355): [FZHD] Namespace lookup failure, AE_NOT_FOUND
ACPI Error (psparse-0537): Method parse/execution failed
[\_SB_.PCI0.SAT1.CHN1._GTM] (Node FFFF81007D000360), AE_NOT_FOUND



It's stuck at _cpu_down (enter_state -> suspend_devices_and_enter ->
disable_nonboot_cpus -> _cpu_down) after calling raw_notifier_call_chain

        printk("%s: s\n", __func__);
        /* Wait for it to sleep (leaving idle task). */
        while (!idle_cpu(cpu))
                yield();

        printk("%s: t\n", __func__);
        /* This actually kills the CPU. */
        __cpu_die(cpu);

        printk("%s: u\n", __func__);
        BUBAK=1;
        /* CPU is completely dead: tell everyone.  Too late to complain. */
        if (raw_notifier_call_chain(&cpu_chain, CPU_DEAD | mod,
                                    hcpu) == NOTIFY_BAD)
                BUG();
        BUBAK=0;

        printk("%s: v\n", __func__);


See shot of prints here:
http://www.fi.muni.cz/~xslaby/sklad/susp_hang1.png

notifier_call_chain looks like:
        while (nb && nr_to_call) {
                next_nb = rcu_dereference(nb->next);
                ret = nb->notifier_call(nb, val, v);
                if (unlikely(BUBAK && cnt < 20 && (ret != lastr ||
                                lastp != nb->notifier_call))) {
                        printk("%s: c %p %d\n", __func__, nb->notifier_call,
                                        ret);
                        lastr = ret;
                        lastp = nb->notifier_call;
                        cnt++;
                }

                if (nr_calls)
                        (*nr_calls)++;

                if ((ret & NOTIFY_STOP_MASK) == NOTIFY_STOP_MASK)
                        break;
                nb = next_nb;
                nr_to_call--;
        }

System.map is here if you are curoius what are the pointers from the snapshot:
http://www.fi.muni.cz/~xslaby/sklad/System.map

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
