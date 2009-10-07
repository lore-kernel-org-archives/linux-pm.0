From: Jindrich Makovicka <makovick@gmail.com>
Subject: Re: Massive ext4 filesystem corruption after a failed s2disk/ram
 cycle
Date: Wed, 7 Oct 2009 16:25:14 +0200
Message-ID: <20091007162514.6942f538@starbug.prg01.itonis.net>
References: <1254863215.11577.23.camel@maxim-laptop>
	<20091006214214.GC17883@mit.edu>
	<1254870145.11561.8.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759279AbZJGO0b@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Wed, 07 Oct 2009 01:02:25 +0200
Maxim Levitsky <maximlevitsky@gmail.com> wrote:

> On Tue, 2009-10-06 at 17:42 -0400, Theodore Tso wrote: 
> > On Tue, Oct 06, 2009 at 11:06:55PM +0200, Maxim Levitsky wrote:
> > > 
> > > Just prior to 2.6.32 cycle I tried -next tree and noticed that
> > > after a failed s2ram (here it works only once, and I test once in
> > > a whileto see if fixed accidentally) I got a minor filesystem
> > > corruption. I am sorry I didn't report that back then.
> > 
> 
> Sure, kernel noticed errors, and remounted the filesystem R/O (I
> didn't write anything down. really sorry)
> 
> I had rebooted the system.
> Then startup scripts had booted the system to root shell
> 
> I had run fsck on the filesystem. It had plenty of files with shared
> blocks, many orphaned inodes, errors in free bitmaps.
> 
> 
> Then, after the fsck, I got many missing files (many probably went to
> lost+found), some had garbage, some became truncated (0 size)
> 
> Mostly were affected files that were from recent dpkg update.
> 
> 
> I use ubuntu 9.10, and (almost) latest -git of kernel tree.

I encountered something very similar yesterday, with 2.6.32-rc3. When
doing sync after accidentally removing a mounted USB stick, sync got
stuck, so I resorted to SysRq+S/U/B. Unfortunately this was also just
after an apt-get upgrade. The result was the same, corrupted ext4
partitions, shared blocks, orphaned inodes, free bitmap errors.

Only recently written files seem to be affected, in my case
upgraded stuff in / and configuration files in /home.

-- 
Jindrich Makovicka
