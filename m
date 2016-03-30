From: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Subject: Re: [intel-pstate driver regression] processor frequency very high
 even if in idle
Date: Wed, 30 Mar 2016 17:29:18 +0200
Message-ID: <CADDKRnC1pp3Tfrfm8AsiiTJ4PR6X_qPbgLSxuBxNQJ60cO0BYQ@mail.gmail.com>
References: <CADDKRnD81Hmf+JnG6NEpQWKiKE6_mqet5yRpLJ5K_0U1GtfahQ@mail.gmail.com>
	<CADDKRnCH3yCut7A4Gvk3gHw4OpOYXoG0VQRe5mh2nTjptYU0gw@mail.gmail.com>
	<4187911.uaFVupaTVL@vostro.rjw.lan>
	<CADDKRnCr0riAu4pjYRkuguoCoAjWxFoc+pU1NBymPr+3JnVanQ@mail.gmail.com>
	<CAJZ5v0i48Xxyp880SQ1iVDzct--vhTVggCS_wHHA7bt7D+_sFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a1143d3122da975052f45cf5a
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:33671 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135AbcC3P3T (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Mar 2016 11:29:19 -0400
In-Reply-To: <CAJZ5v0i48Xxyp880SQ1iVDzct--vhTVggCS_wHHA7bt7D+_sFg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

--001a1143d3122da975052f45cf5a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

2016-03-30 13:05 GMT+02:00 Rafael J. Wysocki <rafael@kernel.org>:
> On Wed, Mar 30, 2016 at 12:17 PM, J=C3=B6rg Otte <jrg.otte@gmail.com> wro=
te:
>> 2016-03-29 23:34 GMT+02:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
>>> On Tuesday, March 29, 2016 07:32:27 PM J=C3=B6rg Otte wrote:
>>>> 2016-03-29 19:24 GMT+02:00 J=C3=B6rg Otte <jrg.otte@gmail.com>:
>>>> > in v4.5 and earlier intel-pstate downscaled idle processors (load
>>>> > 0.1-0.2%) to minumum frequency, in my case 800MHz.
>>>> >
>>>> > Now in v4.6-rc1 the characteristic has dramatically changed. If in
>>>> > idle the processor frequency is more or less a few MHz around 2500Mh=
z.
>>>> > This is the maximum non turbo frequency.
>>>> >
>>>> > No difference between powersafe or performance governor.
>>>> >
>>>> > I currently use acpi_cpufreq which works as usual.
>>>> >
>>>> > Processor:
>>>> > Intel(R) Core(TM) i5-4200M CPU @ 2.50GHz (family: 0x6, model: 0x3c,
>>>> > stepping: 0x3)
>>>> >
>>>> > Last known good kernel is: 4.5.0-01127-g9256d5a
>>>> > First known bad kernel is: 4.5.0-02535-g09fd671
>>>> >
>>>> > There is
>>>> > commit 277edba Merge tag 'pm+acpi-4.6-rc1-1' of
>>>> > git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
>>>> > in between, which brought a few changes in intel_pstate.
>>>
>>> Can you please check commit a4675fbc4a7a (cpufreq: intel_pstate: Replac=
e timers
>>> with utilization update callbacks)?
>>>
>> Yes , this solved the problem for me.
>> I had to resolve some conflicts myself when reverting that
>> commit. Hard work :).
>
> Thanks for doing this.  Can you please post the revert patch you have use=
d?
>

The patch is on top of 4.5.0-02535-g09fd671.
I'm not sure what gmail is doing with spaces and tabs,
so I attach the revert patch.


>> Here is a 10-seconds trace of the used frequencies when
>> in "desktop-idle":
>>
>> driver          cpu0 cpu1 cpu2 cpu3
>> -------------------------------------
>> intel_pstate (  800  928  941 1200) MHz   load:( 0.2)%
>> intel_pstate (  800  928 1181 1800) MHz   load:( 0.0)%
>> intel_pstate ( 1675 1576 1347  800) MHz   load:( 0.0)%
>> intel_pstate ( 1198 1576  842  800) MHz   load:( 0.5)%
>> intel_pstate (  800 1181 1113 1600) MHz   load:( 0.0)%
>> intel_pstate (  808 1181  805  800) MHz   load:( 0.5)%
>> intel_pstate (  844 1191  900 1082) MHz   load:( 0.3)%
>> intel_pstate (  816 1191  800  800) MHz   load:( 0.0)%
>> intel_pstate (  800  905  892 1082) MHz   load:( 0.2)%
>> intel_pstate (  945  905 1340  800) MHz   load:( 0.3)%
>
> Please also run turbostat with and without your revert patch applied.
>

