From: Matt Reimer <mattjreimer@gmail.com>
Subject: Re: Is it supposed to be ok to call del_gendisk while
	userspace is frozen?
Date: Thu, 13 May 2010 14:44:26 -0700
Message-ID: <AANLkTimW3wLEt-DIRirHic1ZN1Z0k1t3TavwaCxTh_QL__3237.48953310332$1273787211$gmane$org@mail.gmail.com>
References: <AANLkTikH7DvizJ9340SiksoIWU5KU2n-OCqWc4f_-z9v@mail.gmail.com>
	<Pine.LNX.4.44L0.1005121048420.1962-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0cd71a5aa15216048680a9a7
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1005121048420.1962-100000@iolanthe.rowland.org>
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
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

--000e0cd71a5aa15216048680a9a7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, May 12, 2010 at 7:50 AM, Alan Stern <stern@rowland.harvard.edu> wro=
te:
> On Tue, 11 May 2010, Matt Reimer wrote:
>
>> >> or has a consensus about how to fix this been
>> >> achieved? I'm hitting the same problem and have some time to work on =
a
>> >> fix.
>> >
>> > Generally, it looks like del_gendisk should thaw writeback threads, bu=
t not
>> > during suspend, only during resume.
>>
>> Thawing the writeback thread only during resume does fix the case
>> Maxim originally presented:
>>
>> 0. build kernel with CONFIG_MMC_UNSAFE_RESUME
>> 1. insert SD card
>> 2. suspend
>> 3. remove SD card while suspended
>> 4. resume from suspend hangs
>>
>> But if CONFIG_MMC_UNSAFE_RESUME is not set, the kernel oopses during
>> suspend because the MMC device suspend times out:
>>
>> mmc0: card e624 removed
>> **** DPM device timeout: pxa2xx-mci.0 (pxa2xx-mci)
>> kernel BUG at /home/mreimer/sdg/android/android-2.1/kernel/drivers/base/=
power/main.c:453!
>> Unable to handle kernel NULL pointer dereference at virtual address 0000=
0000
>> pgd =3D c0004000
>> [00000000] *pgd=3D00000000
>> Internal error: Oops: 817 [#1] PREEMPT
>>
>> If I thaw the writeback thread unconditionally in del_gendisk() then
>> suspend and resume work as expected for both CONFIG_MMC_UNSAFE_RESUME
>> set/not set, even when the card is removed while suspended.
>>
>> So what is the proper fix?
>
> I don't see any reason not to let del_gendisk thaw the writeback thread
> during suspend. =A0Since the device is going away anyhow, letting the
> thread run shouldn't cause any problems.

So how does the attached patch look?

Matt


>From 20d8340471eb05aa54af1349f4ddccecd9c230c6 Mon Sep 17 00:00:00 2001
From: Matt Reimer <mreimer@sdgsystems.com>
Date: Thu, 13 May 2010 14:36:54 -0700
Subject: [PATCH] fs: prevent hang on suspend/resume when MMC/SD card presen=
t

Devices can come and go from the MMC/SD bus during suspend or resume,
when the writeback thread is frozen, resulting in a hang. So thaw the
writeback thread in del_gendisk() to prevent the hang.

Signed-off-by: Matt Reimer <mreimer@sdgsystems.com>
---
 fs/partitions/check.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/fs/partitions/check.c b/fs/partitions/check.c
index e238ab2..b303919 100644
--- a/fs/partitions/check.c
+++ b/fs/partitions/check.c
@@ -666,6 +666,8 @@ void del_gendisk(struct gendisk *disk)
        struct disk_part_iter piter;
        struct hd_struct *part;

+       thaw_process(disk->queue->backing_dev_info.wb.task);
+
        /* invalidate stuff */
        disk_part_iter_init(&piter, disk,
                             DISK_PITER_INCL_EMPTY | DISK_PITER_REVERSE);
--=20
1.7.0.4

--000e0cd71a5aa15216048680a9a7
Content-Type: application/octet-stream;
	name="0001-fs-prevent-hang-on-suspend-resume-when-MMC-SD-card-p.patch"
Content-Disposition: attachment;
	filename="0001-fs-prevent-hang-on-suspend-resume-when-MMC-SD-card-p.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g963w7d00

RnJvbSAyMGQ4MzQwNDcxZWIwNWFhNTRhZjEzNDlmNGRkY2NlY2Q5YzIzMGM2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXR0IFJlaW1lciA8bXJlaW1lckBzZGdzeXN0ZW1zLmNvbT4K
RGF0ZTogVGh1LCAxMyBNYXkgMjAxMCAxNDozNjo1NCAtMDcwMApTdWJqZWN0OiBbUEFUQ0hdIGZz
OiBwcmV2ZW50IGhhbmcgb24gc3VzcGVuZC9yZXN1bWUgd2hlbiBNTUMvU0QgY2FyZCBwcmVzZW50
CgpEZXZpY2VzIGNhbiBjb21lIGFuZCBnbyBmcm9tIHRoZSBNTUMvU0QgYnVzIGR1cmluZyBzdXNw
ZW5kIG9yIHJlc3VtZSwKd2hlbiB0aGUgd3JpdGViYWNrIHRocmVhZCBpcyBmcm96ZW4sIHJlc3Vs
dGluZyBpbiBhIGhhbmcuIFNvIHRoYXcgdGhlCndyaXRlYmFjayB0aHJlYWQgaW4gZGVsX2dlbmRp
c2soKSB0byBwcmV2ZW50IHRoZSBoYW5nLgoKU2lnbmVkLW9mZi1ieTogTWF0dCBSZWltZXIgPG1y
ZWltZXJAc2Rnc3lzdGVtcy5jb20+Ci0tLQogZnMvcGFydGl0aW9ucy9jaGVjay5jIHwgICAgMiAr
KwogMSBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvZnMvcGFydGl0aW9ucy9jaGVjay5jIGIvZnMvcGFydGl0aW9ucy9jaGVjay5jCmlu
ZGV4IGUyMzhhYjIuLmIzMDM5MTkgMTAwNjQ0Ci0tLSBhL2ZzL3BhcnRpdGlvbnMvY2hlY2suYwor
KysgYi9mcy9wYXJ0aXRpb25zL2NoZWNrLmMKQEAgLTY2Niw2ICs2NjYsOCBAQCB2b2lkIGRlbF9n
ZW5kaXNrKHN0cnVjdCBnZW5kaXNrICpkaXNrKQogCXN0cnVjdCBkaXNrX3BhcnRfaXRlciBwaXRl
cjsKIAlzdHJ1Y3QgaGRfc3RydWN0ICpwYXJ0OwogCisJdGhhd19wcm9jZXNzKGRpc2stPnF1ZXVl
LT5iYWNraW5nX2Rldl9pbmZvLndiLnRhc2spOworCiAJLyogaW52YWxpZGF0ZSBzdHVmZiAqLwog
CWRpc2tfcGFydF9pdGVyX2luaXQoJnBpdGVyLCBkaXNrLAogCQkJICAgICBESVNLX1BJVEVSX0lO
Q0xfRU1QVFkgfCBESVNLX1BJVEVSX1JFVkVSU0UpOwotLSAKMS43LjAuNAoK
--000e0cd71a5aa15216048680a9a7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--000e0cd71a5aa15216048680a9a7--
