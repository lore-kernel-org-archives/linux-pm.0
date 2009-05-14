From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] pm: remove unused asm/suspend.h
Date: Thu, 14 May 2009 12:09:52 +0900
Message-ID: <aec7e5c30905132009u6aa82b2dq2e119d9712730b49@mail.gmail.com>
References: <20090512131606.7984.69575.sendpatchset@rx1.opensource.se>
	<20090512193200.GA22728@elf.ucw.cz>
	<aec7e5c30905130304r38796bf4if741f53435bb5cb3@mail.gmail.com>
	<200905131524.06055.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905131524.06055.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, May 13, 2009 at 10:24 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Wednesday 13 May 2009, Magnus Damm wrote:
>> On Wed, May 13, 2009 at 4:32 AM, Pavel Machek <pavel@ucw.cz> wrote:
>> > On Tue 2009-05-12 22:16:06, Magnus Damm wrote:
>> >>
>> >> From: Magnus Damm <damm@igel.co.jp>
>> >>
>> >> This patch removes unused asm/suspend.h files for
>> >> the following architectures:
>> >>
>> >> =A0alpha, arm, ia64, m68k, mips, s390, um
>> >>
>> >> Signed-off-by: Magnus Damm <damm@igel.co.jp>
>> >
>> > Are you sure? arm does support suspend...
>>
>> Not sure, but these days <asm/suspend.h> is only included from
>> kernel/power/disk.c. And that file is only built if CONFIG_HIBERNATION
>> is set. I've grepped for arch_prepare_suspend and
>> ARCH_HIBERNATION_POSSIBLE but I don't get any matches under
>> arch/arm...
>>
>> Or am I misunderstanding? =3D)
>
> Sounds reasonable, but have you actually tested compilation on the
> architectures you're changing?

No, I have not. However, grepping shows that it's pretty safe:

$ find . | xargs grep asm/suspend

(files in arch/powerpc, arch/x86, arch/sh and kernel/power/disk.c)

Basically, the patch is doing further cleanups on top of:

http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
it;h=3Da8af78982ff4c0b3731527b0217d286a343a3089

Since that patch is included upstream already it is safe to assume
that <asm/suspend.h> is only needed by architectures setting
ARCH_HIBERNATION_POSSIBLE. Which means powerpc, x86 and sh. The rest
of the header files can go away.

Still want me to compile test for all architectures affected?

Thanks,

/ magnus
