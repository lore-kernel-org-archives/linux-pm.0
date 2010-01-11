From: Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH] DRM / i915: Fix resume regression on MSI
	Wind U100 w/o KMS
Date: Tue, 12 Jan 2010 06:12:37 +1000
Message-ID: <21d7e9971001111212h1ded5292l94d514c6f5a47cd4__32087.5384648845$1263240903$gmane$org@mail.gmail.com>
References: <201001090045.33784.rjw@sisk.pl>
	<alpine.LFD.2.00.1001081548320.7821@localhost.localdomain>
	<alpine.DEB.2.00.1001090214220.21286@skynet.skynet.ie>
	<20100108185041.7aae6c01@jbarnes-piketon>
	<20100109120141.GA4319@localhost.localdomain>
	<alpine.LFD.2.00.1001091012080.7821@localhost.localdomain>
	<21d7e9971001091332v23ac0e28m1b1890cd667aacb8@mail.gmail.com>
	<20100111083825.4c2bb7b3@jbarnes-piketon>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100111083825.4c2bb7b3@jbarnes-piketon>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Dave Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>, Jerome Glisse <glisse@freedesktop.org>, pm list <linux-pm@lists.linux-foundation.org>, dri-devel@lists.sourceforge.net, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 12, 2010 at 2:38 AM, Jesse Barnes <jbarnes@virtuousgeek.org> wr=
ote:
> On Sun, 10 Jan 2010 07:32:30 +1000
> Dave Airlie <airlied@gmail.com> wrote:
>> I'm in the 2-3 years at a minimum, with at least one kernel with no
>> serious regressions in Intel KMS, which we haven't gotten close to
>> yet. I'm not even sure the Intel guys are taking stable seriously
>> enough yet. So far I don't think there is one kernel release (even
>> stable) that works on all Intel chipsets without
>> backporting patches. 2.6.32 needs the changes to remove the messed up
>> render clock hacks which should really have been reverted a lot
>> earlier since we had a lot of regression reports. The number of users
>> using powersave=3D0 to get anything approaching useable is growing etc.
>
> But you could apply that argument to the existing DRM code (not just
> Intel) as well; lots of things are broken or unimplemented and never
> get fixed. =A0I'd say the right metric isn't whether regressions are
> introduced (usually due to new features) but whether the driver is
> better than the old userspace code. =A0For Intel at least, I think we're
> already there. =A0The quality of the kernel driver is higher and it has
> many more features than the userspace implementation ever did. =A0That's
> just my subjective opinion, but I've done a *lot* of work on our bugs
> both in userspace and in the kernel, so I think it's an accurate
> statement.

The problem is at any single point in time I'm not sure a kms kernel
exists that works across all the Intel hw, which from a distro POV is a real
pain in the ass, a regression gets fixed on one piece of hw just as
another on a different piece gets introduced.

I'd really like if Intel devs could either slow it down and do more testing
before pushing to Linus, or be a lot quicker with the reverts when stuff
is identified. The main thing is the render reclocking lately, thats been a
nightmare and as far as I can see 2.6.32.3 still has all the issues,

>
> It doesn't have to happen anytime soon, I was just thinking that
> removing the old, pre-KMS code would make it easier to avoid
> introducing regressions since we'd have one less config (a bit one
> atthat) to worry about.

Maybe in 3-4 years.

Dave.
