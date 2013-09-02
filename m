From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: cpufreq warning with kernel 3.11
Date: Mon, 2 Sep 2013 11:01:34 +0530
Message-ID: <CAKohpomaLCwVVeGY7HgXubngmod_8rSr6UVwwWxmthbq=k2ncQ@mail.gmail.com>
References: <52234788.1090607@gmail.com>
	<CAKohpokCLKWpDOJsLTjbT8aO15aw93q57cufFCMtrXjbAi2hyg@mail.gmail.com>
	<9800169.8Do56q7MsY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=e89a8fb1fbfeaff6c804e55fe2ff
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:43175 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753684Ab3IBFbf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Sep 2013 01:31:35 -0400
Received: by mail-oa0-f44.google.com with SMTP id l17so4845059oag.3
        for <linux-pm@vger.kernel.org>; Sun, 01 Sep 2013 22:31:34 -0700 (PDT)
In-Reply-To: <9800169.8Do56q7MsY@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alessandro Bono <alessandro.bono@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>

--e89a8fb1fbfeaff6c804e55fe2ff
Content-Type: text/plain; charset=ISO-8859-1

On 2 September 2013 02:12, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Please don't call this a crash, especially not in a patch changelog.
> That is confusing.  It's better to say "This triggers the following warning
> sometimes:".

Same mistake for the second time :(
Fixed in my log now..

> OK, so first, I think that this transition_ongoing thing needs to be modified
> and checked under cpufreq_driver_lock.  Otherwise this code will be racy,
> because someone may have updated policy->transition_ongoing after we've read
> policy.

Hmm..

> Second, in my opinion the comment should say something like "The role of this
> function is to make sure that the CPU frequency we use is the same as the
> CPU is actually running at.  Therefore, if a CPU frequency change notification
> is in progress, it will do the update anyway, so we have nothing to do here in
> that case."  Or is it not correct?

Absolutely correct :)

Check this one (attached too), tested on my thinkpad:

From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Sun, 1 Sep 2013 22:19:37 +0530
Subject: [PATCH] cpufreq: fix serialization issues with freq change notifiers

This patch tried to serialize frequency transitions:
commit 7c30ed532cf798a8d924562f2f44d03d7652f7a7
Author: Viresh Kumar <viresh.kumar@linaro.org>
Date:   Wed Jun 19 10:16:55 2013 +0530

   cpufreq: make sure frequency transitions are serialized

But there still are few scenarios where notifications can be done in parallel.
These aren't originated from ->target() but from cpufreq_out_of_sync().

This triggers following warning sometimes:

WARNING: CPU: 0 PID: 14543 at drivers/cpufreq/cpufreq.c:317
__cpufreq_notify_transition+0x238/0x260()
In middle of another frequency transition

<snip>

all Trace:
[<ffffffff81720daa>] dump_stack+0x46/0x58
[<ffffffff8106534c>] warn_slowpath_common+0x8c/0xc0
[<ffffffff815b8560>] ? acpi_cpufreq_target+0x320/0x320
[<ffffffff81065436>] warn_slowpath_fmt+0x46/0x50
[<ffffffff815b1ec8>] __cpufreq_notify_transition+0x238/0x260
[<ffffffff815b33be>] cpufreq_notify_transition+0x3e/0x70
[<ffffffff815b345d>] cpufreq_out_of_sync+0x6d/0xb0
[<ffffffff815b370c>] cpufreq_update_policy+0x10c/0x160
[<ffffffff815b3760>] ? cpufreq_update_policy+0x160/0x160
[<ffffffff81413813>] cpufreq_set_cur_state+0x8c/0xb5
[<ffffffff814138df>] processor_set_cur_state+0xa3/0xcf
[<ffffffff8158e13c>] thermal_cdev_update+0x9c/0xb0
[<ffffffff8159046a>] step_wise_throttle+0x5a/0x90
[<ffffffff8158e21f>] handle_thermal_trip+0x4f/0x140
[<ffffffff8158e377>] thermal_zone_device_update+0x57/0xa0
[<ffffffff81415b36>] acpi_thermal_check+0x2e/0x30
[<ffffffff81415ca0>] acpi_thermal_notify+0x40/0xdc
[<ffffffff813e7dbd>] acpi_device_notify+0x19/0x1b
[<ffffffff813f8241>] acpi_ev_notify_dispatch+0x41/0x5c
[<ffffffff813e3fbe>] acpi_os_execute_deferred+0x25/0x32
[<ffffffff81081060>] process_one_work+0x170/0x4a0
[<ffffffff81082121>] worker_thread+0x121/0x390
[<ffffffff81082000>] ? manage_workers.isra.20+0x170/0x170
[<ffffffff81088fe0>] kthread+0xc0/0xd0
[<ffffffff81088f20>] ? flush_kthread_worker+0xb0/0xb0
[<ffffffff8173582c>] ret_from_fork+0x7c/0xb0
[<ffffffff81088f20>] ? flush_kthread_worker+0xb0/0xb0

