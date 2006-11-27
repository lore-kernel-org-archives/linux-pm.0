From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [RFC][PATCH -mm 1/5] PM: Make
 freeze_processes SMP-safe
Date: Sun, 26 Nov 2006 21:41:35 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0611262137100.21990-100000@netrider.rowland.org>
References: <20061126232858.GD13647@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20061126232858.GD13647@elf.ucw.cz>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, suspend-devel@lists.sourceforge.net, pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 27 Nov 2006, Pavel Machek wrote:

> Hi!
> 
> > > If frozen is atomic_t, do we need memory barrier?
> > 
> > I think so.  For example on x86-64 atomic_read() is just a read.
> 
> I'm not sure, but for x86-64 barriers are nops, anyway, IIRC.

atomic_read() does not include its own memory barrier.  If you want one, 
you have to write it yourself.  At least, that's how I interpret 
Documentation/atomic_ops.txt.

Alan Stern


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
