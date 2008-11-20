From: Pavel Machek <pavel@suse.cz>
Subject: Re: Crash during suspend to disk
Date: Thu, 20 Nov 2008 17:50:39 +0100
Message-ID: <20081120165039.GC23522__28401.6715632335$1227199975$gmane$org@elf.ucw.cz>
References: <1227184916.4855.31.camel@odie.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1227184916.4855.31.camel@odie.local>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Simon Holm Th?gersen <account@cs.aau.dk>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> I hope this information is sufficient to debug my problem, though it
> unfortunately is somewhat incomplete. I took two pictures of the OOPS
> with my mobile phone, but unfortunately the picture of the upper part is
> so blurred that it is unreadable. Apparently I have to be in a hurry
> getting out of the door for this to happen. Here is what I got from the
> lower part

> 
> Call Trace:
>   __blkdev_put
>   swsusp_write
>   hibernate
>   state_store
>   state_store
>   state_store
>   kobj_attr_store
>   sysfs_write_file
>   sysfs_write_file
>   vfs_write
>   sys_write
>   sysenter_do_call
> Code: ......
> EIP: [<...>] iput
> ---[ end trace ........................... ]---

Hmm, I'm afraid this is not enough, not even if the blanks are filled.

> I believe I've seen the same crash before with a 2.6.27 or earlier
> kernel, but I was in a hurry getting out of the door back then as I was
> here. Circumstances was the same though, with already successful suspend
> to disk and the crash appearing during second or third attempt to
> suspend to disk in quick succession.
> 
> I guess I should be able to reproduce the crash with some efforts, but
> I'd like to hear your thoughts on this before I do that.

If you can reproduce that, we can probably debug it...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