This patch modifies cpufreq_out_of_sync() and returns without sending
notifications in case another transition is in progress. The role of this
function is to make sure that the CPU frequency we use is the same as the CPU is
actually running at. Therefore, if a CPU frequency change notification is in
progress, it will do the update anyway, so we have nothing to do here in that
case.

transition_ongoing is now accessed within cpufreq_driver_lock now to avoid any
race conditions.

transition_ongoing is now first incremented from the callers of PRECHANGE
notifier. And is last decremented from POSTCHANGE notifier to mark end of
transfer because some drivers don't send POSTCHANGE notification from their
->target() but from some kind of bottom half, and so this is the only place
which knows when a transition is over.

Reported-by: Alessandro Bono <alessandro.bono@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 54 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index be2e5f4..4aee299 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -274,6 +274,8 @@ static inline void adjust_jiffies(unsigned long
val, struct cpufreq_freqs *ci)
 static void __cpufreq_notify_transition(struct cpufreq_policy *policy,
  struct cpufreq_freqs *freqs, unsigned int state)
 {
+ unsigned long flags;
+
  BUG_ON(irqs_disabled());

  if (cpufreq_disabled())
@@ -286,12 +288,16 @@ static void __cpufreq_notify_transition(struct
cpufreq_policy *policy,
  switch (state) {

  case CPUFREQ_PRECHANGE:
- if (WARN(policy->transition_ongoing ==
+ write_lock_irqsave(&cpufreq_driver_lock, flags);
+ if (WARN(policy->transition_ongoing >
  cpumask_weight(policy->cpus),
- "In middle of another frequency transition\n"))
+ "In middle of another frequency transition\n")) {
+ write_unlock_irqrestore(&cpufreq_driver_lock, flags);
  return;
+ }

  policy->transition_ongoing++;
+ write_unlock_irqrestore(&cpufreq_driver_lock, flags);

  /* detect if the driver reported a value as "old frequency"
  * which is not equal to what the cpufreq core thinks is
@@ -312,11 +318,15 @@ static void __cpufreq_notify_transition(struct
cpufreq_policy *policy,
  break;

  case CPUFREQ_POSTCHANGE:
- if (WARN(!policy->transition_ongoing,
- "No frequency transition in progress\n"))
+ write_lock_irqsave(&cpufreq_driver_lock, flags);
+ if (WARN(policy->transition_ongoing < 2,
+ "No frequency transition in progress\n")) {
+ write_unlock_irqrestore(&cpufreq_driver_lock, flags);
  return;
+ }

  policy->transition_ongoing--;
+ write_unlock_irqrestore(&cpufreq_driver_lock, flags);

  adjust_jiffies(CPUFREQ_POSTCHANGE, freqs);
  pr_debug("FREQ: %lu - CPU: %lu", (unsigned long)freqs->new,
@@ -343,6 +353,19 @@ void cpufreq_notify_transition(struct
cpufreq_policy *policy,
 {
  for_each_cpu(freqs->cpu, policy->cpus)
  __cpufreq_notify_transition(policy, freqs, state);
+
+ if (state == CPUFREQ_POSTCHANGE) {
+ unsigned long flags;
+
+ /*
+ * Some drivers don't send POSTCHANGE notification from their
+ * ->target() but from some kind of bottom half and so we are
+ * ending transaction here..
+ */
+ write_lock_irqsave(&cpufreq_driver_lock, flags);
+ policy->transition_ongoing--;
+ write_unlock_irqrestore(&cpufreq_driver_lock, flags);
+ }
 }
 EXPORT_SYMBOL_GPL(cpufreq_notify_transition);

@@ -1326,6 +1349,20 @@ static void cpufreq_out_of_sync(unsigned int
cpu, unsigned int old_freq,
  policy = per_cpu(cpufreq_cpu_data, cpu);
  read_unlock_irqrestore(&cpufreq_driver_lock, flags);

+ /*
+ * The role of this function is to make sure that the CPU frequency we
+ * use is the same as the CPU is actually running at. Therefore, if a
+ * CPU frequency change notification is in progress, it will do the
+ * update anyway, so we have nothing to do here in that case.
+ */
+ write_lock_irqsave(&cpufreq_driver_lock, flags);
+ if (policy->transition_ongoing) {
+ write_unlock_irqrestore(&cpufreq_driver_lock, flags);
+ return;
+ }
+ policy->transition_ongoing++;
+ write_unlock_irqrestore(&cpufreq_driver_lock, flags);
+
  cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
  cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 }
@@ -1613,11 +1650,18 @@ int __cpufreq_driver_target(struct
cpufreq_policy *policy,
 {
  int retval = -EINVAL;
  unsigned int old_target_freq = target_freq;
+ unsigned long flags;

  if (cpufreq_disabled())
  return -ENODEV;
- if (policy->transition_ongoing)
+
+ write_lock_irqsave(&cpufreq_driver_lock, flags);
+ if (policy->transition_ongoing) {
+ write_unlock_irqrestore(&cpufreq_driver_lock, flags);
  return -EBUSY;
+ }
+ policy->transition_ongoing++;
+ write_unlock_irqrestore(&cpufreq_driver_lock, flags);

  /* Make sure that target_freq is within supported range */
  if (target_freq > policy->max)

--e89a8fb1fbfeaff6c804e55fe2ff
Content-Type: application/octet-stream;
	name="0001-cpufreq-fix-serialization-issues-with-freq-change-no.patch"
Content-Disposition: attachment;
	filename="0001-cpufreq-fix-serialization-issues-with-freq-change-no.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hl392pux0

RnJvbSBiMGFiOGJkZWYzOGY2NTA3MDQ3YjJlN2RkMWYzMmZlMmNmZTQ0ZjE3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlkOiA8YjBhYjhiZGVmMzhmNjUwNzA0N2IyZTdkZDFmMzJm
ZTJjZmU0NGYxNy4xMzc4MDk4NzcyLmdpdC52aXJlc2gua3VtYXJAbGluYXJvLm9yZz4KRnJvbTog
VmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz4KRGF0ZTogU3VuLCAxIFNlcCAy
MDEzIDIyOjE5OjM3ICswNTMwClN1YmplY3Q6IFtQQVRDSF0gY3B1ZnJlcTogZml4IHNlcmlhbGl6
YXRpb24gaXNzdWVzIHdpdGggZnJlcSBjaGFuZ2Ugbm90aWZpZXJzCgpUaGlzIHBhdGNoIHRyaWVk
IHRvIHNlcmlhbGl6ZSBmcmVxdWVuY3kgdHJhbnNpdGlvbnM6Cgljb21taXQgN2MzMGVkNTMyY2Y3
OThhOGQ5MjQ1NjJmMmY0NGQwM2Q3NjUyZjdhNwoJQXV0aG9yOiBWaXJlc2ggS3VtYXIgPHZpcmVz
aC5rdW1hckBsaW5hcm8ub3JnPgoJRGF0ZTogICBXZWQgSnVuIDE5IDEwOjE2OjU1IDIwMTMgKzA1
MzAKCgkgICAgY3B1ZnJlcTogbWFrZSBzdXJlIGZyZXF1ZW5jeSB0cmFuc2l0aW9ucyBhcmUgc2Vy
aWFsaXplZAoKQnV0IHRoZXJlIHN0aWxsIGFyZSBmZXcgc2NlbmFyaW9zIHdoZXJlIG5vdGlmaWNh
dGlvbnMgY2FuIGJlIGRvbmUgaW4gcGFyYWxsZWwuClRoZXNlIGFyZW4ndCBvcmlnaW5hdGVkIGZy
b20gLT50YXJnZXQoKSBidXQgZnJvbSBjcHVmcmVxX291dF9vZl9zeW5jKCkuCgpUaGlzIHRyaWdn
ZXJzIGZvbGxvd2luZyB3YXJuaW5nIHNvbWV0aW1lczoKCldBUk5JTkc6IENQVTogMCBQSUQ6IDE0
NTQzIGF0IGRyaXZlcnMvY3B1ZnJlcS9jcHVmcmVxLmM6MzE3Cl9fY3B1ZnJlcV9ub3RpZnlfdHJh
bnNpdGlvbisweDIzOC8weDI2MCgpCkluIG1pZGRsZSBvZiBhbm90aGVyIGZyZXF1ZW5jeSB0cmFu
c2l0aW9uCgo8c25pcD4KCmFsbCBUcmFjZToKWzxmZmZmZmZmZjgxNzIwZGFhPl0gZHVtcF9zdGFj
aysweDQ2LzB4NTgKWzxmZmZmZmZmZjgxMDY1MzRjPl0gd2Fybl9zbG93cGF0aF9jb21tb24rMHg4
Yy8weGMwCls8ZmZmZmZmZmY4MTViODU2MD5dID8gYWNwaV9jcHVmcmVxX3RhcmdldCsweDMyMC8w
eDMyMApbPGZmZmZmZmZmODEwNjU0MzY+XSB3YXJuX3Nsb3dwYXRoX2ZtdCsweDQ2LzB4NTAKWzxm
ZmZmZmZmZjgxNWIxZWM4Pl0gX19jcHVmcmVxX25vdGlmeV90cmFuc2l0aW9uKzB4MjM4LzB4MjYw
Cls8ZmZmZmZmZmY4MTViMzNiZT5dIGNwdWZyZXFfbm90aWZ5X3RyYW5zaXRpb24rMHgzZS8weDcw
Cls8ZmZmZmZmZmY4MTViMzQ1ZD5dIGNwdWZyZXFfb3V0X29mX3N5bmMrMHg2ZC8weGIwCls8ZmZm
ZmZmZmY4MTViMzcwYz5dIGNwdWZyZXFfdXBkYXRlX3BvbGljeSsweDEwYy8weDE2MApbPGZmZmZm
ZmZmODE1YjM3NjA+XSA/IGNwdWZyZXFfdXBkYXRlX3BvbGljeSsweDE2MC8weDE2MApbPGZmZmZm
ZmZmODE0MTM4MTM+XSBjcHVmcmVxX3NldF9jdXJfc3RhdGUrMHg4Yy8weGI1Cls8ZmZmZmZmZmY4
MTQxMzhkZj5dIHByb2Nlc3Nvcl9zZXRfY3VyX3N0YXRlKzB4YTMvMHhjZgpbPGZmZmZmZmZmODE1
OGUxM2M+XSB0aGVybWFsX2NkZXZfdXBkYXRlKzB4OWMvMHhiMApbPGZmZmZmZmZmODE1OTA0NmE+
XSBzdGVwX3dpc2VfdGhyb3R0bGUrMHg1YS8weDkwCls8ZmZmZmZmZmY4MTU4ZTIxZj5dIGhhbmRs
ZV90aGVybWFsX3RyaXArMHg0Zi8weDE0MApbPGZmZmZmZmZmODE1OGUzNzc+XSB0aGVybWFsX3pv
bmVfZGV2aWNlX3VwZGF0ZSsweDU3LzB4YTAKWzxmZmZmZmZmZjgxNDE1YjM2Pl0gYWNwaV90aGVy
bWFsX2NoZWNrKzB4MmUvMHgzMApbPGZmZmZmZmZmODE0MTVjYTA+XSBhY3BpX3RoZXJtYWxfbm90
aWZ5KzB4NDAvMHhkYwpbPGZmZmZmZmZmODEzZTdkYmQ+XSBhY3BpX2RldmljZV9ub3RpZnkrMHgx
OS8weDFiCls8ZmZmZmZmZmY4MTNmODI0MT5dIGFjcGlfZXZfbm90aWZ5X2Rpc3BhdGNoKzB4NDEv
MHg1YwpbPGZmZmZmZmZmODEzZTNmYmU+XSBhY3BpX29zX2V4ZWN1dGVfZGVmZXJyZWQrMHgyNS8w
eDMyCls8ZmZmZmZmZmY4MTA4MTA2MD5dIHByb2Nlc3Nfb25lX3dvcmsrMHgxNzAvMHg0YTAKWzxm
ZmZmZmZmZjgxMDgyMTIxPl0gd29ya2VyX3RocmVhZCsweDEyMS8weDM5MApbPGZmZmZmZmZmODEw
ODIwMDA+XSA/IG1hbmFnZV93b3JrZXJzLmlzcmEuMjArMHgxNzAvMHgxNzAKWzxmZmZmZmZmZjgx
MDg4ZmUwPl0ga3RocmVhZCsweGMwLzB4ZDAKWzxmZmZmZmZmZjgxMDg4ZjIwPl0gPyBmbHVzaF9r
dGhyZWFkX3dvcmtlcisweGIwLzB4YjAKWzxmZmZmZmZmZjgxNzM1ODJjPl0gcmV0X2Zyb21fZm9y
aysweDdjLzB4YjAKWzxmZmZmZmZmZjgxMDg4ZjIwPl0gPyBmbHVzaF9rdGhyZWFkX3dvcmtlcisw
eGIwLzB4YjAKClRoaXMgcGF0Y2ggbW9kaWZpZXMgY3B1ZnJlcV9vdXRfb2Zfc3luYygpIGFuZCBy
ZXR1cm5zIHdpdGhvdXQgc2VuZGluZwpub3RpZmljYXRpb25zIGluIGNhc2UgYW5vdGhlciB0cmFu
c2l0aW9uIGlzIGluIHByb2dyZXNzLiBUaGUgcm9sZSBvZiB0aGlzCmZ1bmN0aW9uIGlzIHRvIG1h
a2Ugc3VyZSB0aGF0IHRoZSBDUFUgZnJlcXVlbmN5IHdlIHVzZSBpcyB0aGUgc2FtZSBhcyB0aGUg
Q1BVIGlzCmFjdHVhbGx5IHJ1bm5pbmcgYXQuIFRoZXJlZm9yZSwgaWYgYSBDUFUgZnJlcXVlbmN5
IGNoYW5nZSBub3RpZmljYXRpb24gaXMgaW4KcHJvZ3Jlc3MsIGl0IHdpbGwgZG8gdGhlIHVwZGF0
ZSBhbnl3YXksIHNvIHdlIGhhdmUgbm90aGluZyB0byBkbyBoZXJlIGluIHRoYXQKY2FzZS4KCnRy
YW5zaXRpb25fb25nb2luZyBpcyBub3cgYWNjZXNzZWQgd2l0aGluIGNwdWZyZXFfZHJpdmVyX2xv
Y2sgbm93IHRvIGF2b2lkIGFueQpyYWNlIGNvbmRpdGlvbnMuCgp0cmFuc2l0aW9uX29uZ29pbmcg
aXMgbm93IGZpcnN0IGluY3JlbWVudGVkIGZyb20gdGhlIGNhbGxlcnMgb2YgUFJFQ0hBTkdFCm5v
dGlmaWVyLiBBbmQgaXMgbGFzdCBkZWNyZW1lbnRlZCBmcm9tIFBPU1RDSEFOR0Ugbm90aWZpZXIg
dG8gbWFyayBlbmQgb2YKdHJhbnNmZXIgYmVjYXVzZSBzb21lIGRyaXZlcnMgZG9uJ3Qgc2VuZCBQ
T1NUQ0hBTkdFIG5vdGlmaWNhdGlvbiBmcm9tIHRoZWlyCi0+dGFyZ2V0KCkgYnV0IGZyb20gc29t
ZSBraW5kIG9mIGJvdHRvbSBoYWxmLCBhbmQgc28gdGhpcyBpcyB0aGUgb25seSBwbGFjZQp3aGlj
aCBrbm93cyB3aGVuIGEgdHJhbnNpdGlvbiBpcyBvdmVyLgoKUmVwb3J0ZWQtYnk6IEFsZXNzYW5k
cm8gQm9ubyA8YWxlc3NhbmRyby5ib25vQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogVmlyZXNo
IEt1bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz4KLS0tCiBkcml2ZXJzL2NwdWZyZXEvY3B1
ZnJlcS5jIHwgNTQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0t
LS0KIDEgZmlsZSBjaGFuZ2VkLCA0OSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvY3B1ZnJlcS9jcHVmcmVxLmMgYi9kcml2ZXJzL2NwdWZyZXEvY3B1
ZnJlcS5jCmluZGV4IGJlMmU1ZjQuLjRhZWUyOTkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvY3B1ZnJl
cS9jcHVmcmVxLmMKKysrIGIvZHJpdmVycy9jcHVmcmVxL2NwdWZyZXEuYwpAQCAtMjc0LDYgKzI3
NCw4IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBhZGp1c3RfamlmZmllcyh1bnNpZ25lZCBsb25nIHZh
bCwgc3RydWN0IGNwdWZyZXFfZnJlcXMgKmNpKQogc3RhdGljIHZvaWQgX19jcHVmcmVxX25vdGlm
eV90cmFuc2l0aW9uKHN0cnVjdCBjcHVmcmVxX3BvbGljeSAqcG9saWN5LAogCQlzdHJ1Y3QgY3B1
ZnJlcV9mcmVxcyAqZnJlcXMsIHVuc2lnbmVkIGludCBzdGF0ZSkKIHsKKwl1bnNpZ25lZCBsb25n
IGZsYWdzOworCiAJQlVHX09OKGlycXNfZGlzYWJsZWQoKSk7CiAKIAlpZiAoY3B1ZnJlcV9kaXNh
YmxlZCgpKQpAQCAtMjg2LDEyICsyODgsMTYgQEAgc3RhdGljIHZvaWQgX19jcHVmcmVxX25vdGlm
eV90cmFuc2l0aW9uKHN0cnVjdCBjcHVmcmVxX3BvbGljeSAqcG9saWN5LAogCXN3aXRjaCAoc3Rh
dGUpIHsKIAogCWNhc2UgQ1BVRlJFUV9QUkVDSEFOR0U6Ci0JCWlmIChXQVJOKHBvbGljeS0+dHJh
bnNpdGlvbl9vbmdvaW5nID09CisJCXdyaXRlX2xvY2tfaXJxc2F2ZSgmY3B1ZnJlcV9kcml2ZXJf
bG9jaywgZmxhZ3MpOworCQlpZiAoV0FSTihwb2xpY3ktPnRyYW5zaXRpb25fb25nb2luZyA+CiAJ
CQkJCWNwdW1hc2tfd2VpZ2h0KHBvbGljeS0+Y3B1cyksCi0JCQkJIkluIG1pZGRsZSBvZiBhbm90
aGVyIGZyZXF1ZW5jeSB0cmFuc2l0aW9uXG4iKSkKKwkJCQkiSW4gbWlkZGxlIG9mIGFub3RoZXIg
ZnJlcXVlbmN5IHRyYW5zaXRpb25cbiIpKSB7CisJCQl3cml0ZV91bmxvY2tfaXJxcmVzdG9yZSgm
Y3B1ZnJlcV9kcml2ZXJfbG9jaywgZmxhZ3MpOwogCQkJcmV0dXJuOworCQl9CiAKIAkJcG9saWN5
LT50cmFuc2l0aW9uX29uZ29pbmcrKzsKKwkJd3JpdGVfdW5sb2NrX2lycXJlc3RvcmUoJmNwdWZy
ZXFfZHJpdmVyX2xvY2ssIGZsYWdzKTsKIAogCQkvKiBkZXRlY3QgaWYgdGhlIGRyaXZlciByZXBv
cnRlZCBhIHZhbHVlIGFzICJvbGQgZnJlcXVlbmN5IgogCQkgKiB3aGljaCBpcyBub3QgZXF1YWwg
dG8gd2hhdCB0aGUgY3B1ZnJlcSBjb3JlIHRoaW5rcyBpcwpAQCAtMzEyLDExICszMTgsMTUgQEAg
c3RhdGljIHZvaWQgX19jcHVmcmVxX25vdGlmeV90cmFuc2l0aW9uKHN0cnVjdCBjcHVmcmVxX3Bv
bGljeSAqcG9saWN5LAogCQlicmVhazsKIAogCWNhc2UgQ1BVRlJFUV9QT1NUQ0hBTkdFOgotCQlp
ZiAoV0FSTighcG9saWN5LT50cmFuc2l0aW9uX29uZ29pbmcsCi0JCQkJIk5vIGZyZXF1ZW5jeSB0
cmFuc2l0aW9uIGluIHByb2dyZXNzXG4iKSkKKwkJd3JpdGVfbG9ja19pcnFzYXZlKCZjcHVmcmVx
X2RyaXZlcl9sb2NrLCBmbGFncyk7CisJCWlmIChXQVJOKHBvbGljeS0+dHJhbnNpdGlvbl9vbmdv
aW5nIDwgMiwKKwkJCQkiTm8gZnJlcXVlbmN5IHRyYW5zaXRpb24gaW4gcHJvZ3Jlc3NcbiIpKSB7
CisJCQl3cml0ZV91bmxvY2tfaXJxcmVzdG9yZSgmY3B1ZnJlcV9kcml2ZXJfbG9jaywgZmxhZ3Mp
OwogCQkJcmV0dXJuOworCQl9CiAKIAkJcG9saWN5LT50cmFuc2l0aW9uX29uZ29pbmctLTsKKwkJ
d3JpdGVfdW5sb2NrX2lycXJlc3RvcmUoJmNwdWZyZXFfZHJpdmVyX2xvY2ssIGZsYWdzKTsKIAog
CQlhZGp1c3RfamlmZmllcyhDUFVGUkVRX1BPU1RDSEFOR0UsIGZyZXFzKTsKIAkJcHJfZGVidWco
IkZSRVE6ICVsdSAtIENQVTogJWx1IiwgKHVuc2lnbmVkIGxvbmcpZnJlcXMtPm5ldywKQEAgLTM0
Myw2ICszNTMsMTkgQEAgdm9pZCBjcHVmcmVxX25vdGlmeV90cmFuc2l0aW9uKHN0cnVjdCBjcHVm
cmVxX3BvbGljeSAqcG9saWN5LAogewogCWZvcl9lYWNoX2NwdShmcmVxcy0+Y3B1LCBwb2xpY3kt
PmNwdXMpCiAJCV9fY3B1ZnJlcV9ub3RpZnlfdHJhbnNpdGlvbihwb2xpY3ksIGZyZXFzLCBzdGF0
ZSk7CisKKwlpZiAoc3RhdGUgPT0gQ1BVRlJFUV9QT1NUQ0hBTkdFKSB7CisJCXVuc2lnbmVkIGxv
bmcgZmxhZ3M7CisKKwkJLyoKKwkJICogU29tZSBkcml2ZXJzIGRvbid0IHNlbmQgUE9TVENIQU5H
RSBub3RpZmljYXRpb24gZnJvbSB0aGVpcgorCQkgKiAtPnRhcmdldCgpIGJ1dCBmcm9tIHNvbWUg
a2luZCBvZiBib3R0b20gaGFsZiBhbmQgc28gd2UgYXJlCisJCSAqIGVuZGluZyB0cmFuc2FjdGlv
biBoZXJlLi4KKwkJICovCisJCXdyaXRlX2xvY2tfaXJxc2F2ZSgmY3B1ZnJlcV9kcml2ZXJfbG9j
aywgZmxhZ3MpOworCQlwb2xpY3ktPnRyYW5zaXRpb25fb25nb2luZy0tOworCQl3cml0ZV91bmxv
Y2tfaXJxcmVzdG9yZSgmY3B1ZnJlcV9kcml2ZXJfbG9jaywgZmxhZ3MpOworCX0KIH0KIEVYUE9S
VF9TWU1CT0xfR1BMKGNwdWZyZXFfbm90aWZ5X3RyYW5zaXRpb24pOwogCkBAIC0xMzI2LDYgKzEz
NDksMjAgQEAgc3RhdGljIHZvaWQgY3B1ZnJlcV9vdXRfb2Zfc3luYyh1bnNpZ25lZCBpbnQgY3B1
LCB1bnNpZ25lZCBpbnQgb2xkX2ZyZXEsCiAJcG9saWN5ID0gcGVyX2NwdShjcHVmcmVxX2NwdV9k
YXRhLCBjcHUpOwogCXJlYWRfdW5sb2NrX2lycXJlc3RvcmUoJmNwdWZyZXFfZHJpdmVyX2xvY2ss
IGZsYWdzKTsKIAorCS8qCisJICogVGhlIHJvbGUgb2YgdGhpcyBmdW5jdGlvbiBpcyB0byBtYWtl
IHN1cmUgdGhhdCB0aGUgQ1BVIGZyZXF1ZW5jeSB3ZQorCSAqIHVzZSBpcyB0aGUgc2FtZSBhcyB0
aGUgQ1BVIGlzIGFjdHVhbGx5IHJ1bm5pbmcgYXQuIFRoZXJlZm9yZSwgaWYgYQorCSAqIENQVSBm
cmVxdWVuY3kgY2hhbmdlIG5vdGlmaWNhdGlvbiBpcyBpbiBwcm9ncmVzcywgaXQgd2lsbCBkbyB0
aGUKKwkgKiB1cGRhdGUgYW55d2F5LCBzbyB3ZSBoYXZlIG5vdGhpbmcgdG8gZG8gaGVyZSBpbiB0
aGF0IGNhc2UuCisJICovCisJd3JpdGVfbG9ja19pcnFzYXZlKCZjcHVmcmVxX2RyaXZlcl9sb2Nr
LCBmbGFncyk7CisJaWYgKHBvbGljeS0+dHJhbnNpdGlvbl9vbmdvaW5nKSB7CisJCXdyaXRlX3Vu
bG9ja19pcnFyZXN0b3JlKCZjcHVmcmVxX2RyaXZlcl9sb2NrLCBmbGFncyk7CisJCXJldHVybjsK
Kwl9CisJcG9saWN5LT50cmFuc2l0aW9uX29uZ29pbmcrKzsKKwl3cml0ZV91bmxvY2tfaXJxcmVz
dG9yZSgmY3B1ZnJlcV9kcml2ZXJfbG9jaywgZmxhZ3MpOworCiAJY3B1ZnJlcV9ub3RpZnlfdHJh
bnNpdGlvbihwb2xpY3ksICZmcmVxcywgQ1BVRlJFUV9QUkVDSEFOR0UpOwogCWNwdWZyZXFfbm90
aWZ5X3RyYW5zaXRpb24ocG9saWN5LCAmZnJlcXMsIENQVUZSRVFfUE9TVENIQU5HRSk7CiB9CkBA
IC0xNjEzLDExICsxNjUwLDE4IEBAIGludCBfX2NwdWZyZXFfZHJpdmVyX3RhcmdldChzdHJ1Y3Qg
Y3B1ZnJlcV9wb2xpY3kgKnBvbGljeSwKIHsKIAlpbnQgcmV0dmFsID0gLUVJTlZBTDsKIAl1bnNp
Z25lZCBpbnQgb2xkX3RhcmdldF9mcmVxID0gdGFyZ2V0X2ZyZXE7CisJdW5zaWduZWQgbG9uZyBm
bGFnczsKIAogCWlmIChjcHVmcmVxX2Rpc2FibGVkKCkpCiAJCXJldHVybiAtRU5PREVWOwotCWlm
IChwb2xpY3ktPnRyYW5zaXRpb25fb25nb2luZykKKworCXdyaXRlX2xvY2tfaXJxc2F2ZSgmY3B1
ZnJlcV9kcml2ZXJfbG9jaywgZmxhZ3MpOworCWlmIChwb2xpY3ktPnRyYW5zaXRpb25fb25nb2lu
ZykgeworCQl3cml0ZV91bmxvY2tfaXJxcmVzdG9yZSgmY3B1ZnJlcV9kcml2ZXJfbG9jaywgZmxh
Z3MpOwogCQlyZXR1cm4gLUVCVVNZOworCX0KKwlwb2xpY3ktPnRyYW5zaXRpb25fb25nb2luZysr
OworCXdyaXRlX3VubG9ja19pcnFyZXN0b3JlKCZjcHVmcmVxX2RyaXZlcl9sb2NrLCBmbGFncyk7
CiAKIAkvKiBNYWtlIHN1cmUgdGhhdCB0YXJnZXRfZnJlcSBpcyB3aXRoaW4gc3VwcG9ydGVkIHJh
bmdlICovCiAJaWYgKHRhcmdldF9mcmVxID4gcG9saWN5LT5tYXgpCi0tIAoxLjcuMTIucmMyLjE4
Lmc2MWI0NzJlCgo=
--e89a8fb1fbfeaff6c804e55fe2ff--
