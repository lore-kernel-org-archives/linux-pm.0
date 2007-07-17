From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Hibernating To Swap Considered Harmful
Date: Tue, 17 Jul 2007 13:52:58 +0200
Message-ID: <200707171352.59642.rjw__19706.6834815361$1184674545$gmane$org@sisk.pl>
References: <200707121453.49616.rjw@sisk.pl>
	<Pine.LNX.4.64.0707162338370.19248@asgard.lang.hm>
	<20070717072601.GA21633@nineveh.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070717072601.GA21633@nineveh.local>
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

On Tuesday, 17 July 2007 09:26, Joseph Fannin wrote:
> On Mon, Jul 16, 2007 at 11:42:08PM -0700, david@lang.hm wrote:
> > On Tue, 17 Jul 2007, Joseph Fannin wrote:
> 
> > >root is free to "dd if=/dev/random of=/dev/mem".  Root owned
> > >daemons which do bad things are bugs.
> >
> > in this case it would be more like
> >
> > dd if=/block0 of=/dev/sda1 count=1 bs=4096 skip=5000
> > dd if=/block1 of=/dev/sda1 count=1 bs=4096 skip=5050
> > dd if=/block2 of=/dev/sda1 count=1 bs=4096 skip=5400
> > etc
> >
> > to write the blocks to the raw parition in the right place
> 
> What I meant by that was that root is allowed to shoot himself in the
> foot.  Nothing stops root from opening a swap/hibernate file, which
> would put it in cache, and cause it to be inconsistant if a
> hibernation image was written to it behind the kernel's back.
> 
> That would be a very stupid thing to do, however.  There's no reason
> to open that file, unless you know *exactly* what you are doing, in
> which case the onus is on you to get it right.
> 
> But you have a point.  The swap file could be very fragmented.  It
> might often be so, even.
> 
> Still, is this better than exporting the kernel's swap internals
> (which has never been a public interface before)?
> 
> Does it make the interface that writing hibernation images to swap
> imposes any better?
> 
> Even if hibernation files are no less complicated to support than
> hibernating to swap files (which isn't a forgone conclusion) , there
> are plenty of reasons writing hibernation images to swap doesn't make
> sense.
> 
> 
> > >Again, supporting swap files (*which is not optional*) requires the
> > >very same support.
> >
> > in the kexec model why would the second kernel care about swap files at
> > all? (unles it chooses to write to them, in which case it is exactly the
> > same support, but unless it writes to them it doesn't need to care)
> 
> My point is that no extra work is required to write hibernation images
> to dedicated files than to write hibernation images to swap files.

This is not true, because for writing into swap files we can use some existing
code and for writing to "dedicated" files some new code needs to be written,
tested etc. (I think there is code like that in tuxonice, though).

> If swap files are to be supported, then, there's no technical reason
> not to support dedicated hibernation files.

Yes there is, we need some more code for that in the kernel.

> Dedicated hibernation files are better, and there's no reason not to
> implement them.

I won't argue that they are not better.  For many people hibernation to swap
files/partitions is sufficient, though.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
