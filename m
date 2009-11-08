From: Christoph Hellwig <hch@infradead.org>
Subject: Re: Massive ext4 filesystem corruption after a
	failed	s2disk/ram cycle
Date: Sun, 8 Nov 2009 11:49:13 -0500
Message-ID: <20091108164913.GA12053__43875.4636132673$1257699041$gmane$org@infradead.org>
References: <87vdisq7bh.fsf@rimspace.net>
	<20091007161604.GA28849@infradead.org>
	<20091104111125.54C3.A69D9226@jp.fujitsu.com>
	<20091108082905.GA25494@discord.disaster>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20091108082905.GA25494@discord.disaster>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dave Chinner <david@fromorbit.com>
Cc: Daniel Pittman <daniel@rimspace.net>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, linux-kernel <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun, Nov 08, 2009 at 07:29:05PM +1100, Dave Chinner wrote:
> We already have an ioctl that does what you want: FIFREEZE.

Doesn't really help as there is not guarentee important metadata is
modified again before the bootloader accesses it, but that's a fate
share with any other kind of super sync.  The only way to really fix
the problem is to implement proper (in-memory) log recovery in the
bootloader, especially as it doesn't only have to deal with the
relatively easy case of clean shutdowns but also needs to deal with the
case of an unclean shutdown with major amounts of updates to the lookup
and allocation data structures in the log.

IMHO the best option is to have a separate partition for /boot with a
very simple filesystem that we can expect boot loader developers to
implement fully and correctly.
