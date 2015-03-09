From: Ethan Zhao <ethan.kernel@gmail.com>
Subject: Re: [PATCH Resend] cpufreq: Set cpufreq_cpu_data to NULL before
 putting kobject
Date: Mon, 9 Mar 2015 09:34:20 +0800
Message-ID: <CABawtvPAA2f9vv6WN98OvP3JR1UCApHtGoREpZnVkWSZGWS=kQ@mail.gmail.com>
References: <ed8fd187687cb4ea9afd0bc32107ca5abf03e679.1422663249.git.viresh.kumar@linaro.org>
	<54CEECF7.7020504@oracle.com>
	<CAKohpon10=xemOZkvqMTV2JbdTMXPDiW+-v52Qzm8SsNymN-Kg@mail.gmail.com>
	<54CEF123.5050106@oracle.com>
	<CAKohponOvEnG2Tt5sFPLAHA_bHckHboR7t35-7ey5b_cCKfvKg@mail.gmail.com>
	<54CEF574.6040404@oracle.com>
	<CAKohpom589bFL4-eyR1=qrc6uoRtjck_z_SBHS3XU8dJSc4yFg@mail.gmail.com>
	<54CEF7AA.80401@oracle.com>
	<CAKohponfkJVYFTsj6ijy0iY3t-R=zN=M0ZkoDmYa-WYTzPuvmw@mail.gmail.com>
	<54CEFA23.7040705@oracle.com>
	<CAKohpomBcBVXLW-RW1VXAtkTw-BKd7tHmeFJgmf9CM3vi1Ki-Q@mail.gmail.com>
	<54CF0106.5050601@oracle.com>
	<CAKohpomYpEAeQeaB7HVT0cBT5H_P8QQ-e+FQ5OqUoOvfz2ZnOQ@mail.gmail.com>
	<54CF9209.1050403@oracle.com>
	<CABawtvPtd2Ln6ghYRHhPy5SbUZqe2yncyeOta2CLt7fV1=504A@mail.gmail.com>
	<54ED50F5.5080603@linaro.org>
	<CABawtvPQNY91jS7gUWVVUZ87SG9zjtXDmTYsi0Q7hLbH_dPYng@mail.gmail.com>
	<54EDF8FC.8060204@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:46459 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbbCIBeV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 8 Mar 2015 21:34:21 -0400
In-Reply-To: <54EDF8FC.8060204@oracle.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: viresh kumar <viresh.kumar@linaro.org>, santosh shilimkar <santosh.shilimkar@oracle.com>
Cc: ethan zhao <ethan.zhao@oracle.com>, Rafael Wysocki <rjw@rjwysocki.net>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, guangyu.sun@oracle.com, "sriharsha.devdas@oracle.com" <sriharsha.devdas@oracle.com>

Viresh,
    Got that box and did some debug, found the policy->kobj is not initialized.
So the race happened between cpufreq_cpu_get() and
__cpufreq_add_dev(), and verified 'this' race could be fixed by commit

6d4e81e cpufreq: Ref the policy object sooner

    I have reboot the box with crond for more than 12 hours, no warning found.

    But obviously, the commit
    cpufreq: Set cpufreq_cpu_data to NULL before putting kobject
    also fixed one of the possible race condition.


Thanks,
Ethan

