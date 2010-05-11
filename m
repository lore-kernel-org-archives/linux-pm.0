From: Matt Reimer <mattjreimer@gmail.com>
Subject: Re: Is it supposed to be ok to call del_gendisk while
	userspace is frozen?
Date: Tue, 11 May 2010 16:55:38 -0700
Message-ID: <AANLkTikH7DvizJ9340SiksoIWU5KU2n-OCqWc4f_-z9v__22934.4591418796$1273622204$gmane$org@mail.gmail.com>
References: <Pine.LNX.4.44L0.1003032142580.6963-100000@netrider.rowland.org>
	<20100304201548.GA1341@elf.ucw.cz>
	<y2yf383264b1004221640rd1fca614zfa15d7e7984ab3ba@mail.gmail.com>
	<201004230717.07086.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201004230717.07086.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 22, 2010 at 10:17 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday 23 April 2010, Matt Reimer wrote:
>> On Thu, Mar 4, 2010 at 1:15 PM, Pavel Machek <pavel@ucw.cz> wrote:
>> > Hi!
>> >
>> >> > My thought exactly. =A0This is the only approach that also solves t=
he
>> >> > following race:
>> >> >
>> >> > =A0 =A0 A driver is unloaded at the same time as a suspend starts.
>> >> >
>> >> > =A0 =A0 The writeback thread gets frozen.
>> >> >
>> >> > =A0 =A0 Then before the rmmod thread is frozen, it calls del_gendis=
k.
>> >> >
>> >> > Delaying things by means of a workqueue (or the equivalent) might a=
lso
>> >> > work, but it doesn't seem as safe. =A0For example, some important
>> >> > writebacks might end up getting delayed until too late.
>> >
>> > Delaying writebacks during sleep should be ok... That's why we do
>> > sync() after userspace is frozen -- nothing really important should be
>> > waiting for writeback after that point.
>>
>> Has this been fixed,
>
> No, it hasn't.
>
>> or has a consensus about how to fix this been
>> achieved? I'm hitting the same problem and have some time to work on a
>> fix.
>
> Generally, it looks like del_gendisk should thaw writeback threads, but n=
ot
> during suspend, only during resume.

Thawing the writeback thread only during resume does fix the case
Maxim originally presented:

0. build kernel with CONFIG_MMC_UNSAFE_RESUME
1. insert SD card
2. suspend
3. remove SD card while suspended
4. resume from suspend hangs

But if CONFIG_MMC_UNSAFE_RESUME is not set, the kernel oopses during
suspend because the MMC device suspend times out:

mmc0: card e624 removed
**** DPM device timeout: pxa2xx-mci.0 (pxa2xx-mci)
kernel BUG at /home/mreimer/sdg/android/android-2.1/kernel/drivers/base/pow=
er/main.c:453!
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd =3D c0004000
[00000000] *pgd=3D00000000
Internal error: Oops: 817 [#1] PREEMPT

If I thaw the writeback thread unconditionally in del_gendisk() then
suspend and resume work as expected for both CONFIG_MMC_UNSAFE_RESUME
set/not set, even when the card is removed while suspended.

So what is the proper fix?

Matt
