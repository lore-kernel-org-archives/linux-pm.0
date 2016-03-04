From: yu chen <yu.chen.surf@gmail.com>
Subject: Re: STI problem and workaround for Dell XPS 13 (Skylake, 2016) /
 Broadcom BCM4350
Date: Fri, 4 Mar 2016 15:30:20 +0800
Message-ID: <CADjb_WTD89V_UMUmz3yMQraFLTvccgUgFqAd0KJyT_1+8s+txw@mail.gmail.com>
References: <87h9gpp5rt.fsf@gmail.com>
	<CADjb_WQwwGD4wQugeLf=2k7XjtPGt9o6vgqhMdLR+ALDhK7J+Q@mail.gmail.com>
	<87a8mhotmk.fsf@gmail.com>
	<CADjb_WQQdrFFpyRghk=nvZKeXA_ZY_dCYbEDtVGrEEk0LhVN=w@mail.gmail.com>
	<8737s8uj49.fsf@gmail.com>
	<CADjb_WQcXK5kc4d9isPGcw6=oVUbnZ9P77owOcmq=KSh7wEYbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a1144378a64cc7c052d3416d7
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:33938 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbcCDHaW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Mar 2016 02:30:22 -0500
Received: by mail-wm0-f50.google.com with SMTP id p65so8303727wmp.1
        for <linux-pm@vger.kernel.org>; Thu, 03 Mar 2016 23:30:21 -0800 (PST)
In-Reply-To: <CADjb_WQcXK5kc4d9isPGcw6=oVUbnZ9P77owOcmq=KSh7wEYbw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tamas Papp <tkpapp@gmail.com>
Cc: linux-pm@vger.kernel.org

--001a1144378a64cc7c052d3416d7
Content-Type: text/plain; charset=UTF-8

On Fri, Mar 4, 2016 at 9:41 AM, yu chen <yu.chen.surf@gmail.com> wrote:
> On Thu, Mar 3, 2016 at 3:16 PM, Tamas Papp <tkpapp@gmail.com> wrote:
>> On Wed, Mar 02 2016, yu chen wrote:
>>
>>> Currently the  0000:3c and 0000:3a might have the same pnp object name PXSX,
>>> unfortunately  the 'echo' will find the first math device in the
>>> wakable list, and maybe
>>>  0000:3c was probed before 0000:3a, so... maybe this is a weakness.
>>>
>>> Maybe you can disabled the wakable feature directly in device sysfs,
>>> for example,
>>> echo 0 > /sys/devices/pci0000:00/0000:3a:00.0/power/wakeup,
>>> you might need to find out where 0000:3a:00.0 is.
>>
>> I tried that, but the module has problems after wakeup. I have to remove
>> and insert it again with modprobe.
>>
>> Still, this is an OK workaround, thanks for the help. I still don't know
>> if I should file this as a bug, and if yes, where.
>>
> Does the following fix make sense for you:
>
> cat /proc/acpi/wakeup
> PXSX:0      S4    *enabled   pci:0000:3a:00.0
> then you need to echo PXSX:0 to disable it,
> and for 3c, it would be PXSX:1

plz find attached the trival patch for it

--001a1144378a64cc7c052d3416d7
Content-Type: text/plain; charset=US-ASCII; name="fix_wakeup.diff"
Content-Disposition: attachment; filename="fix_wakeup.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ilddscki0

