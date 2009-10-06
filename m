From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: Massive ext4 filesystem corruption after a failed
 s2disk/ram cycle
Date: Wed, 07 Oct 2009 01:02:25 +0200
Message-ID: <1254870145.11561.8.camel@maxim-laptop>
References: <1254863215.11577.23.camel@maxim-laptop>
	<20091006214214.GC17883@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091006214214.GC17883@mit.edu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Theodore Tso <tytso@mit.edu>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2009-10-06 at 17:42 -0400, Theodore Tso wrote: 
> On Tue, Oct 06, 2009 at 11:06:55PM +0200, Maxim Levitsky wrote:
> > 
> > Just prior to 2.6.32 cycle I tried -next tree and noticed that after a
> > failed s2ram (here it works only once, and I test once in a whileto see
> > if fixed accidentally) I got a minor filesystem corruption. I am sorry I
> > didn't report that back then.
> 
> When you say filesystem corruption, it's important to indicate whether
> you meant that (a) you noticed that some files were had corrupted
> contents, (b) the kernel complained that the filesystem was corrupted,
> and remounted the filesystem read-only, or (c) e2fsck found and fixed
> errors.
> 
> Also, when you found errors of either class (a) or (b), did you run
> e2fsck to find and fix any potential errors?  In a few places it
> sounded like the kernel had complained about errors, but you had
> ignored them and hadn't run e2fsck to fix them.  I hope that was just
> me misunderstanding what you wrote!  Can you clarify?

Sure, kernel noticed errors, and remounted the filesystem R/O (I didn't
write anything down. really sorry)

I had rebooted the system.
Then startup scripts had booted the system to root shell

I had run fsck on the filesystem. It had plenty of files with shared
blocks, many orphaned inodes, errors in free bitmaps.


Then, after the fsck, I got many missing files (many probably went to
lost+found), some had garbage, some became truncated (0 size)

Mostly were affected files that were from recent dpkg update.


I use ubuntu 9.10, and (almost) latest -git of kernel tree.


Best regards,
Maxim Levitsky
