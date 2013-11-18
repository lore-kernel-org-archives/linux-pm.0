From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: 3.12: kernel panic when resuming from suspend to RAM (x86_64)
Date: Mon, 18 Nov 2013 13:20:41 +0100
Message-ID: <528A0619.1000507@gmail.com>
References: <52888F6D.6000802@gmail.com> <CAC9WiBggfssh+31_MqVCT-hDf2E8zTuc81q-DhLYQuVF053mEA@mail.gmail.com> <20131117220611.GQ27323@pd.tnic> <4636530.OR894YNbbr@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ee0-f43.google.com ([74.125.83.43]:61597 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237Ab3KRMUo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2013 07:20:44 -0500
In-Reply-To: <4636530.OR894YNbbr@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Borislav Petkov <bp@alien8.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linux PM list <linux-pm@vger.kernel.org>

Le 17/11/2013 23:34, Rafael J. Wysocki a =C3=A9crit :
> On Sunday, November 17, 2013 11:06:12 PM Borislav Petkov wrote:
>> On Sun, Nov 17, 2013 at 09:49:40PM +0100, Francis Moreau wrote:
>>> On Sun, Nov 17, 2013 at 8:53 PM, Borislav Petkov <bp@alien8.de> wro=
te:
>>>> On Sun, Nov 17, 2013 at 07:02:21PM +0100, Francis Moreau wrote:
>>>>> Sorry I haven't taken the original picture large enough, and gett=
ing
>>>>> this kernel panic is pretty hard since the kernel usually display=
s the
>>>>> black screen.
>>>>
>>>> Ok, just try to make a readable picture of the whole line, next ti=
me you
>>>> trigger it.
>>>>
>>>>> I can't find any traces of this function in the dump...
>>>>
>>>> Hmm, strange. Can you upload the whole vmlinux somewhere? Or is th=
is the
>>>> official archlinux kernel? If so, where can I get it from?
>>>
>>> Yes, you can download the bin package from :
>>> https://www.archlinux.org/packages/core/x86_64/linux/
>>>
>>> The bin package is a tar archive, so it pretty straightforward to
>>> unpack the vmlinux file  (actual is filename vmlinuz-linux).
>>
>> Ok, here's what I was able to see: rIP points to call_timer_fn+0x33
>> which is this:
>>
>> ffffffff8106f590 <call_timer_fn>:
>> ffffffff8106f590:       e8 2b b2 48 00          callq  ffffffff814fa=
7c0 <__fentry__>
>> ffffffff8106f595:       55                      push   %rbp
>> ffffffff8106f596:       65 48 8b 04 25 70 c7    mov    %gs:0xc770,%r=
ax
>> ffffffff8106f59d:       00 00=20
>> ffffffff8106f59f:       48 89 e5                mov    %rsp,%rbp
>> ffffffff8106f5a2:       41 57                   push   %r15
>> ffffffff8106f5a4:       49 89 d7                mov    %rdx,%r15
>> ffffffff8106f5a7:       41 56                   push   %r14
>> ffffffff8106f5a9:       49 89 f6                mov    %rsi,%r14
>> ffffffff8106f5ac:       41 55                   push   %r13
>> ffffffff8106f5ae:       41 54                   push   %r12
>> ffffffff8106f5b0:       49 89 fc                mov    %rdi,%r12
>> ffffffff8106f5b3:       53                      push   %rbx
>> ffffffff8106f5b4:       44 8b a8 44 e0 ff ff    mov    -0x1fbc(%rax)=
,%r13d
>> ffffffff8106f5bb:       0f 1f 44 00 00          nopl   0x0(%rax,%rax=
,1)
>> ffffffff8106f5c0:       4c 89 ff                mov    %r15,%rdi
>> ffffffff8106f5c3:       41 ff d6                callq  *%r14			<--- =
faulting insn
>> ffffffff8106f5c6:       0f 1f 44 00 00          nopl   0x0(%rax,%rax=
,1)
>> ffffffff8106f5cb:       65 48 8b 04 25 70 c7    mov    %gs:0xc770,%r=
ax
>> ffffffff8106f5d2:       00 00=20
>> ffffffff8106f5d4:       44 39 a8 44 e0 ff ff    cmp    %r13d,-0x1fbc=
(%rax)
>>
>> and the virtual address in rIP is ffffffff8106f5c3, i.e. the same on=
e
>> as in the photo. Thus, the CALL instruction tries to call the timer
>> function 'fn' which we pass as an argument to call_timer_fn.
>>
>> However, the address we're trying to call in %r14 is garbage:
>> 0x455300323d504544 and not in canonical form, causing the #GP.
>>
>> So basically what happens is suspend to RAM corrupts something
>> containing one or more timer functions and we end up calling crap af=
ter
>> resume.
>>
>> If you want to debug this further, you could try playing through
>> Documentation/power/basic-pm-debugging.txt and see whether suspend t=
o
>> disk works. There's also a section 2 which talks about testing suspe=
nd
>> to RAM which could be of help.
>>
>> But let me add Rafael and Thomas - they should have much better idea=
s
>> than me.
>>
>> Guys, thread starts here:
>> http://marc.info/?l=3Dlinux-kernel&m=3D138468134321335
>=20
> This looks like a softirq bug to me (and related to cpuidle).
>=20
> I'm wondering if that happens with any of the older kernels or just 3=
=2E12?
>=20

I can try to find the old kernel package and see if that happens tonigh=
t.