On Thu, Feb 26, 2015 at 12:31 AM, santosh shilimkar
<santosh.shilimkar@oracle.com> wrote:
> On 2/24/2015 9:47 PM, Ethan Zhao wrote:
>>
>> Viresh,
>>
>>      Will do that when I get the test box.
>>
> Thanks Ethan.
>
>
>>
>> On Wed, Feb 25, 2015 at 12:35 PM, viresh kumar <viresh.kumar@linaro.org>
>> wrote:
>>>
>>> On Wednesday 25 February 2015 08:54 AM, Ethan Zhao wrote:
>>>>
>>>> Viresh,
>>>>    With this patch applied, still got the following warning and panic,
>>>> seems it needs more care.
>>>>
>>>>       54.474618] ------------[ cut here ]------------
>>>> [   54.545816] WARNING: CPU: 0 PID: 213 at include/linux/kref.h:47
>>>> kobject_get+0x41/0x50()
>>>> [   54.642595] Modules linked in: i2c_i801(+) mfd_core shpchp(+)
>>>> acpi_cpufreq(+) edac_core ioatdma(+) xfs libcrc32c ast syscopyarea ixgbe
>>>> sysfillrect sysimgblt sr_mod sd_mod drm_kms_helper igb mdio cdrom e1000e
>>>> ahci
>>>> dca ttm libahci uas drm i2c_algo_bit ptp megaraid_sas libata usb_storage
>>>> i2c_core pps_core dm_mirror dm_region_hash dm_log dm_mod
>>>> [   55.007264] CPU: 0 PID: 213 Comm: kworker/0:2 Not tainted
>>>> 3.18.5
>>>> [   55.099970] Hardware name: Oracle Corporation SUN FIRE X4170 M2
>>>> SERVER
>>>>     /ASSY,MOTHERBOARD,X4170, BIOS 08120104 05/08/2012
>>>> [   55.239736] Workqueue: kacpi_notify acpi_os_execute_deferred
>>>> [   55.308598]  0000000000000000 00000000bd730b61 ffff88046742baf8
>>>> ffffffff816b7edb
>>>> [   55.398305]  0000000000000000 0000000000000000 ffff88046742bb38
>>>> ffffffff81078ae1
>>>> [   55.488040]  ffff88046742bbd8 ffff8806706b3000 0000000000000292
>>>> 0000000000000000
>>>> [   55.577776] Call Trace:
>>>> [   55.608228]  [<ffffffff816b7edb>] dump_stack+0x46/0x58
>>>> [   55.670895]  [<ffffffff81078ae1>] warn_slowpath_common+0x81/0xa0
>>>> [   55.743952]  [<ffffffff81078bfa>] warn_slowpath_null+0x1a/0x20
>>>> [   55.814929]  [<ffffffff8130d0d1>] kobject_get+0x41/0x50
>>>> [   55.878654]  [<ffffffff8153e955>] cpufreq_cpu_get+0x75/0xc0
>>>> [   55.946528]  [<ffffffff8153f37e>] cpufreq_update_policy+0x2e/0x1f0
>>>> [   56.021682]  [<ffffffff810bf9d2>] ? up+0x32/0x50
>>>> [   56.078126]  [<ffffffff813ab975>] ? acpi_ns_get_node+0xcb/0xf2
>>>> [   56.148974]  [<ffffffff813abdc9>] ? acpi_evaluate_object+0x22c/0x252
>>>> [   56.226066]  [<ffffffff813ac3c2>] ? acpi_get_handle+0x95/0xc0
>>>> [   56.295871]  [<ffffffff8138a7fb>] ? acpi_has_method+0x25/0x40
>>>> [   56.365661]  [<ffffffff813bbcd4>]
>>>> acpi_processor_ppc_has_changed+0x77/0x82
>>>> [   56.448956]  [<ffffffff8108f726>] ? move_linked_works+0x66/0x90
>>>> [   56.520842]  [<ffffffff813b87b9>] acpi_processor_notify+0x58/0xe7
>>>> [   56.594807]  [<ffffffff8139dfd8>] acpi_ev_notify_dispatch+0x44/0x5c
>>>> [   56.670859]  [<ffffffff81388fe3>] acpi_os_execute_deferred+0x15/0x22
>>>> [   56.747936]  [<ffffffff8109268e>] process_one_work+0x14e/0x3f0
>>>> [   56.818766]  [<ffffffff81092d9b>] worker_thread+0x11b/0x4d0
>>>> [   56.886486]  [<ffffffff81092c80>] ? rescuer_thread+0x350/0x350
>>>> [   56.957316]  [<ffffffff810984f1>] kthread+0xe1/0x100
>>>> [   57.017742]  [<ffffffff81098410>] ?
>>>> kthread_create_on_node+0x1b0/0x1b0
>>>> [   57.096903]  [<ffffffff816bfe7c>] ret_from_fork+0x7c/0xb0
>>>> [   57.162534]  [<ffffffff81098410>] ?
>>>> kthread_create_on_node+0x1b0/0x1b0
>>>> [   57.241680] ---[ end trace dce06bb76f547de5 ]---
>>>>
>>>>
>>>> Any idea ?
>>>
>>>
>>> No. Santosh reported this to me few days back, I asked him to perform
>>> some
>>> testing but don't know what happened after that..
>>>
> I didn't get time to re-look into it so far.
>
> Regards,
> Santosh
>
