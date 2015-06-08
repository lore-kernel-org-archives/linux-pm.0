From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/6] power: hibernate: Use separate messages for "Syncing filesystems"
Date: Tue, 09 Jun 2015 01:35:24 +0200
Message-ID: <5609150.OAJVFt04xE@vostro.rjw.lan>
References: <cover.1433442778.git.joe@perches.com> <1664a8ea72b34db4bef860004166875ab70898ee.1433442778.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60231 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752713AbbFHXJh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jun 2015 19:09:37 -0400
In-Reply-To: <1664a8ea72b34db4bef860004166875ab70898ee.1433442778.git.joe@perches.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org

On Thursday, June 04, 2015 11:36:44 AM Joe Perches wrote:
> Add the ability to see how long it takes to sync the filesystems
> via the printk time mechanism.
> 
> Start to standardize the printk "PM: doing something...done"
> messages on two separate lines.

Well, it would be good to say what problem this is attempting to fix.

And while I understand the underlying concern, there is a merit in keeping
each of these messages in one line (if everything goes well), so I'm wondering
what about printing each of them in one go after the operation with a tail
depending on the result?  Like

printk(KERN_INFO "PM: Syncing filesystems ... done\n");

on success or

printk(KERN_INFO "PM: Syncing filesystems ... failed\n");

on failure?


> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  kernel/power/hibernate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 2329daa..2466d78 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -663,9 +663,9 @@ int hibernate(void)
>  	if (error)
>  		goto Exit;
>  
> -	printk(KERN_INFO "PM: Syncing filesystems ... ");
> +	printk(KERN_INFO "PM: Syncing filesystems ...\n");
>  	sys_sync();
> -	printk("done.\n");
> +	printk(KERN_INFO "PM: Syncing filesystems: done\n");
>  
>  	error = freeze_processes();
>  	if (error)
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