turbostat without revert
Kernel: 4.5.0-02535-g09fd671
-----------------------------
CPUID(7): No-SGX
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz
       -      13    0.53    2514    2495
       0      14    0.55    2518    2495
       1       8    0.33    2527    2495
       2      15    0.60    2506    2495
       3      16    0.62    2509    2495

turbostat after revert of commit a4675fbc4a7a
kernel: 4.5.0-reva4675fbc4a7a-02536-g77225b1
------------------------------
CPUID(7): No-SGX
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz
       -       4    0.35    1142    2494
       0       1    0.11    1016    2494
       1       2    0.17     961    2494
       2      10    0.82    1215    2494
       3       3    0.29    1086    2494
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz
       -       4    0.46     885    2494
       0       1    0.12     889    2494
       1       1    0.16     885    2494
       2      10    1.15     883    2494
       3       4    0.40     891    2494

--001a1143d3122da975052f45cf5a
Content-Type: text/x-patch; charset=US-ASCII; name="intel_pstate_revert.patch"
Content-Disposition: attachment; filename="intel_pstate_revert.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_imf088ne0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3B1ZnJlcS9pbnRlbF9wc3RhdGUuYyBiL2RyaXZlcnMvY3B1
ZnJlcS9pbnRlbF9wc3RhdGUuYwppbmRleCBjYjU2MDc0Li45N2MxNmFmIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2NwdWZyZXEvaW50ZWxfcHN0YXRlLmMKKysrIGIvZHJpdmVycy9jcHVmcmVxL2ludGVs
X3BzdGF0ZS5jCkBAIC03MSw3ICs3MSw3IEBAIHN0cnVjdCBzYW1wbGUgewogCXU2NCBtcGVyZjsK
IAl1NjQgdHNjOwogCWludCBmcmVxOwotCXU2NCB0aW1lOworCWt0aW1lX3QgdGltZTsKIH07CiAK
IHN0cnVjdCBwc3RhdGVfZGF0YSB7CkBAIC0xMDMsMTMgKzEwMywxMyBAQCBzdHJ1Y3QgX3BpZCB7
CiBzdHJ1Y3QgY3B1ZGF0YSB7CiAJaW50IGNwdTsKIAotCXN0cnVjdCB1cGRhdGVfdXRpbF9kYXRh
IHVwZGF0ZV91dGlsOworCXN0cnVjdCB0aW1lcl9saXN0IHRpbWVyOwogCiAJc3RydWN0IHBzdGF0
ZV9kYXRhIHBzdGF0ZTsKIAlzdHJ1Y3QgdmlkX2RhdGEgdmlkOwogCXN0cnVjdCBfcGlkIHBpZDsK
IAotCXU2NAlsYXN0X3NhbXBsZV90aW1lOworCWt0aW1lX3QgbGFzdF9zYW1wbGVfdGltZTsKIAl1
NjQJcHJldl9hcGVyZjsKIAl1NjQJcHJldl9tcGVyZjsKIAl1NjQJcHJldl90c2M7CkBAIC0xMjAs
NyArMTIwLDYgQEAgc3RydWN0IGNwdWRhdGEgewogc3RhdGljIHN0cnVjdCBjcHVkYXRhICoqYWxs
X2NwdV9kYXRhOwogc3RydWN0IHBzdGF0ZV9hZGp1c3RfcG9saWN5IHsKIAlpbnQgc2FtcGxlX3Jh
dGVfbXM7Ci0JczY0IHNhbXBsZV9yYXRlX25zOwogCWludCBkZWFkYmFuZDsKIAlpbnQgc2V0cG9p
bnQ7CiAJaW50IHBfZ2Fpbl9wY3Q7CkBAIC03MTksNyArNzE4LDcgQEAgc3RhdGljIHZvaWQgY29y
ZV9zZXRfcHN0YXRlKHN0cnVjdCBjcHVkYXRhICpjcHVkYXRhLCBpbnQgcHN0YXRlKQogCWlmIChs
aW1pdHMtPm5vX3R1cmJvICYmICFsaW1pdHMtPnR1cmJvX2Rpc2FibGVkKQogCQl2YWwgfD0gKHU2
NCkxIDw8IDMyOwogCi0Jd3Jtc3JsKE1TUl9JQTMyX1BFUkZfQ1RMLCB2YWwpOworCXdybXNybF9v
bl9jcHUoY3B1ZGF0YS0+Y3B1LCBNU1JfSUEzMl9QRVJGX0NUTCwgdmFsKTsKIH0KIAogc3RhdGlj
IGludCBrbmxfZ2V0X3R1cmJvX3BzdGF0ZSh2b2lkKQpAQCAtODg0LDcgKzg4Myw3IEBAIHN0YXRp
YyBpbmxpbmUgdm9pZCBpbnRlbF9wc3RhdGVfY2FsY19idXN5KHN0cnVjdCBjcHVkYXRhICpjcHUp
CiAJc2FtcGxlLT5jb3JlX3BjdF9idXN5ID0gKGludDMyX3QpY29yZV9wY3Q7CiB9CiAKLXN0YXRp
YyBpbmxpbmUgYm9vbCBpbnRlbF9wc3RhdGVfc2FtcGxlKHN0cnVjdCBjcHVkYXRhICpjcHUsIHU2
NCB0aW1lKQorc3RhdGljIGlubGluZSB2b2lkIGludGVsX3BzdGF0ZV9zYW1wbGUoc3RydWN0IGNw
dWRhdGEgKmNwdSkKIHsKIAl1NjQgYXBlcmYsIG1wZXJmOwogCXVuc2lnbmVkIGxvbmcgZmxhZ3M7
CkBAIC04OTYsMTIgKzg5NSwxMiBAQCBzdGF0aWMgaW5saW5lIGJvb2wgaW50ZWxfcHN0YXRlX3Nh
bXBsZShzdHJ1Y3QgY3B1ZGF0YSAqY3B1LCB1NjQgdGltZSkKIAl0c2MgPSByZHRzYygpOwogCWlm
IChjcHUtPnByZXZfbXBlcmYgPT0gbXBlcmYgfHwgY3B1LT5wcmV2X3RzYyA9PSB0c2MpIHsKIAkJ
bG9jYWxfaXJxX3Jlc3RvcmUoZmxhZ3MpOwotCQlyZXR1cm4gZmFsc2U7CisJCXJldHVybjsKIAl9
CiAJbG9jYWxfaXJxX3Jlc3RvcmUoZmxhZ3MpOwogCiAJY3B1LT5sYXN0X3NhbXBsZV90aW1lID0g
Y3B1LT5zYW1wbGUudGltZTsKLQljcHUtPnNhbXBsZS50aW1lID0gdGltZTsKKwljcHUtPnNhbXBs
ZS50aW1lID0ga3RpbWVfZ2V0KCk7CiAJY3B1LT5zYW1wbGUuYXBlcmYgPSBhcGVyZjsKIAljcHUt
PnNhbXBsZS5tcGVyZiA9IG1wZXJmOwogCWNwdS0+c2FtcGxlLnRzYyA9ICB0c2M7CkBAIC05MTIs
NyArOTExLDcgQEAgc3RhdGljIGlubGluZSBib29sIGludGVsX3BzdGF0ZV9zYW1wbGUoc3RydWN0
IGNwdWRhdGEgKmNwdSwgdTY0IHRpbWUpCiAJY3B1LT5wcmV2X2FwZXJmID0gYXBlcmY7CiAJY3B1
LT5wcmV2X21wZXJmID0gbXBlcmY7CiAJY3B1LT5wcmV2X3RzYyA9IHRzYzsKLQlyZXR1cm4gdHJ1
ZTsKKwlyZXR1cm47CiB9CiAKIHN0YXRpYyBpbmxpbmUgaW50MzJfdCBnZXRfYXZnX2ZyZXF1ZW5j
eShzdHJ1Y3QgY3B1ZGF0YSAqY3B1KQpAQCAtOTIxLDYgKzkyMCwyMiBAQCBzdGF0aWMgaW5saW5l
IGludDMyX3QgZ2V0X2F2Z19mcmVxdWVuY3koc3RydWN0IGNwdWRhdGEgKmNwdSkKIAkJY3B1LT5w
c3RhdGUuc2NhbGluZywgY3B1LT5zYW1wbGUubXBlcmYpOwogfQogCitzdGF0aWMgaW5saW5lIHZv
aWQgaW50ZWxfaHdwX3NldF9zYW1wbGVfdGltZShzdHJ1Y3QgY3B1ZGF0YSAqY3B1KQoreworCWlu
dCBkZWxheTsKKworCWRlbGF5ID0gbXNlY3NfdG9famlmZmllcyg1MCk7CisJbW9kX3RpbWVyX3Bp
bm5lZCgmY3B1LT50aW1lciwgamlmZmllcyArIGRlbGF5KTsKK30KKworc3RhdGljIGlubGluZSB2
b2lkIGludGVsX3BzdGF0ZV9zZXRfc2FtcGxlX3RpbWUoc3RydWN0IGNwdWRhdGEgKmNwdSkKK3sK
KwlpbnQgZGVsYXk7CisKKwlkZWxheSA9IG1zZWNzX3RvX2ppZmZpZXMocGlkX3BhcmFtcy5zYW1w
bGVfcmF0ZV9tcyk7CisJbW9kX3RpbWVyX3Bpbm5lZCgmY3B1LT50aW1lciwgamlmZmllcyArIGRl
bGF5KTsKK30KKwogc3RhdGljIGlubGluZSBpbnQzMl90IGdldF90YXJnZXRfcHN0YXRlX3VzZV9j
cHVfbG9hZChzdHJ1Y3QgY3B1ZGF0YSAqY3B1KQogewogCXN0cnVjdCBzYW1wbGUgKnNhbXBsZSA9
ICZjcHUtPnNhbXBsZTsKQEAgLTk1OSw3ICs5NzQsOCBAQCBzdGF0aWMgaW5saW5lIGludDMyX3Qg
Z2V0X3RhcmdldF9wc3RhdGVfdXNlX2NwdV9sb2FkKHN0cnVjdCBjcHVkYXRhICpjcHUpCiBzdGF0
aWMgaW5saW5lIGludDMyX3QgZ2V0X3RhcmdldF9wc3RhdGVfdXNlX3BlcmZvcm1hbmNlKHN0cnVj
dCBjcHVkYXRhICpjcHUpCiB7CiAJaW50MzJfdCBjb3JlX2J1c3ksIG1heF9wc3RhdGUsIGN1cnJl
bnRfcHN0YXRlLCBzYW1wbGVfcmF0aW87Ci0JdTY0IGR1cmF0aW9uX25zOworCXM2NCBkdXJhdGlv
bl91czsKKwl1MzIgc2FtcGxlX3RpbWU7CiAKIAlpbnRlbF9wc3RhdGVfY2FsY19idXN5KGNwdSk7
CiAKQEAgLTk4MCwxNiArOTk2LDE4IEBAIHN0YXRpYyBpbmxpbmUgaW50MzJfdCBnZXRfdGFyZ2V0
X3BzdGF0ZV91c2VfcGVyZm9ybWFuY2Uoc3RydWN0IGNwdWRhdGEgKmNwdSkKIAljb3JlX2J1c3kg
PSBtdWxfZnAoY29yZV9idXN5LCBkaXZfZnAobWF4X3BzdGF0ZSwgY3VycmVudF9wc3RhdGUpKTsK
IAogCS8qCi0JICogU2luY2Ugb3VyIHV0aWxpemF0aW9uIHVwZGF0ZSBjYWxsYmFjayB3aWxsIG5v
dCBydW4gdW5sZXNzIHdlIGFyZQotCSAqIGluIEMwLCBjaGVjayBpZiB0aGUgYWN0dWFsIGVsYXBz
ZWQgdGltZSBpcyBzaWduaWZpY2FudGx5IGdyZWF0ZXIgKDN4KQotCSAqIHRoYW4gb3VyIHNhbXBs
ZSBpbnRlcnZhbC4gIElmIGl0IGlzLCB0aGVuIHdlIHdlcmUgaWRsZSBmb3IgYSBsb25nCi0JICog
ZW5vdWdoIHBlcmlvZCBvZiB0aW1lIHRvIGFkanVzdCBvdXIgYnVzeW5lc3MuCisJICogU2luY2Ug
d2UgaGF2ZSBhIGRlZmVycmVkIHRpbWVyLCBpdCB3aWxsIG5vdCBmaXJlIHVubGVzcworCSAqIHdl
IGFyZSBpbiBDMC4gIFNvLCBkZXRlcm1pbmUgaWYgdGhlIGFjdHVhbCBlbGFwc2VkIHRpbWUKKwkg
KiBpcyBzaWduaWZpY2FudGx5IGdyZWF0ZXIgKDN4KSB0aGFuIG91ciBzYW1wbGUgaW50ZXJ2YWwu
ICBJZiBpdAorCSAqIGlzLCB0aGVuIHdlIHdlcmUgaWRsZSBmb3IgYSBsb25nIGVub3VnaCBwZXJp
b2Qgb2YgdGltZQorCSAqIHRvIGFkanVzdCBvdXIgYnVzeW5lc3MuCiAJICovCi0JZHVyYXRpb25f
bnMgPSBjcHUtPnNhbXBsZS50aW1lIC0gY3B1LT5sYXN0X3NhbXBsZV90aW1lOwotCWlmICgoczY0
KWR1cmF0aW9uX25zID4gcGlkX3BhcmFtcy5zYW1wbGVfcmF0ZV9ucyAqIDMKLQkgICAgJiYgY3B1
LT5sYXN0X3NhbXBsZV90aW1lID4gMCkgewotCQlzYW1wbGVfcmF0aW8gPSBkaXZfZnAoaW50X3Rv
ZnAocGlkX3BhcmFtcy5zYW1wbGVfcmF0ZV9ucyksCi0JCQkJICAgICAgaW50X3RvZnAoZHVyYXRp
b25fbnMpKTsKKwlzYW1wbGVfdGltZSA9IHBpZF9wYXJhbXMuc2FtcGxlX3JhdGVfbXMgICogVVNF
Q19QRVJfTVNFQzsKKwlkdXJhdGlvbl91cyA9IGt0aW1lX3VzX2RlbHRhKGNwdS0+c2FtcGxlLnRp
bWUsCisJCQkJICAgICBjcHUtPmxhc3Rfc2FtcGxlX3RpbWUpOworCWlmIChkdXJhdGlvbl91cyA+
IHNhbXBsZV90aW1lICogMykgeworCQlzYW1wbGVfcmF0aW8gPSBkaXZfZnAoaW50X3RvZnAoc2Ft
cGxlX3RpbWUpLAorCQkJCSAgICAgIGludF90b2ZwKGR1cmF0aW9uX3VzKSk7CiAJCWNvcmVfYnVz
eSA9IG11bF9mcChjb3JlX2J1c3ksIHNhbXBsZV9yYXRpbyk7CiAJfQogCkBAIC0xMDE5LDE4ICsx
MDM3LDIzIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBpbnRlbF9wc3RhdGVfYWRqdXN0X2J1c3lfcHN0
YXRlKHN0cnVjdCBjcHVkYXRhICpjcHUpCiAJCWdldF9hdmdfZnJlcXVlbmN5KGNwdSkpOwogfQog
Ci1zdGF0aWMgdm9pZCBpbnRlbF9wc3RhdGVfdXBkYXRlX3V0aWwoc3RydWN0IHVwZGF0ZV91dGls
X2RhdGEgKmRhdGEsIHU2NCB0aW1lLAotCQkJCSAgICAgdW5zaWduZWQgbG9uZyB1dGlsLCB1bnNp
Z25lZCBsb25nIG1heCkKK3N0YXRpYyB2b2lkIGludGVsX2h3cF90aW1lcl9mdW5jKHVuc2lnbmVk
IGxvbmcgX19kYXRhKQogewotCXN0cnVjdCBjcHVkYXRhICpjcHUgPSBjb250YWluZXJfb2YoZGF0
YSwgc3RydWN0IGNwdWRhdGEsIHVwZGF0ZV91dGlsKTsKLQl1NjQgZGVsdGFfbnMgPSB0aW1lIC0g
Y3B1LT5zYW1wbGUudGltZTsKKwlzdHJ1Y3QgY3B1ZGF0YSAqY3B1ID0gKHN0cnVjdCBjcHVkYXRh
ICopIF9fZGF0YTsKIAotCWlmICgoczY0KWRlbHRhX25zID49IHBpZF9wYXJhbXMuc2FtcGxlX3Jh
dGVfbnMpIHsKLQkJYm9vbCBzYW1wbGVfdGFrZW4gPSBpbnRlbF9wc3RhdGVfc2FtcGxlKGNwdSwg
dGltZSk7CisJaW50ZWxfcHN0YXRlX3NhbXBsZShjcHUpOworCWludGVsX2h3cF9zZXRfc2FtcGxl
X3RpbWUoY3B1KTsKK30KIAotCQlpZiAoc2FtcGxlX3Rha2VuICYmICFod3BfYWN0aXZlKQotCQkJ
aW50ZWxfcHN0YXRlX2FkanVzdF9idXN5X3BzdGF0ZShjcHUpOwotCX0KK3N0YXRpYyB2b2lkIGlu
dGVsX3BzdGF0ZV90aW1lcl9mdW5jKHVuc2lnbmVkIGxvbmcgX19kYXRhKQoreworCXN0cnVjdCBj
cHVkYXRhICpjcHUgPSAoc3RydWN0IGNwdWRhdGEgKikgX19kYXRhOworCisJaW50ZWxfcHN0YXRl
X3NhbXBsZShjcHUpOworCisJaW50ZWxfcHN0YXRlX2FkanVzdF9idXN5X3BzdGF0ZShjcHUpOwor
CisJaW50ZWxfcHN0YXRlX3NldF9zYW1wbGVfdGltZShjcHUpOwogfQogCiAjZGVmaW5lIElDUFUo
bW9kZWwsIHBvbGljeSkgXApAQCAtMTA3OCwxOSArMTEwMSwyNCBAQCBzdGF0aWMgaW50IGludGVs
X3BzdGF0ZV9pbml0X2NwdSh1bnNpZ25lZCBpbnQgY3B1bnVtKQogCiAJY3B1LT5jcHUgPSBjcHVu
dW07CiAKLQlpZiAoaHdwX2FjdGl2ZSkgeworCWlmIChod3BfYWN0aXZlKQogCQlpbnRlbF9wc3Rh
dGVfaHdwX2VuYWJsZShjcHUpOwotCQlwaWRfcGFyYW1zLnNhbXBsZV9yYXRlX21zID0gNTA7Ci0J
CXBpZF9wYXJhbXMuc2FtcGxlX3JhdGVfbnMgPSA1MCAqIE5TRUNfUEVSX01TRUM7Ci0JfQogCiAJ
aW50ZWxfcHN0YXRlX2dldF9jcHVfcHN0YXRlcyhjcHUpOwogCisJaW5pdF90aW1lcl9kZWZlcnJh
YmxlKCZjcHUtPnRpbWVyKTsKKwljcHUtPnRpbWVyLmRhdGEgPSAodW5zaWduZWQgbG9uZyljcHU7
CisJY3B1LT50aW1lci5leHBpcmVzID0gamlmZmllcyArIEhaLzEwMDsKKworCWlmICghaHdwX2Fj
dGl2ZSkKKwkJY3B1LT50aW1lci5mdW5jdGlvbiA9IGludGVsX3BzdGF0ZV90aW1lcl9mdW5jOwor
CWVsc2UKKwkJY3B1LT50aW1lci5mdW5jdGlvbiA9IGludGVsX2h3cF90aW1lcl9mdW5jOworCiAJ
aW50ZWxfcHN0YXRlX2J1c3lfcGlkX3Jlc2V0KGNwdSk7Ci0JaW50ZWxfcHN0YXRlX3NhbXBsZShj
cHUsIDApOworCWludGVsX3BzdGF0ZV9zYW1wbGUoY3B1KTsKIAotCWNwdS0+dXBkYXRlX3V0aWwu
ZnVuYyA9IGludGVsX3BzdGF0ZV91cGRhdGVfdXRpbDsKLQljcHVmcmVxX3NldF91cGRhdGVfdXRp
bF9kYXRhKGNwdW51bSwgJmNwdS0+dXBkYXRlX3V0aWwpOworCWFkZF90aW1lcl9vbigmY3B1LT50
aW1lciwgY3B1bnVtKTsKIAogCXByX2RlYnVnKCJpbnRlbF9wc3RhdGU6IGNvbnRyb2xsaW5nOiBj
cHUgJWRcbiIsIGNwdW51bSk7CiAKQEAgLTExNzQsOSArMTIwMiw3IEBAIHN0YXRpYyB2b2lkIGlu
dGVsX3BzdGF0ZV9zdG9wX2NwdShzdHJ1Y3QgY3B1ZnJlcV9wb2xpY3kgKnBvbGljeSkKIAogCXBy
X2RlYnVnKCJpbnRlbF9wc3RhdGU6IENQVSAlZCBleGl0aW5nXG4iLCBjcHVfbnVtKTsKIAotCWNw
dWZyZXFfc2V0X3VwZGF0ZV91dGlsX2RhdGEoY3B1X251bSwgTlVMTCk7Ci0Jc3luY2hyb25pemVf
c2NoZWQoKTsKLQorCWRlbF90aW1lcl9zeW5jKCZhbGxfY3B1X2RhdGFbY3B1X251bV0tPnRpbWVy
KTsKIAlpZiAoaHdwX2FjdGl2ZSkKIAkJcmV0dXJuOwogCkBAIC0xMjQwLDcgKzEyNjYsNiBAQCBz
dGF0aWMgaW50IGludGVsX3BzdGF0ZV9tc3JzX25vdF92YWxpZCh2b2lkKQogc3RhdGljIHZvaWQg
Y29weV9waWRfcGFyYW1zKHN0cnVjdCBwc3RhdGVfYWRqdXN0X3BvbGljeSAqcG9saWN5KQogewog
CXBpZF9wYXJhbXMuc2FtcGxlX3JhdGVfbXMgPSBwb2xpY3ktPnNhbXBsZV9yYXRlX21zOwotCXBp
ZF9wYXJhbXMuc2FtcGxlX3JhdGVfbnMgPSBwaWRfcGFyYW1zLnNhbXBsZV9yYXRlX21zICogTlNF
Q19QRVJfTVNFQzsKIAlwaWRfcGFyYW1zLnBfZ2Fpbl9wY3QgPSBwb2xpY3ktPnBfZ2Fpbl9wY3Q7
CiAJcGlkX3BhcmFtcy5pX2dhaW5fcGN0ID0gcG9saWN5LT5pX2dhaW5fcGN0OwogCXBpZF9wYXJh
bXMuZF9nYWluX3BjdCA9IHBvbGljeS0+ZF9nYWluX3BjdDsKQEAgLTE0NDIsOCArMTQ2Nyw3IEBA
IG91dDoKIAlnZXRfb25saW5lX2NwdXMoKTsKIAlmb3JfZWFjaF9vbmxpbmVfY3B1KGNwdSkgewog
CQlpZiAoYWxsX2NwdV9kYXRhW2NwdV0pIHsKLQkJCWNwdWZyZXFfc2V0X3VwZGF0ZV91dGlsX2Rh
dGEoY3B1LCBOVUxMKTsKLQkJCXN5bmNocm9uaXplX3NjaGVkKCk7CisJCQlkZWxfdGltZXJfc3lu
YygmYWxsX2NwdV9kYXRhW2NwdV0tPnRpbWVyKTsKIAkJCWtmcmVlKGFsbF9jcHVfZGF0YVtjcHVd
KTsKIAkJfQogCX0K
--001a1143d3122da975052f45cf5a--
