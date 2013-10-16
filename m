From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: cpufreq-next opps with cpufreq-bench
Date: Wed, 16 Oct 2013 09:49:02 +0530
Message-ID: <CAKohponEEagXGYOXYXrAqdDJn23Po6=sVhpZEO_+Sta8MUY-XA@mail.gmail.com>
References: <20131013090159.GB24566@lunn.ch>
	<20131013211436.GB24927@lunn.ch>
	<20131013214547.GC24927@lunn.ch>
	<2502389.2uE805jDh9@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=047d7b6d91a050552f04e8d40024
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:41822 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844Ab3JPETE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2013 00:19:04 -0400
Received: by mail-qa0-f50.google.com with SMTP id cm18so283719qab.16
        for <linux-pm@vger.kernel.org>; Tue, 15 Oct 2013 21:19:02 -0700 (PDT)
In-Reply-To: <2502389.2uE805jDh9@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org

--047d7b6d91a050552f04e8d40024
Content-Type: text/plain; charset=ISO-8859-1

On 16/10/2013, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> Well, I've dropped the offending commit from my queue.  Hopefully, it still
> builds on all targets it used to build on.

Thanks!!

I tried to reproduce it 2 days back and my laptop was almost completely
discharged and I have left my charger at a friends place last week :(
So couldn't really do anything until then.. Got my charger today and so
coming back on this..

I couldn't run and find cpufreq-bench on ubuntu (Is it available?)..
But I think I have found the problem..

@Andrew: Can you give this a try please? (Use attached commit)..

commit 0c5d6493fe02606512e94fad3ea075bc4f56b7e7
Author: Viresh Kumar <viresh.kumar@linaro.org>
Date:   Wed Oct 16 09:39:18 2013 +0530

    cpufreq: Use correct rwsem in cpufreq_set_policy()

    Recent commit "cpufreq: create per policy rwsem instead of per CPU
    cpu_policy_rwsem" introduced a bug where kernel crashes when we run
    cpufreq-bench. Crash looks like this:

    Unable to handle kernel NULL pointer dereference at virtual address 00000000
    pgd = cfa60000
    [00000000] *pgd=0d7c9831, *pte=00000000, *ppte=00000000
    Internal error: Oops: 17 [#1] PREEMPT ARM
    Modules linked in:
    CPU: 0 PID: 2427 Comm: cpufreq-bench Not tainted
3.12.0-rc4-00708-g1546af5 #86
    task: cfa98e60 ti: ce58a000 task.ti: ce58a000
    PC is at wake_up_process+0xc/0x48
    LR is at __up_write+0x158/0x164
    pc : [<c0040a14>]    lr : [<c0209630>]    psr: 60000093
    sp : ce58bd90  ip : ce58bda8  fp : ce58bda4
    r10: cfb3aa28  r9 : ce58bea8  r8 : ce58beb8
    r7 : ce58beac  r6 : 00000000  r5 : cfb3a9c0  r4 : ce58be10
    r3 : cfb3aa5c  r2 : cfb3aa5c  r1 : 00000000  r0 : 00000000
    Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
    Control: 0005397f  Table: 0fa60000  DAC: 00000015
    Process cpufreq-bench (pid: 2427, stack limit = 0xce58a1c0)
    Stack: (0xce58bd90 to 0xce58c000)

    <snip>

    Backtrace:
    [<c0040a08>] (wake_up_process+0x0/0x48) from [<c0209630>]
(__up_write+0x158/0x164)
     r5:cfb3a9c0 r4:ce58be10
    [<c02094d8>] (__up_write+0x0/0x164) from [<c0039fe8>] (up_write+0x10/0x14)
    [<c0039fd8>] (up_write+0x0/0x14) from [<c03578a0>]
(cpufreq_set_policy+0x120/0x1cc)
    [<c0357780>] (cpufreq_set_policy+0x0/0x1cc) from [<c0358efc>]
(store_scaling_governor+0xac/0x1a4)
     r7:0000000b r6:00000000 r5:ce58be10 r4:cfb3a9c0
    [<c0358e50>] (store_scaling_governor+0x0/0x1a4) from [<c03576e8>]
(store+0x88/0xa4)
     r8:c04d6e3c r7:cfae6a80 r6:ce58bf78 r5:cfb3a9c0 r4:cfb3aa58
    [<c0357660>] (store+0x0/0xa4) from [<c011a078>]
(sysfs_write_file+0x108/0x188)
     r5:cfa12f58 r4:cfa12f40
    [<c0119f70>] (sysfs_write_file+0x0/0x188) from [<c00bb340>]
(vfs_write+0xcc/0x198)
    [<c00bb274>] (vfs_write+0x0/0x198) from [<c00bb4f0>] (SyS_write+0x4c/0x78)
    [<c00bb4a4>] (SyS_write+0x0/0x78) from [<c0009480>]
(ret_fast_syscall+0x0/0x2c)
     r8:c00095e4 r7:00000004 r6:bedcfaf0 r5:00000006 r4:0000000b
    Code: e89da800 e1a0c00d e92dd830 e24cb004 (e5903000)
    ---[ end trace a412cb5cfd5edab9 ]---
    note: cpufreq-bench[2427] exited with preempt_count 1

    This happened because we used rwsem of new policy structure instead of the
    existing one. And that one was never initialized.

    Reported-by: Andrew Lunn <andrew@lunn.ch>
    Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 8a3914b..5c9be08 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1902,10 +1902,10 @@ static int cpufreq_set_policy(struct
cpufreq_policy *policy,
                        /* end old governor */
                        if (policy->governor) {
                                __cpufreq_governor(policy, CPUFREQ_GOV_STOP);
-                               up_write(&new_policy->rwsem);
+                               up_write(&policy->rwsem);
                                __cpufreq_governor(policy,
                                                CPUFREQ_GOV_POLICY_EXIT);
-                               down_write(&new_policy->rwsem);
+                               down_write(&policy->rwsem);
                        }

                        /* start new governor */
@@ -1914,10 +1914,10 @@ static int cpufreq_set_policy(struct
cpufreq_policy *policy,
                                if (!__cpufreq_governor(policy,
CPUFREQ_GOV_START)) {
                                        failed = 0;
                                } else {
-                                       up_write(&new_policy->rwsem);
+                                       up_write(&policy->rwsem);
                                        __cpufreq_governor(policy,

CPUFREQ_GOV_POLICY_EXIT);
-                                       down_write(&new_policy->rwsem);
+                                       down_write(&policy->rwsem);
                                }
                        }

--047d7b6d91a050552f04e8d40024
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-cpufreq-Use-correct-rwsem-in-cpufreq_set_policy.patch"
Content-Disposition: attachment;
	filename="0001-cpufreq-Use-correct-rwsem-in-cpufreq_set_policy.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: file0

RnJvbSAwYzVkNjQ5M2ZlMDI2MDY1MTJlOTRmYWQzZWEwNzViYzRmNTZiN2U3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlkOiA8MGM1ZDY0OTNmZTAyNjA2NTEyZTk0ZmFkM2VhMDc1
YmM0ZjU2YjdlNy4xMzgxODk2ODg0LmdpdC52aXJlc2gua3VtYXJAbGluYXJvLm9yZz4KRnJvbTog
VmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz4KRGF0ZTogV2VkLCAxNiBPY3Qg
MjAxMyAwOTozOToxOCArMDUzMApTdWJqZWN0OiBbUEFUQ0hdIGNwdWZyZXE6IFVzZSBjb3JyZWN0
IHJ3c2VtIGluIGNwdWZyZXFfc2V0X3BvbGljeSgpCgpSZWNlbnQgY29tbWl0ICJjcHVmcmVxOiBj
cmVhdGUgcGVyIHBvbGljeSByd3NlbSBpbnN0ZWFkIG9mIHBlciBDUFUKY3B1X3BvbGljeV9yd3Nl
bSIgaW50cm9kdWNlZCBhIGJ1ZyB3aGVyZSBrZXJuZWwgY3Jhc2hlcyB3aGVuIHdlIHJ1bgpjcHVm
cmVxLWJlbmNoLiBDcmFzaCBsb29rcyBsaWtlIHRoaXM6CgpVbmFibGUgdG8gaGFuZGxlIGtlcm5l
bCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgYXQgdmlydHVhbCBhZGRyZXNzIDAwMDAwMDAwCnBn
ZCA9IGNmYTYwMDAwClswMDAwMDAwMF0gKnBnZD0wZDdjOTgzMSwgKnB0ZT0wMDAwMDAwMCwgKnBw
dGU9MDAwMDAwMDAKSW50ZXJuYWwgZXJyb3I6IE9vcHM6IDE3IFsjMV0gUFJFRU1QVCBBUk0KTW9k
dWxlcyBsaW5rZWQgaW46CkNQVTogMCBQSUQ6IDI0MjcgQ29tbTogY3B1ZnJlcS1iZW5jaCBOb3Qg
dGFpbnRlZCAzLjEyLjAtcmM0LTAwNzA4LWcxNTQ2YWY1ICM4Ngp0YXNrOiBjZmE5OGU2MCB0aTog
Y2U1OGEwMDAgdGFzay50aTogY2U1OGEwMDAKUEMgaXMgYXQgd2FrZV91cF9wcm9jZXNzKzB4Yy8w
eDQ4CkxSIGlzIGF0IF9fdXBfd3JpdGUrMHgxNTgvMHgxNjQKcGMgOiBbPGMwMDQwYTE0Pl0gICAg
bHIgOiBbPGMwMjA5NjMwPl0gICAgcHNyOiA2MDAwMDA5MwpzcCA6IGNlNThiZDkwICBpcCA6IGNl
NThiZGE4ICBmcCA6IGNlNThiZGE0CnIxMDogY2ZiM2FhMjggIHI5IDogY2U1OGJlYTggIHI4IDog
Y2U1OGJlYjgKcjcgOiBjZTU4YmVhYyAgcjYgOiAwMDAwMDAwMCAgcjUgOiBjZmIzYTljMCAgcjQg
OiBjZTU4YmUxMApyMyA6IGNmYjNhYTVjICByMiA6IGNmYjNhYTVjICByMSA6IDAwMDAwMDAwICBy
MCA6IDAwMDAwMDAwCkZsYWdzOiBuWkN2ICBJUlFzIG9mZiAgRklRcyBvbiAgTW9kZSBTVkNfMzIg
IElTQSBBUk0gIFNlZ21lbnQgdXNlcgpDb250cm9sOiAwMDA1Mzk3ZiAgVGFibGU6IDBmYTYwMDAw
ICBEQUM6IDAwMDAwMDE1ClByb2Nlc3MgY3B1ZnJlcS1iZW5jaCAocGlkOiAyNDI3LCBzdGFjayBs
aW1pdCA9IDB4Y2U1OGExYzApClN0YWNrOiAoMHhjZTU4YmQ5MCB0byAweGNlNThjMDAwKQoKPHNu
aXA+CgpCYWNrdHJhY2U6Cls8YzAwNDBhMDg+XSAod2FrZV91cF9wcm9jZXNzKzB4MC8weDQ4KSBm
cm9tIFs8YzAyMDk2MzA+XSAoX191cF93cml0ZSsweDE1OC8weDE2NCkKIHI1OmNmYjNhOWMwIHI0
OmNlNThiZTEwCls8YzAyMDk0ZDg+XSAoX191cF93cml0ZSsweDAvMHgxNjQpIGZyb20gWzxjMDAz
OWZlOD5dICh1cF93cml0ZSsweDEwLzB4MTQpCls8YzAwMzlmZDg+XSAodXBfd3JpdGUrMHgwLzB4
MTQpIGZyb20gWzxjMDM1NzhhMD5dIChjcHVmcmVxX3NldF9wb2xpY3krMHgxMjAvMHgxY2MpCls8
YzAzNTc3ODA+XSAoY3B1ZnJlcV9zZXRfcG9saWN5KzB4MC8weDFjYykgZnJvbSBbPGMwMzU4ZWZj
Pl0gKHN0b3JlX3NjYWxpbmdfZ292ZXJub3IrMHhhYy8weDFhNCkKIHI3OjAwMDAwMDBiIHI2OjAw
MDAwMDAwIHI1OmNlNThiZTEwIHI0OmNmYjNhOWMwCls8YzAzNThlNTA+XSAoc3RvcmVfc2NhbGlu
Z19nb3Zlcm5vcisweDAvMHgxYTQpIGZyb20gWzxjMDM1NzZlOD5dIChzdG9yZSsweDg4LzB4YTQp
CiByODpjMDRkNmUzYyByNzpjZmFlNmE4MCByNjpjZTU4YmY3OCByNTpjZmIzYTljMCByNDpjZmIz
YWE1OApbPGMwMzU3NjYwPl0gKHN0b3JlKzB4MC8weGE0KSBmcm9tIFs8YzAxMWEwNzg+XSAoc3lz
ZnNfd3JpdGVfZmlsZSsweDEwOC8weDE4OCkKIHI1OmNmYTEyZjU4IHI0OmNmYTEyZjQwCls8YzAx
MTlmNzA+XSAoc3lzZnNfd3JpdGVfZmlsZSsweDAvMHgxODgpIGZyb20gWzxjMDBiYjM0MD5dICh2
ZnNfd3JpdGUrMHhjYy8weDE5OCkKWzxjMDBiYjI3ND5dICh2ZnNfd3JpdGUrMHgwLzB4MTk4KSBm
cm9tIFs8YzAwYmI0ZjA+XSAoU3lTX3dyaXRlKzB4NGMvMHg3OCkKWzxjMDBiYjRhND5dIChTeVNf
d3JpdGUrMHgwLzB4NzgpIGZyb20gWzxjMDAwOTQ4MD5dIChyZXRfZmFzdF9zeXNjYWxsKzB4MC8w
eDJjKQogcjg6YzAwMDk1ZTQgcjc6MDAwMDAwMDQgcjY6YmVkY2ZhZjAgcjU6MDAwMDAwMDYgcjQ6
MDAwMDAwMGIKQ29kZTogZTg5ZGE4MDAgZTFhMGMwMGQgZTkyZGQ4MzAgZTI0Y2IwMDQgKGU1OTAz
MDAwKQotLS1bIGVuZCB0cmFjZSBhNDEyY2I1Y2ZkNWVkYWI5IF0tLS0Kbm90ZTogY3B1ZnJlcS1i
ZW5jaFsyNDI3XSBleGl0ZWQgd2l0aCBwcmVlbXB0X2NvdW50IDEKClRoaXMgaGFwcGVuZWQgYmVj
YXVzZSB3ZSB1c2VkIHJ3c2VtIG9mIG5ldyBwb2xpY3kgc3RydWN0dXJlIGluc3RlYWQgb2YgdGhl
CmV4aXN0aW5nIG9uZS4gQW5kIHRoYXQgb25lIHdhcyBuZXZlciBpbml0aWFsaXplZC4KClJlcG9y
dGVkLWJ5OiBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+ClNpZ25lZC1vZmYtYnk6IFZpcmVz
aCBLdW1hciA8dmlyZXNoLmt1bWFyQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9jcHVmcmVxL2Nw
dWZyZXEuYyB8IDggKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVmcmVxL2NwdWZyZXEuYyBiL2Ry
aXZlcnMvY3B1ZnJlcS9jcHVmcmVxLmMKaW5kZXggOGEzOTE0Yi4uNWM5YmUwOCAxMDA2NDQKLS0t
IGEvZHJpdmVycy9jcHVmcmVxL2NwdWZyZXEuYworKysgYi9kcml2ZXJzL2NwdWZyZXEvY3B1ZnJl
cS5jCkBAIC0xOTAyLDEwICsxOTAyLDEwIEBAIHN0YXRpYyBpbnQgY3B1ZnJlcV9zZXRfcG9saWN5
KHN0cnVjdCBjcHVmcmVxX3BvbGljeSAqcG9saWN5LAogCQkJLyogZW5kIG9sZCBnb3Zlcm5vciAq
LwogCQkJaWYgKHBvbGljeS0+Z292ZXJub3IpIHsKIAkJCQlfX2NwdWZyZXFfZ292ZXJub3IocG9s
aWN5LCBDUFVGUkVRX0dPVl9TVE9QKTsKLQkJCQl1cF93cml0ZSgmbmV3X3BvbGljeS0+cndzZW0p
OworCQkJCXVwX3dyaXRlKCZwb2xpY3ktPnJ3c2VtKTsKIAkJCQlfX2NwdWZyZXFfZ292ZXJub3Io
cG9saWN5LAogCQkJCQkJQ1BVRlJFUV9HT1ZfUE9MSUNZX0VYSVQpOwotCQkJCWRvd25fd3JpdGUo
Jm5ld19wb2xpY3ktPnJ3c2VtKTsKKwkJCQlkb3duX3dyaXRlKCZwb2xpY3ktPnJ3c2VtKTsKIAkJ
CX0KIAogCQkJLyogc3RhcnQgbmV3IGdvdmVybm9yICovCkBAIC0xOTE0LDEwICsxOTE0LDEwIEBA
IHN0YXRpYyBpbnQgY3B1ZnJlcV9zZXRfcG9saWN5KHN0cnVjdCBjcHVmcmVxX3BvbGljeSAqcG9s
aWN5LAogCQkJCWlmICghX19jcHVmcmVxX2dvdmVybm9yKHBvbGljeSwgQ1BVRlJFUV9HT1ZfU1RB
UlQpKSB7CiAJCQkJCWZhaWxlZCA9IDA7CiAJCQkJfSBlbHNlIHsKLQkJCQkJdXBfd3JpdGUoJm5l
d19wb2xpY3ktPnJ3c2VtKTsKKwkJCQkJdXBfd3JpdGUoJnBvbGljeS0+cndzZW0pOwogCQkJCQlf
X2NwdWZyZXFfZ292ZXJub3IocG9saWN5LAogCQkJCQkJCUNQVUZSRVFfR09WX1BPTElDWV9FWElU
KTsKLQkJCQkJZG93bl93cml0ZSgmbmV3X3BvbGljeS0+cndzZW0pOworCQkJCQlkb3duX3dyaXRl
KCZwb2xpY3ktPnJ3c2VtKTsKIAkJCQl9CiAJCQl9CiAKLS0gCjEuNy4xMi5yYzIuMTguZzYxYjQ3
MmUKCg==
--047d7b6d91a050552f04e8d40024--
