From: Dave Chinner <david@fromorbit.com>
Subject: Re: Massive ext4 filesystem corruption after a
	failed	s2disk/ram cycle
Date: Sun, 8 Nov 2009 19:29:05 +1100
Message-ID: <20091108082905.GA25494__48438.9616446153$1257783272$gmane$org@discord.disaster>
References: <87vdisq7bh.fsf@rimspace.net>
	<20091007161604.GA28849@infradead.org>
	<20091104111125.54C3.A69D9226@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20091104111125.54C3.A69D9226@jp.fujitsu.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Cc: Daniel Pittman <daniel@rimspace.net>, linux-kernel <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 04, 2009 at 11:18:05AM +0900, KOSAKI Motohiro wrote:
> > On Wed, Oct 07, 2009 at 01:14:10PM +1100, Daniel Pittman wrote:
> > > For what it is worth, I would also be quite interested to know
> > > /why/ XFS is bad in this regard.  Is it just the previously
> > > stated "XFS writes to disk despite freezing kernel threads"
> > > issue, or something deeper?
> > 
> > sync pushes out all data to disk, but in a journaling filesystem
> > that might just but the log not the "normal" place on disk.  For
> > a boot loader to deal with it properly it actually needs to do
> > an replay of the log.  Grub does so for reiserfs but not for XFS
> > for some reason.  I don't know why problems don't trigger more
> > often with ext3, though.
> 
> I'm sorry for the long delayed and offtopic responce. I discussed
> this issue with okuji-san (GRUB2 maintainer) at several month ago.
> He really wish linux implement real sync.
> 
> A bootloader has much constraint than OS (mainly caused by size
> constraint).  it can't implemnt jornal log replay logic for _all_
> filesystem.  Why can't we implement storong sync syscall? I don't
> think this is PM nor bootloader fault.

We already have an ioctl that does what you want: FIFREEZE.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
