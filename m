From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch]  PM / hibernate: memory corruption in
 resumedelay_setup()
Date: Wed, 14 May 2014 17:56:02 +0200
Message-ID: <20140514155602.GA9723@amd.pavel.ucw.cz>
References: <20140514125720.GC14571@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42792 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755276AbaENP4E (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 14 May 2014 11:56:04 -0400
Content-Disposition: inline
In-Reply-To: <20140514125720.GC14571@mwanda>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Fabian Frederick <fabf@skynet.be>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org

Hi!

> "resume_delay" is not an unsigned long, it's an int, so this will
> corrupt memory on 64 bit systems.

ssleep takes unsigned int.

Variable is int.

We parse it using kstrtoul.

So I'd suggest: switch resume_delay variable to unsigned int, and use
kstrtouint().

> Fixes: 317cf7e5e85e ('PM / hibernate: convert simple_strtoul to kstrtoul')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 2377ff7..3659b26 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -1115,8 +1115,9 @@ static int __init resumewait_setup(char *str)
>  
>  static int __init resumedelay_setup(char *str)
>  {
> -	int rc = kstrtoul(str, 0, (unsigned long *)&resume_delay);
> +	int rc;
>  
> +	rc = kstrtoint(str, 0, &resume_delay);

...and if possible, keep it on one line.

Thanks,
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
