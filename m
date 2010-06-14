From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [Regression,
	post-2.6.34] Hibernation broken on machines with radeon/KMS and r300
Date: Mon, 14 Jun 2010 12:00:29 -0400
Message-ID: <AANLkTimQ_yCV5Xdwd_D1zFM1oom2D3ZIBeSczJh4LN1T__27921.4211310775$1276531393$gmane$org@mail.gmail.com>
References: <201006141653.03879.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006141653.03879.rjw@sisk.pl>
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
Cc: linux-kernel@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 14, 2010 at 10:53 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Alex, Dave,
>
> I'm afraid hibernation is broken on all machines using radeon/KMS with r3=
00
> after commit ce8f53709bf440100cb9d31b1303291551cf517f
> (drm/radeon/kms/pm: rework power management). =A0At least, I'm able to re=
produce
> the symptom, which is that the machine hangs hard around the point where =
an
> image is created (probably during the device thaw phase), on two different
> boxes with r300 (the output of lspci from one of them is attached for
> reference, the other one is HP nx6325).
>
> Suspend to RAM appears to work fine at least on one of the affected boxes.
>
> Unfortunately, the commit above changes a lot of code and it's not too ea=
sy to
> figure out what's wrong with it and I didn't have the time to look more i=
nto
> details of this failure. =A0However, it looks like you use .suspend() and
> .resume() callbacks as .freeze() and .thaw() which may not be 100% correct
> (in fact it looks like the "legacy" PCI suspend/resume is used, which is =
not
> recommended any more).
>

Does it work any better after Dave's last drm pull request?  With the
latest changes, pm should not be a factor unless it's explicitly
enabled via sysfs.

Alex

> Thanks,
> Rafael
>
