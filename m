From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 3/5] PM / Hibernate: separate block_io
Date: Wed, 28 Apr 2010 07:52:44 +0200
Message-ID: <20100428055244.GA3501@ucw.cz>
References: <1272356118-10012-1-git-send-email-jslaby@suse.cz>
	<1272356118-10012-3-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1272356118-10012-3-git-send-email-jslaby@suse.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: linux-pm@lists.linux-foundation.org, Nigel Cunningham <ncunningham@crca.org.au>, linux-kernel@vger.kernel.org, jirislaby@gmail.com
List-Id: linux-pm@vger.kernel.org

Hi!

> Move block I/O operations to a separate file. It is because it will
> be used later not only by the swap writer.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Nigel Cunningham <ncunningham@crca.org.au>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>

> +++ b/kernel/power/block_io.c
> @@ -0,0 +1,103 @@
> +/*
> + * This file provides functions for block I/O operations on swap/file.
> + *
> + * Copyright (C) 1998,2001-2005 Pavel Machek <pavel@suse.cz>

That address no longer works, but keeps popping up....

> diff --git a/kernel/power/power.h b/kernel/power/power.h
> index b1e207d..006270f 100644
> --- a/kernel/power/power.h
> +++ b/kernel/power/power.h
> @@ -142,6 +142,15 @@ extern int swsusp_read(unsigned int *flags_p);
>  extern int swsusp_write(unsigned int flags);
>  extern void swsusp_close(fmode_t);
>  
> +/* kernel/power/block_io.c */
> +extern struct block_device *hib_resume_bdev;

It is slightly sad that this is now not only static, but also
cross-module...


> +extern int hib_bio_read_page(pgoff_t page_off, void *addr,
> +		struct bio **bio_chain);
> +extern int hib_bio_write_page(pgoff_t page_off, void *addr,
> +		struct bio **bio_chain);
> +extern int hib_wait_on_bio_chain(struct bio **bio_chain);
> +

Does the documentation usually go to the header in these cases?

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