SW5kZXg6IGxpbnV4X2Zvcl90ZXN0L2RyaXZlcnMvYWNwaS9wcm9jLmMKPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0g
bGludXhfZm9yX3Rlc3Qub3JpZy9kcml2ZXJzL2FjcGkvcHJvYy5jCTIwMTYtMDMtMDQgMTA6NTk6
MDQuNTc2NDA1MDM5ICswODAwCisrKyBsaW51eF9mb3JfdGVzdC9kcml2ZXJzL2FjcGkvcHJvYy5j
CTIwMTYtMDMtMDQgMTI6MDY6MjQuMzY4MzQwNDY1ICswODAwCkBAIC0zMywxMCArMzMsMTQgQEAK
IAogCQlpZiAoIWRldi0+d2FrZXVwLmZsYWdzLnZhbGlkKQogCQkJY29udGludWU7Ci0KLQkJc2Vx
X3ByaW50ZihzZXEsICIlc1x0ICBTJWRcdCIsCi0JCQkgICBkZXYtPnBucC5idXNfaWQsCi0JCQkg
ICAodTMyKSBkZXYtPndha2V1cC5zbGVlcF9zdGF0ZSk7CisJCWlmIChkZXYtPnBucC5idXNfc3Vi
X2lkID49IDApCisJCQlzZXFfcHJpbnRmKHNlcSwgIiVzOiVkXHQgIFMlZFx0IiwKKwkJCQkgICAg
ZGV2LT5wbnAuYnVzX2lkLCBkZXYtPnBucC5idXNfc3ViX2lkLAorCQkJCSAgICAodTMyKSBkZXYt
Pndha2V1cC5zbGVlcF9zdGF0ZSk7CisJCWVsc2UKKwkJCXNlcV9wcmludGYoc2VxLCAiJXNcdCAg
UyVkXHQiLAorCQkJCSAgICBkZXYtPnBucC5idXNfaWQsCisJCQkJICAgICh1MzIpIGRldi0+d2Fr
ZXVwLnNsZWVwX3N0YXRlKTsKIAogCQltdXRleF9sb2NrKCZkZXYtPnBoeXNpY2FsX25vZGVfbG9j
ayk7CiAKQEAgLTk2LDE1ICsxMDAsMjMgQEAKIAkJCQlzaXplX3QgY291bnQsIGxvZmZfdCAqIHBw
b3MpCiB7CiAJc3RydWN0IGxpc3RfaGVhZCAqbm9kZSwgKm5leHQ7Ci0JY2hhciBzdHJidWZbNV07
Ci0JY2hhciBzdHJbNV0gPSAiIjsKKwljaGFyIHN0cmJ1Zls3XTsKKwljaGFyIHN0cls3XSA9ICIi
OworCWludCBzdWJfaWQgPSAtMTsKKwljaGFyICpzcGxpdDsKIAotCWlmIChjb3VudCA+IDQpCi0J
CWNvdW50ID0gNDsKKwlpZiAoY291bnQgPiA2KQorCQljb3VudCA9IDY7CiAKIAlpZiAoY29weV9m
cm9tX3VzZXIoc3RyYnVmLCBidWZmZXIsIGNvdW50KSkKIAkJcmV0dXJuIC1FRkFVTFQ7CiAJc3Ry
YnVmW2NvdW50XSA9ICdcMCc7CisJc3BsaXQgPSBzdHJzdHIoc3RyYnVmLCAiOiIpOworCWlmIChz
cGxpdCkgeworCQkqc3BsaXQgPSAnXDAnOworCQlzcGxpdCsrOworCQlzc2NhbmYoc3BsaXQsICIl
ZCIsICZzdWJfaWQpOworCX0KIAlzc2NhbmYoc3RyYnVmLCAiJXMiLCBzdHIpOwogCiAJbXV0ZXhf
bG9jaygmYWNwaV9kZXZpY2VfbG9jayk7CkBAIC0xMTQsNyArMTI2LDggQEAKIAkJaWYgKCFkZXYt
Pndha2V1cC5mbGFncy52YWxpZCkKIAkJCWNvbnRpbnVlOwogCi0JCWlmICghc3RybmNtcChkZXYt
PnBucC5idXNfaWQsIHN0ciwgNCkpIHsKKwkJaWYgKCFzdHJuY21wKGRldi0+cG5wLmJ1c19pZCwg
c3RyLCA0KSAmJgorCQkgICAgKHN1Yl9pZCA9PSAtMSB8fCBzdWJfaWQgPT0gZGV2LT5wbnAuYnVz
X3N1Yl9pZCkpIHsKIAkJCWlmIChkZXZpY2VfY2FuX3dha2V1cCgmZGV2LT5kZXYpKSB7CiAJCQkJ
Ym9vbCBlbmFibGUgPSAhZGV2aWNlX21heV93YWtldXAoJmRldi0+ZGV2KTsKIAkJCQlkZXZpY2Vf
c2V0X3dha2V1cF9lbmFibGUoJmRldi0+ZGV2LCBlbmFibGUpOwpJbmRleDogbGludXhfZm9yX3Rl
c3QvZHJpdmVycy9hY3BpL3NjYW4uYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51eF9mb3JfdGVzdC5vcmln
L2RyaXZlcnMvYWNwaS9zY2FuLmMJMjAxNi0wMy0wNCAxMDo1OTowNC41NzY0MDUwMzkgKzA4MDAK
KysrIGxpbnV4X2Zvcl90ZXN0L2RyaXZlcnMvYWNwaS9zY2FuLmMJMjAxNi0wMy0wNCAxNDo0Nzow
OC41MzIxODYzMDYgKzA4MDAKQEAgLTYwNyw2ICs2MDcsMzQgQEAKIAlwdXRfZGV2aWNlKCZhZGV2
LT5kZXYpOwogfQogCisjZGVmaW5lIE1BWF9TQU1FX05BTUUJMTAwCitzdGF0aWMgdm9pZCBfd2Fr
ZV9kZXZpY2VfYWRkKHN0cnVjdCBhY3BpX2RldmljZSAqZGV2aWNlKQoreworCXN0cnVjdCBsaXN0
X2hlYWQgKm5vZGUsICpuZXh0OworCWludCBtYXhfaWR4ID0gLTE7CisKKwlsaXN0X2Zvcl9lYWNo
X3NhZmUobm9kZSwgbmV4dCwgJmFjcGlfd2FrZXVwX2RldmljZV9saXN0KSB7CisJCXN0cnVjdCBh
Y3BpX2RldmljZSAqZGV2ID0KKwkJICAgIGNvbnRhaW5lcl9vZihub2RlLCBzdHJ1Y3QgYWNwaV9k
ZXZpY2UsIHdha2V1cF9saXN0KTsKKworCQlpZiAoIWRldi0+d2FrZXVwLmZsYWdzLnZhbGlkKQor
CQkJY29udGludWU7CisKKwkJaWYgKCFzdHJuY21wKGRldi0+cG5wLmJ1c19pZCwgZGV2aWNlLT5w
bnAuYnVzX2lkLCA0KSkgeworCQkJaWYgKGRldi0+cG5wLmJ1c19zdWJfaWQgPT0gLTEpCisJCQkJ
ZGV2LT5wbnAuYnVzX3N1Yl9pZCA9IDA7CisJCQlpZiAoZGV2LT5wbnAuYnVzX3N1Yl9pZCA+IG1h
eF9pZHgpCisJCQkJbWF4X2lkeCA9IGRldi0+cG5wLmJ1c19zdWJfaWQ7CisJCX0KKwl9CisKKwlp
ZiAobWF4X2lkeCA+PSBNQVhfU0FNRV9OQU1FKQorCQlwcl9lcnIoIlRvbyBtYW55IGRldmljZXMg
b2YgdGhlIHNhbWUgbmFtZS5cbiIpOworCisJZGV2aWNlLT5wbnAuYnVzX3N1Yl9pZCA9IChtYXhf
aWR4ID49IDApID8gKG1heF9pZHggKyAxKSA6IG1heF9pZHg7CisJbGlzdF9hZGRfdGFpbCgmZGV2
aWNlLT53YWtldXBfbGlzdCwgJmFjcGlfd2FrZXVwX2RldmljZV9saXN0KTsKK30KKwogaW50IGFj
cGlfZGV2aWNlX2FkZChzdHJ1Y3QgYWNwaV9kZXZpY2UgKmRldmljZSwKIAkJICAgIHZvaWQgKCpy
ZWxlYXNlKShzdHJ1Y3QgZGV2aWNlICopKQogewpAQCAtNjcxLDcgKzY5OSw3IEBACiAJCWxpc3Rf
YWRkX3RhaWwoJmRldmljZS0+bm9kZSwgJmRldmljZS0+cGFyZW50LT5jaGlsZHJlbik7CiAKIAlp
ZiAoZGV2aWNlLT53YWtldXAuZmxhZ3MudmFsaWQpCi0JCWxpc3RfYWRkX3RhaWwoJmRldmljZS0+
d2FrZXVwX2xpc3QsICZhY3BpX3dha2V1cF9kZXZpY2VfbGlzdCk7CisJCV93YWtlX2RldmljZV9h
ZGQoZGV2aWNlKTsKIAltdXRleF91bmxvY2soJmFjcGlfZGV2aWNlX2xvY2spOwogCiAJaWYgKGRl
dmljZS0+cGFyZW50KQpJbmRleDogbGludXhfZm9yX3Rlc3QvaW5jbHVkZS9hY3BpL2FjcGlfYnVz
LmgKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PQotLS0gbGludXhfZm9yX3Rlc3Qub3JpZy9pbmNsdWRlL2FjcGkvYWNwaV9i
dXMuaAkyMDE2LTAzLTA0IDEwOjU5OjA0LjU3NjQwNTAzOSArMDgwMAorKysgbGludXhfZm9yX3Rl
c3QvaW5jbHVkZS9hY3BpL2FjcGlfYnVzLmgJMjAxNi0wMy0wNCAxMjowMzo1MS4wNjQzNDI5MTUg
KzA4MDAKQEAgLTI0MSw2ICsyNDEsNyBAQAogCiBzdHJ1Y3QgYWNwaV9kZXZpY2VfcG5wIHsKIAlh
Y3BpX2J1c19pZCBidXNfaWQ7CQkvKiBPYmplY3QgbmFtZSAqLworCWludCBidXNfc3ViX2lkOwkJ
CS8qIFN1YiBvYmplY3QgaW5kZXggKi8KIAlzdHJ1Y3QgYWNwaV9wbnBfdHlwZSB0eXBlOwkvKiBJ
RCB0eXBlICovCiAJYWNwaV9idXNfYWRkcmVzcyBidXNfYWRkcmVzczsJLyogX0FEUiAqLwogCWNo
YXIgKnVuaXF1ZV9pZDsJCS8qIF9VSUQgKi8K
--001a1144378a64cc7c052d3416d7--
