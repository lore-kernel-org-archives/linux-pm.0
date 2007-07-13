From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Hibernating To Swap Considered Harmful
Date: Fri, 13 Jul 2007 11:30:50 +0200
Message-ID: <200707131130.51279.rjw__17389.966621022$1184318713$gmane$org@sisk.pl>
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<Pine.LNX.4.64.0707121953440.25614@asgard.lang.hm>
	<20070713054244.GA20082@nineveh.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070713054244.GA20082@nineveh.local>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Joseph Fannin <jfannin@gmail.com>
Cc: david@lang.hm, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Friday, 13 July 2007 07:42, Joseph Fannin wrote:
> On Thu, Jul 12, 2007 at 08:06:43PM -0700, david@lang.hm wrote:
> > On Thu, 12 Jul 2007, Rafael J. Wysocki wrote:
> 
> > > Plus we need to figure out how to avoid corrupting filesystems and
> > > swap in use by the "old" kernel and its processes (hint: a separate
> > > "hibernation partition" is a no-go).
> >
> > I thought the existing hibernation wrote to the swap partition as it's
> > dedicated space?
> >
> > I didn't know that anyone was suggesting writing the hibernation image to
> > a filesystem that the kernel was activly accessing.
> 
> I'm suggesting a dedicated, preallocated hibernation *file*, right
> now.  There's no way around it, if hibernation is to be reliable --
> otherwise hibernation can fail if the system has used enough of its
> swap space, so that there isn't enough room to write the hibernate
> image.
> 
> Even if it's desirable to allow hibernation to fail if the system is
> too deep into swap, it's a moot point.

If you're afraid of that, use a dedicated swap file.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
