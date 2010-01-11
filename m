From: Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH] DRM / i915: Fix resume regression on MSI
	Wind U100 w/o KMS
Date: Tue, 12 Jan 2010 09:05:34 +1000
Message-ID: <21d7e9971001111505ydf12687nbcb752e38efd493c__31622.7915733636$1263251285$gmane$org@mail.gmail.com>
References: <201001090045.33784.rjw@sisk.pl> <201001112204.36724.rjw@sisk.pl>
	<20100111214355.GA11456@radis.liafa.jussieu.fr>
	<201001112322.14152.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001112322.14152.rjw@sisk.pl>
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
Cc: Dave Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Julien Cristau <jcristau@debian.org>, pm list <linux-pm@lists.linux-foundation.org>, dri-devel@lists.sourceforge.net, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 12, 2010 at 8:22 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Monday 11 January 2010, Julien Cristau wrote:
>> On Mon, Jan 11, 2010 at 22:04:36 +0100, Rafael J. Wysocki wrote:
>>
>> > Hmm, are you trying to say radeon is better at that?
>> >
>> > My experience is quite the opposite to be honest.
>> >
>> radeon kms is in staging, doesn't pretend to be stable and force all
>> users to the experimental paths. =A0So yes, I would say radeon is better
>> at that.
>
> I guess I should have been more precise.
>
> All of my test boxes with ATI/AMD graphics hardware regressed after upgra=
ding
> from openSUSE 11.1 to openSUSE 11.2, in different ways, because of the us=
er
> space part of the radeon driver. =A0Of course, you can argue that the dri=
stro
> picked up particularly bad release of the driver, but from the user's poi=
nt of
> view it actually doesn't matter whether the breakage is in the kernel par=
t or
> in the user space part of the driver. =A0The difference is, however, that=
 the
> breakage in the kernel is fixed _way_ faster than the breakage in the user
> space, so I very much prefer the Intel people pushing new features aggres=
sively
> and fixing bugs related to that, then the situation where I need to deal =
with
> the broken user space driver, while the KMS radeon is still not reliable
> enough.
>
> IOW, if your user space driver worked 100% of the time, I'd totally agree=
, but
> that's not the case, at least as far as I see it.
>

Are you using the Novell radeonhd driver? (I think SuSE default to this for=
 all
cards > r500).

This isn't the driver that is developed by the opensource community and
really your distro is where you complain about that sort of regression.

The wierd thing is we see distro picking up fixes for userspace
drivers *much* quicker
if their teams are the on the ball since they are only a small
component to upgrade,
with the kernel you find most distro fire and forget, so if 2.6.31
doesn't work on your
hw you'll wait 6 months to find out that 2.634 doesn't work either.

Since ppl aren't targetting stable properly distros are left to fend
for themselves
when it comes to backporting large amounts of changes, and you find most
distros just don't bother.

Dave.
