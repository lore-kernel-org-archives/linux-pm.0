From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Issue with commit de3ef1eb1cd - PM / core: Drop run_wake flag
 from struct dev_pm_info [Was: MEI-related WARN_ON() triggered during
 resume-from-sleep on v4.13-rc2+]
Date: Tue, 1 Aug 2017 01:55:39 +0200
Message-ID: <CAJZ5v0i2MiLv6J+Wo1sUXoCKK9iG_e7pVdb0Uo5uzLXkyxpDUg@mail.gmail.com>
References: <20170730085908.GA2298@light.dominikbrodowski.net>
 <5B8DA87D05A7694D9FA63FD143655C1B749D3C1C@hasmsx108.ger.corp.intel.com> <20170731221645.GA5871@light.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="001a113ecb70a342530555a5c44a"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170731221645.GA5871@light.dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: "Winkler, Tomas" <tomas.winkler@intel.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, "Usyskin, Alexander" <alexander.usyskin@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--001a113ecb70a342530555a5c44a
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tue, Aug 1, 2017 at 12:16 AM, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> Rafael, Mika, Bjorn and Tomas,
>
> can't explain exactly what causes breakage between MEI and PM first seen on
> v4.13-rc2 (ther was a typo in the orignal message), but I was able to bisect
> it down to commit
>
> [de3ef1eb1cd0cc3a75f7a3661e10ed827f370ab8] PM / core: Drop run_wake flag from struct dev_pm_info
>

[cut]

>>
>> > [  192.940537] Restarting tasks ...
>> > [  192.940610] PGI is not set
>> > [  192.940619] ------------[ cut here ]------------ [  192.940623] WARNING: CPU: 0
>> > PID: 1661 at /home/brodo/local/kernel/git/linux/drivers/misc/mei/hw-
>> > me.c:653 mei_me_pg_exit_sync+0x351/0x360 [  192.940624] Modules linked
>> > in:
>> > [  192.940627] CPU: 0 PID: 1661 Comm: kworker/0:3 Not tainted 4.13.0-rc2+
>> > #2 [  192.940628] Hardware name: Dell Inc. XPS 13 9343/0TM99H, BIOS A11
>> > 12/08/2016 [  192.940630] Workqueue: pm pm_runtime_work <snip> [
>> > 192.940642] Call Trace:
>> > [  192.940646]  ? pci_pme_active+0x1de/0x1f0 [  192.940649]  ?
>> > pci_restore_standard_config+0x50/0x50
>> > [  192.940651]  ? kfree+0x172/0x190
>> > [  192.940653]  ? kfree+0x172/0x190
>> > [  192.940655]  ? pci_restore_standard_config+0x50/0x50
>> > [  192.940663]  mei_me_pm_runtime_resume+0x3f/0xc0
>> > [  192.940665]  pci_pm_runtime_resume+0x7a/0xa0 [  192.940667]
>> > __rpm_callback+0xb9/0x1e0 [  192.940668]  ?
>> > preempt_count_add+0x6d/0xc0 [  192.940670]  rpm_callback+0x24/0x90 [
>> > 192.940672]  ? pci_restore_standard_config+0x50/0x50
>> > [  192.940674]  rpm_resume+0x4e8/0x800
>> > [  192.940676]  pm_runtime_work+0x55/0xb0 [  192.940678]
>> > process_one_work+0x184/0x3e0 [  192.940680]  worker_thread+0x4d/0x3a0 [
>> > 192.940681]  ? preempt_count_sub+0x9b/0x100 [  192.940683]
>> > kthread+0x122/0x140 [  192.940684]  ? process_one_work+0x3e0/0x3e0 [
>> > 192.940685]  ? __kthread_create_on_node+0x1a0/0x1a0
>> > [  192.940688]  ret_from_fork+0x27/0x40
>> > [  192.940690] Code: 96 3a 9e ff 48 8b 7d 98 e8 cd 21 58 00 83 bb bc 01 00 00
>> > 04 0f 85 40 fe ff ff e9 41 fe ff ff 48 c7 c7 5f 04 99 96 e8 93 6b 9f ff <0f> ff e9 5d
>> > fd ff ff e8 33 fe 99 ff 0f 1f 00 0f 1f 44 00 00 55 [  192.940719] ---[ end trace
>> > a86955597774ead8 ]--- [  192.942540] done.
>> >
>> > This doesn't / didn't happen on v4.12.
>
>
> By using the dynamic_debug infrastructure, I was able to obtain a few more
> data points:
>
> Running 0847684cfc5f, when suspending the system to ram and resuming again,
> I see the following messages:

