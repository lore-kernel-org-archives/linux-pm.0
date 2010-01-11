From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] DRM / i915: Fix resume regression on MSI
	Wind U100 w/o KMS
Date: Mon, 11 Jan 2010 23:22:14 +0100
Message-ID: <201001112322.14152.rjw__45465.2429711588$1263248574$gmane$org@sisk.pl>
References: <201001090045.33784.rjw@sisk.pl> <201001112204.36724.rjw@sisk.pl>
	<20100111214355.GA11456@radis.liafa.jussieu.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100111214355.GA11456@radis.liafa.jussieu.fr>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Julien Cristau <jcristau@debian.org>
Cc: Dave Airlie <airlied@linux.ie>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, pm list <linux-pm@lists.linux-foundation.org>, dri-devel@lists.sourceforge.net, Dave Airlie <airlied@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Monday 11 January 2010, Julien Cristau wrote:
> On Mon, Jan 11, 2010 at 22:04:36 +0100, Rafael J. Wysocki wrote:
> 
> > Hmm, are you trying to say radeon is better at that?
> > 
> > My experience is quite the opposite to be honest.
> > 
> radeon kms is in staging, doesn't pretend to be stable and force all
> users to the experimental paths.  So yes, I would say radeon is better
> at that.

I guess I should have been more precise.

All of my test boxes with ATI/AMD graphics hardware regressed after upgrading
from openSUSE 11.1 to openSUSE 11.2, in different ways, because of the user
space part of the radeon driver.  Of course, you can argue that the dristro
picked up particularly bad release of the driver, but from the user's point of
view it actually doesn't matter whether the breakage is in the kernel part or
in the user space part of the driver.  The difference is, however, that the
breakage in the kernel is fixed _way_ faster than the breakage in the user
space, so I very much prefer the Intel people pushing new features aggressively
and fixing bugs related to that, then the situation where I need to deal with
the broken user space driver, while the KMS radeon is still not reliable
enough.

IOW, if your user space driver worked 100% of the time, I'd totally agree, but
that's not the case, at least as far as I see it.

Rafael
