From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 Resend 00/92] CPUFreq Cleanup Series: Part II
Date: Sat, 12 Oct 2013 06:55:59 +0530
Message-ID: <CAKohpokPUFGsecbhTQV++Efw1SCNcvC_drhD5=nQUmbVJEhi4g@mail.gmail.com>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
	<4259753.v7BpD2vKia@vostro.rjw.lan>
	<CAKohponVmnQr-QuPAW-aHyVJYpWX9ODdF5x-RbTdtjrVjn807A@mail.gmail.com>
	<4804152.VMEEXS0eqL@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11c2c0d412048f04e8811e50
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:38960 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751742Ab3JLB0A (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Oct 2013 21:26:00 -0400
Received: by mail-qc0-f177.google.com with SMTP id x12so3467328qcv.22
        for <linux-pm@vger.kernel.org>; Fri, 11 Oct 2013 18:25:59 -0700 (PDT)
In-Reply-To: <4804152.VMEEXS0eqL@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

--001a11c2c0d412048f04e8811e50
Content-Type: text/plain; charset=ISO-8859-1

On 12/10/2013, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Friday, October 11, 2013 07:27:44 PM Viresh Kumar wrote:
>> On 11/10/2013, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> > So I've just added this to bleeding-edge, but I have a couple
>> > complaints.
>>
>> Thanks..
>>
>> > First off, this is three patch sets in one.  The first part is the
>> > generic
>> > .attr(), exit() and .verify() one, the second part is the duplicated
>> > initialization and the third one is about cpufreq_generic_init().  They
>> > really should have been posted and reviewed separately.
>>
>> They were posted and reviewed separately earlier.. Only this time
>> I have merged them together for applying..
>>
>> > And while I'm basically OK with the first and the third part, I'm
>> > concerned
>> > about the second one, because it has potential to introduce some subtle
>> > initialization issues (initializing something twice is not a bug per
>> > se,
>> > although it is inefficient, but failing to initialize that or
>> > initializing
>> > it
>> > with an incorrect value *is* a bug).
>>
>> I agree.. Lets see if it breaks anything... I will get it fixed as soon
>> as
>> possible.. (BTW, there was a fixup for the last series that you missed
>> to apply: fixup! cpufreq: sa11x0: Expose frequency table)
>
> Any links?

https://lkml.org/lkml/2013/10/4/7

Attached again..

--001a11c2c0d412048f04e8811e50
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-fixup-cpufreq-sa11x0-Expose-frequency-table.patch"
Content-Disposition: attachment;
	filename="0001-fixup-cpufreq-sa11x0-Expose-frequency-table.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: file0

RnJvbSBkMmUxZWI5NjllYmRiNjZlM2NjMTk5ZmJiYmUyZTJhMWE4ZTI5NjBiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlkOiA8ZDJlMWViOTY5ZWJkYjY2ZTNjYzE5OWZiYmJlMmUy
YTFhOGUyOTYwYi4xMzgxNTQxMDk4LmdpdC52aXJlc2gua3VtYXJAbGluYXJvLm9yZz4KRnJvbTog
VmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz4KRGF0ZTogRnJpLCA0IE9jdCAy
MDEzIDEwOjQ4OjE2ICswNTMwClN1YmplY3Q6IFtQQVRDSF0gZml4dXAhIGNwdWZyZXE6IHNhMTF4
MDogRXhwb3NlIGZyZXF1ZW5jeSB0YWJsZQoKLS0tCiBhcmNoL2FybS9tYWNoLXNhMTEwMC9nZW5l
cmljLmggfCAzICstLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtc2ExMTAwL2dlbmVyaWMuaCBiL2FyY2gv
YXJtL21hY2gtc2ExMTAwL2dlbmVyaWMuaAppbmRleCBmNTIxNGNlLi4yZDliZWUwIDEwMDY0NAot
LS0gYS9hcmNoL2FybS9tYWNoLXNhMTEwMC9nZW5lcmljLmgKKysrIGIvYXJjaC9hcm0vbWFjaC1z
YTExMDAvZ2VuZXJpYy5oCkBAIC0zLDYgKzMsNyBAQAogICoKICAqIEF1dGhvcjogTmljb2xhcyBQ
aXRyZQogICovCisjaW5jbHVkZSA8bGludXgvY3B1ZnJlcS5oPgogI2luY2x1ZGUgPGxpbnV4L3Jl
Ym9vdC5oPgogCiBleHRlcm4gdm9pZCBzYTExMDBfdGltZXJfaW5pdCh2b2lkKTsKQEAgLTE5LDgg
KzIwLDYgQEAgZXh0ZXJuIHZvaWQgc2ExMXgwX2luaXRfbGF0ZSh2b2lkKTsKIGV4dGVybiB2b2lk
IHNhMTExMF9tYl9lbmFibGUodm9pZCk7CiBleHRlcm4gdm9pZCBzYTExMTBfbWJfZGlzYWJsZSh2
b2lkKTsKIAotc3RydWN0IGNwdWZyZXFfcG9saWN5OwotCiBleHRlcm4gc3RydWN0IGNwdWZyZXFf
ZnJlcXVlbmN5X3RhYmxlIHNhMTF4MF9mcmVxX3RhYmxlW107CiBleHRlcm4gdW5zaWduZWQgaW50
IHNhMTF4MF9mcmVxX3RvX3BwY3IodW5zaWduZWQgaW50IGtoeik7CiBleHRlcm4gaW50IHNhMTF4
MF92ZXJpZnlfc3BlZWQoc3RydWN0IGNwdWZyZXFfcG9saWN5ICpwb2xpY3kpOwotLSAKMS43LjEy
LnJjMi4xOC5nNjFiNDcyZQoK
--001a11c2c0d412048f04e8811e50--