You have removed some relevant parts of the log, but I think I see
what's going on.

>         [  614.936773] sd 3:0:0:0: [sda] Stopping disk
>         [  614.956004] mei_me 0000:00:16.0: rpm: me: runtime resume

This is a runtime resume during system suspend.

>         [  614.956165] ACPI : EC: event blocked
>         [  614.980164] mei_me 0000:00:16.0: interrupt source 0x00000002
>         [  614.980191] mei_me 0000:00:16.0: function called after ISR to handle the interrupt processing.
>         ...
>         [  615.266896] Suspended for 1.190 seconds
>         ...
>         [  615.455775] sd 3:0:0:0: [sda] Starting disk
>         [  615.455855] mei_me 0000:00:16.0: interrupt source 0x00000002
>         [  615.455870] mei_me 0000:00:16.0: function called after ISR to handle the interrupt processing.
>         [  615.455877] mei_me 0000:00:16.0: we need to start the dev.
>
> and everything works fine as expected (no WARN(), no stack trace, nothing
> dubious).
>
> Running de3ef1eb1cd0 instead, when suspending, I see *no* mei_me-related
> message. During resume, the stack trace already noted above for
> v4.13-rc2+ appears again:
>
>         [   80.333909] sd 3:0:0:0: [sda] Stopping disk
>         [   80.535777] psmouse serio1: Failed to disable mouse on isa0060/serio1
>         [   80.983510] ACPI : EC: event blocked

Which apparently doesn't happen here.

>         [   81.065510] PM: suspend of devices complete after 734.074 msecs
>         ...
>         [   82.137038] Restarting tasks ...
>         [   82.143986] mei_me 0000:00:16.0: rpm: me: runtime resume

And which does happen here, after system resume, but then it confuses
the driver.

>         [   82.143989] PGI is not set
>         [   82.144001] ------------[ cut here ]------------
>         [   82.144008] WARNING: CPU: 3 PID: 1881 at /home/brodo/local/kernel/git/linux/drivers/misc/mei/hw-me.c:653 mei_me_pg_exit_sync+0x351/0x360
>         [   82.144009] Modules linked in:
>         [   82.144012] CPU: 3 PID: 1881 Comm: kworker/3:5 Not tainted 4.12.0-rc5+ #3
>         [   82.144013] Hardware name: Dell Inc. XPS 13 9343/0TM99H, BIOS A11 12/08/2016
>         ...
>         [   82.144017] Workqueue: pm pm_runtime_work
>         [   82.144019] task: ffff964a91b35700 task.stack: ffffa51b43508000
>         [   82.144022] RIP: 0010:mei_me_pg_exit_sync+0x351/0x360
>         ...
>         [   82.144156] ---[ end trace 5827b2fcedec4bc9 ]---
>         [   82.144272] done.
>         ...
>         [   83.194425] mei_me 0000:00:16.0: rpm: me: runtime resume ret = -62
>         [   83.194460] mei_me 0000:00:16.0: unexpected reset: dev_state = ENABLED fw status = 1E000245 6000A106 00000200 00004400 00000101 43C00ED9
>         ...
>
> Any ideas?

Can you check if the attached patch makes any difference?

Thanks,
Rafael

--001a113ecb70a342530555a5c44a
Content-Type: text/x-patch; charset="US-ASCII"; name="mei-suspend-debug.patch"
Content-Disposition: attachment; filename="mei-suspend-debug.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j5stapg21

LS0tCiBkcml2ZXJzL21pc2MvbWVpL3BjaS1tZS5jIHwgICAgMiArKwogMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKQoKSW5kZXg6IGxpbnV4LXBtL2RyaXZlcnMvbWlzYy9tZWkvcGNpLW1l
LmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PQotLS0gbGludXgtcG0ub3JpZy9kcml2ZXJzL21pc2MvbWVpL3BjaS1tZS5j
CisrKyBsaW51eC1wbS9kcml2ZXJzL21pc2MvbWVpL3BjaS1tZS5jCkBAIC0zMDksNiArMzA5LDgg
QEAgc3RhdGljIGludCBtZWlfbWVfcGNpX3N1c3BlbmQoc3RydWN0IGRldgogCWlmICghZGV2KQog
CQlyZXR1cm4gLUVOT0RFVjsKIAorCXBtX3J1bnRpbWVfcmVzdW1lKCZwZGV2LT5kZXYpOworCiAJ
ZGV2X2RiZygmcGRldi0+ZGV2LCAic3VzcGVuZFxuIik7CiAKIAltZWlfc3RvcChkZXYpOwo=
--001a113ecb70a342530555a5c44a--
