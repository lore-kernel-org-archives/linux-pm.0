From: jfannin@gmail.com (Joseph Fannin)
Subject: Hibernating To Swap Considered Harmful
Date: Fri, 13 Jul 2007 01:42:48 -0400
Message-ID: <20070713054244.GA20082@nineveh.local>
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<200707121453.49616.rjw@sisk.pl>
	<Pine.LNX.4.64.0707121150460.25614@asgard.lang.hm>
	<200707122134.29991.rjw@sisk.pl>
	<Pine.LNX.4.64.0707121953440.25614@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707121953440.25614@asgard.lang.hm>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david@lang.hm
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, "Huang,
	Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Thu, Jul 12, 2007 at 08:06:43PM -0700, david@lang.hm wrote:
> On Thu, 12 Jul 2007, Rafael J. Wysocki wrote:

> > Plus we need to figure out how to avoid corrupting filesystems and
> > swap in use by the "old" kernel and its processes (hint: a separate
> > "hibernation partition" is a no-go).
>
> I thought the existing hibernation wrote to the swap partition as it's
> dedicated space?
>
> I didn't know that anyone was suggesting writing the hibernation image to
> a filesystem that the kernel was activly accessing.

I'm suggesting a dedicated, preallocated hibernation *file*, right
now.  There's no way around it, if hibernation is to be reliable --
otherwise hibernation can fail if the system has used enough of its
swap space, so that there isn't enough room to write the hibernate
image.

Even if it's desirable to allow hibernation to fail if the system is
too deep into swap, it's a moot point.

Consider how the need to ensure that there is enough space to write
the hibernate image is dealt with now:  by making a big honking swap
space, so big that enough of it is all but guaranteed to be free,
except under the heaviest of memory usage.  So the space is already
reserved -- and now that it's commingled with actual swap, you have the
need to pass the swap data structures between the two kernels.

Consider instead,  you set up two swap spaces, one regular, and one
for hibernation. You don't touch the "hibernation swap" unless the
other is full -- I think just setting a lower priority on the swap
space is enough for this.  Before you jump to the hibernate kernel,
you swapoff that hibernate swap.

If you can't swapoff the hibernate swap, hibernate fails right there.

If you can, you have your space for writing the image, free and clear
of any of the original kernel's internal state.  There isn't any need
to treat that space as swap any more at all -- the only reason to do
so would be to reuse the existing code.

Setting aside two partitions for swap is obviously undesireable, but
thankfully, Linux supports swap *files*.

There hasn't been a performance penalty to using a swap file (vs. a
partition) since sometime in the 2.5 series.  Well, swap files can be
fragmented, but that needs to be considered against the *guaranteed*
seeks you'll see with a swap partition on the same disk as a busy
filesystem, as is the usual case.

The only reasons I can see that Linux usually uses a single swap
partition are that that's how it's always been done, and because
swsusp doesn't support anything other than a single swap device.  So,
despite Linux supporting those things, you can't actually use a swap
file or (or more than one swap device) if you want hibernation
support.

(Suspend2 has supported swap files for a long time, and I think I
heard that uswsusp supports them now too.)

Once you accept that swap files need to be supported, you're
already going to be supporting everything you need to support a
dedicated hibernation file -- if you don't consider the trouble to
share the swap and hibernate space to be worth the gain.

--
Joseph Fannin
jfannin@gmail.com
