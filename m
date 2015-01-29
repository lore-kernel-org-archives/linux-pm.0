From: santosh shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH] cpufreq: fix another race between PPC notification and
 vcpu_hotplug()
Date: Thu, 29 Jan 2015 13:14:17 -0800
Message-ID: <54CAA2A9.50008@oracle.com>
References: <1422513761-8230-1-git-send-email-ethan.zhao@oracle.com> <CAKohpon-2rO7Rkr9juNXO+cOswoWmqiKHnnTr3aprW2y_Noh_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:17013 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753011AbbA2VO3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jan 2015 16:14:29 -0500
In-Reply-To: <CAKohpon-2rO7Rkr9juNXO+cOswoWmqiKHnnTr3aprW2y_Noh_w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Ethan Zhao <ethan.zhao@oracle.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ethan Zhao <ethan.kernel@gmail.com>

On 1/29/2015 12:38 AM, Viresh Kumar wrote:
> Looks like you just save my time here, Santosh has also reported a
> similar race in a personal mail..
>
> On 29 January 2015 at 12:12, Ethan Zhao <ethan.zhao@oracle.com> wrote:
>> There is race observed between PPC changed notification handler worker thread
>> and vcpu_hotplug() called within xenbus_thread() context.
>> It is shown as following WARNING:
>>
>>   ------------[ cut here ]------------
>>   WARNING: CPU: 0 PID: 4 at include/linux/kref.h:47
>>   kobject_get+0x41/0x50()
>>   Modules linked in: acpi_cpufreq(+) nfsd auth_rpcgss nfs_acl
>>   lockd grace sunrpc xfs libcrc32c sd_mod ixgbe igb mdio ahci hwmon
>>   ...
>>   [   14.003548] CPU: 0 PID: 4 Comm: kworker/0:0 Not tainted
>>   ...
>>   [   14.003553] Workqueue: kacpi_notify acpi_os_execute_deferred
>>   [   14.003554]  0000000000000000 000000008c76682c ffff88094c793af8
>>   ffffffff81661b14
>>   [   14.003556]  0000000000000000 0000000000000000 ffff88094c793b38
>>   ffffffff81072b61
>>   [   14.003558]  ffff88094c793bd8 ffff8812491f8800 0000000000000292
>>   0000000000000000
>>   [   14.003560] Call Trace:
>>   [   14.003567]  [<ffffffff81661b14>] dump_stack+0x46/0x58
>>   [   14.003571]  [<ffffffff81072b61>] warn_slowpath_common+0x81/0xa0
>>   [   14.003572]  [<ffffffff81072c7a>] warn_slowpath_null+0x1a/0x20
>>   [   14.003574]  [<ffffffff812e16d1>] kobject_get+0x41/0x50
>>   [   14.003579]  [<ffffffff815262a5>] cpufreq_cpu_get+0x75/0xc0
>>   [   14.003581]  [<ffffffff81527c3e>] cpufreq_update_policy+0x2e/0x1f0
>>   [   14.003586]  [<ffffffff810b8cb2>] ? up+0x32/0x50
>>   [   14.003589]  [<ffffffff81381aa9>] ? acpi_ns_get_node+0xcb/0xf2
>>   [   14.003591]  [<ffffffff81381efd>] ? acpi_evaluate_object+0x22c/0x252
>>   [   14.003593]  [<ffffffff813824f6>] ? acpi_get_handle+0x95/0xc0
>>   [   14.003596]  [<ffffffff81360967>] ? acpi_has_method+0x25/0x40
>>   [   14.003601]  [<ffffffff81391e08>] acpi_processor_ppc_has_changed+0x77/0x82
>>   [   14.003604]  [<ffffffff81089566>] ? move_linked_works+0x66/0x90
>>   [   14.003606]  [<ffffffff8138e8ed>] acpi_processor_notify+0x58/0xe7
>>   [   14.003609]  [<ffffffff8137410c>] acpi_ev_notify_dispatch+0x44/0x5c
>>   [   14.003611]  [<ffffffff8135f293>] acpi_os_execute_deferred+0x15/0x22
>>   [   14.003614]  [<ffffffff8108c910>] process_one_work+0x160/0x410
>>   [   14.003616]  [<ffffffff8108d05b>] worker_thread+0x11b/0x520
>>   [   14.003617]  [<ffffffff8108cf40>] ? rescuer_thread+0x380/0x380
>>   [   14.003621]  [<ffffffff81092421>] kthread+0xe1/0x100
>>   [   14.003623]  [<ffffffff81092340>] ? kthread_create_on_node+0x1b0/0x1b0
>>   [   14.003628]  [<ffffffff81669ebc>] ret_from_fork+0x7c/0xb0
>>   [   14.003630]  [<ffffffff81092340>] ? kthread_create_on_node+0x1b0/0x1b0
>>   [   14.003631] ---[ end trace 89e66eb9795efdf7 ]---
>>
>>   Thread A: Workqueue: kacpi_notify
>>
>>   acpi_processor_notify()
>>     acpi_processor_ppc_has_changed()
>>           cpufreq_update_policy()
>>             cpufreq_cpu_get()
>>               kobject_get()
>>
>>   Thread B: xenbus_thread()
>>
>>   xenbus_thread()
>>     msg->u.watch.handle->callback()
>>       handle_vcpu_hotplug_event()
>>         vcpu_hotplug()
>>           cpu_down()
>>             __cpu_notify(CPU_DOWN_PREPARE..)
>>               cpufreq_cpu_callback()
>>                 __cpufreq_remove_dev_prepare()
>>                   update_policy_cpu()
>>                     kobject_move()
>
> Where is the race ? How do you say this is racy ?
>
> I am not sure if the problem is with kobject_move(), to me it looked like
> the problem is with cpufreq_policy_put_kobj() and we tried to do kobject_get()
> after the kobject has been freed..
>
> I don't agree to the solution you gave, but lets first make sure what the
> problem is, and then take any action against it.
>
> Please try this patch and let us know if it fixes it for you:
>
Yes it does fix the issue. Thanks Viresh

Regards,
Santosh
