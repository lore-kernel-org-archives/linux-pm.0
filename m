From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] ACPI: surface3_power: MSHW0011 rev-eng implementation
Date: Fri, 30 Jun 2017 20:55:30 +0300
Message-ID: <CAHp75VdLkt4VJE_M51E66y3rhWtD0ALhorV3Kq=Y_Z_9GTbVLw@mail.gmail.com>
References: <20170629121009.30234-1-benjamin.tissoires@redhat.com>
 <CAHp75Vdn1-m0gDSHtZXX2A=Q07xG9j1eBiV8iM4e11Qk=oJfZg@mail.gmail.com>
 <20170630155706.GL26073@mail.corp.redhat.com> <CAHp75VdLU57x2YuDH+SkB1jR3rSpqcVNszhq5fDUVZZt+sqxyQ@mail.gmail.com>
 <7d8201bf-b05e-6235-7eb0-54b1a393f99f@redhat.com> <CAHp75VfWmAvaASLZOhmMBW7v+E10_7xvD11OSMKdQ0HbY_yHVg@mail.gmail.com>
 <eb6ad1a4-3538-a8f8-e8c2-c3781a90c37f@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="001a1149eb7e93f2ce0553311f01"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <eb6ad1a4-3538-a8f8-e8c2-c3781a90c37f@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Bastien Nocera <hadess@hadess.net>, Stephen Just <stephenjust@gmail.com>, Sebastian Reichel <sre@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, devel@acpica.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--001a1149eb7e93f2ce0553311f01
Content-Type: text/plain; charset="UTF-8"

On Fri, Jun 30, 2017 at 8:42 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> On 30-06-17 19:40, Andy Shevchenko wrote:
>> On Fri, Jun 30, 2017 at 8:37 PM, Hans de Goede <hdegoede@redhat.com>
>> wrote:
>>> On 30-06-17 18:37, Andy Shevchenko wrote:
>>>> On Fri, Jun 30, 2017 at 6:57 PM, Benjamin Tissoires

> Care to share that? Between me and Benjamin one of us can hopefully
> find the time to test / finish it (should be trivial really).

Not tested at all.



-- 
With Best Regards,
Andy Shevchenko

--001a1149eb7e93f2ce0553311f01
Content-Type: text/x-patch; charset="US-ASCII";
	name="0001-i2c-core-Allow-empty-id_table-in-ACPI-case-as-well.patch"
Content-Disposition: attachment;
	filename="0001-i2c-core-Allow-empty-id_table-in-ACPI-case-as-well.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j4k5t0vr0

RnJvbSBlYThhYTI4MjM0MTAzOTNiYmY2N2ExMTgyMzM5YWVhNDM5ZDhmODFkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxp
bnV4LmludGVsLmNvbT4KRGF0ZTogRnJpLCAzMCBKdW4gMjAxNyAyMDo1MzowMCArMDMwMApTdWJq
ZWN0OiBbUEFUQ0ggMS8xXSBpMmM6IGNvcmU6IEFsbG93IGVtcHR5IGlkX3RhYmxlIGluIEFDUEkg
Y2FzZSBhcyB3ZWxsCgpGb3Igbm93IGVtcHR5IElEIHRhYmxlIGlzIG5vdCBhbGxvd2VkIHdpdGgg
QUNQSSBhbmQgcHJldmVudHMgZHJpdmVyIHRvIGJlCnByb2JlZC4KCkFkZCBhIGNoZWNrIHRvIGFs
bG93IGVtcHR5IElEIHRhYmxlLgoKU2lnbmVkLW9mZi1ieTogQW5keSBTaGV2Y2hlbmtvIDxhbmRy
aXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+Ci0tLQogZHJpdmVycy9pMmMvaTJjLWNvcmUt
YmFzZS5jIHwgMyArKy0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2kyYy9pMmMtY29yZS1iYXNlLmMgYi9kcml2ZXJz
L2kyYy9pMmMtY29yZS1iYXNlLmMKaW5kZXggYzg5ZGFjN2ZkMmU3Li40NTIzMWQyMjU3YWQgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvaTJjL2kyYy1jb3JlLWJhc2UuYworKysgYi9kcml2ZXJzL2kyYy9p
MmMtY29yZS1iYXNlLmMKQEAgLTM1NCw5ICszNTQsMTAgQEAgc3RhdGljIGludCBpMmNfZGV2aWNl
X3Byb2JlKHN0cnVjdCBkZXZpY2UgKmRldikKIAogCS8qCiAJICogQW4gSTJDIElEIHRhYmxlIGlz
IG5vdCBtYW5kYXRvcnksIGlmIGFuZCBvbmx5IGlmLCBhIHN1aXRhYmxlIERldmljZQotCSAqIFRy
ZWUgbWF0Y2ggdGFibGUgZW50cnkgaXMgc3VwcGxpZWQgZm9yIHRoZSBwcm9iaW5nIGRldmljZS4K
KwkgKiBUcmVlIG9yIEFDUEkgbWF0Y2ggdGFibGUgZW50cnkgaXMgc3VwcGxpZWQgZm9yIHRoZSBw
cm9iaW5nIGRldmljZS4KIAkgKi8KIAlpZiAoIWRyaXZlci0+aWRfdGFibGUgJiYKKwkgICAgIWFj
cGlfbWF0Y2hfZGV2aWNlKGRldi0+ZHJpdmVyLT5hY3BpX21hdGNoX3RhYmxlLCAmY2xpZW50LT5k
ZXYpICYmCiAJICAgICFpMmNfb2ZfbWF0Y2hfZGV2aWNlKGRldi0+ZHJpdmVyLT5vZl9tYXRjaF90
YWJsZSwgY2xpZW50KSkKIAkJcmV0dXJuIC1FTk9ERVY7CiAKLS0gCjIuMTEuMAoK
--001a1149eb7e93f2ce0553311f01--
