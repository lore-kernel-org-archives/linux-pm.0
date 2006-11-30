From: Peter Jones <pjones@redhat.com>
Subject: Re: [linux-pm] Dangers of touching disk
	between	suspend and resume
Date: Thu, 30 Nov 2006 17:17:47 -0500
Message-ID: <1164925067.6031.29.camel@localhost.localdomain>
References: <1164727307.26898.12.camel@systems03.lan.brontes3d.com>
	<Pine.LNX.4.44L0.0611281034130.3064-100000@iolanthe.rowland.org>
	<20061128163757.GM14640@suse.de>
	<1164916843.6031.9.camel@localhost.localdomain>
	<20061130201311.GK2227@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20061130201311.GK2227@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: Stefan Seyfried <seife@suse.de>
Cc: suspend-devel@lists.sourceforge.net, linux-pm@osdl.org, Alan Stern <stern@rowland.harvard.edu>
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 30, 2006 at 03:00:43PM -0500, I wrote:
> On Tue, 2006-11-28 at 17:37 +0100, Stefan Seyfried wrote:
> 
> > So it is a good idea to tell the engineer to do "mkswap" on the swap
> > partition before putting the disk into the replacement hardware.
> 
> Ugh, no it's not.  You really want the UUID on the swap area to remain
> the same.

In response, on Thu, 2006-11-30 at 21:13 +0100, Stefan Seyfried wrote:
> Well, but the system won't care because it won't resume?
> Or am i missing something?

And On Thu, 2006-11-30 at 15:42 -0500, Daniel Drake wrote:
> Why?
> 
> [not questioning your reasoning, this is coming from someone who knows
> very little about swap structure and what the UUID is used for]

You want to get rid of the resume metadata from it, but you don't want
to create a new swap structure.  Normally it's not a problem, but in
some environments, such as with shared-storage like in a SAN[1], we need
to be able to identify that a swap device is really the one we mean to
be activating; the UUID is one of the best pieces of data we've got.  So
you don't want to start over with a new swap partition, you want to
clear the resume data only.

Granted, I think most distros, if not all, and all the standard tools
totally muck up swap on shared storage right now[0].  But that's no
reason to advocate such a bad habit.  For FC/RHEL making this work right
is at least on my TODO list for the relatively near future.

[0] "swapon -a" activates everything it finds, and that's what most
distros do during boot.  If you can see other machines' swap devices,
that's bad.

[1] If you hate that example, another with the same problem is when
you're running a virtual machine which has its own physical disk
partitions, i.e. vmware with /dev/sdb as its disk.

-- 
  Peter


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
