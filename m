From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 3/4] PM/Hibernate: Use memory allocations to
	free	memory (rev. 2)
Date: Sun, 3 May 2009 11:36:59 +0200
Message-ID: <20090503093659.GA10278__1532.06674517623$1241343376$gmane$org@elf.ucw.cz>
References: <nY3-4PrO6XH.A.xtB.yw85JB@chimera>
	<20090502104947.2720f173.akpm@linux-foundation.org>
	<200905030220.57933.rjw@sisk.pl> <200905030224.21471.rjw@sisk.pl>
	<alpine.LFD.2.01.0905021958480.4983@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.01.0905021958480.4983@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, alan-jenkins@tuffmail.co.uk, jens.axboe@oracle.com, Andrew Morton <akpm@linux-foundation.org>, kernel-testers@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > Remove the shrinking of memory from the suspend-to-RAM code, where it is 
> > not really necessary.
> 
> Hmm. Shouldn't we do this _regardless_?
> 
> IOW, shouldn't this be a totally separate patch? It seems to be left-over 
> from when we shared the same code-paths, and before the split of the STR 
> and hibernate code?
> 
> IOW, shouldn't the very _first_ patch just be this part? That code doesn't 
> make any sense anyway (that FREE_PAGE_NUMBER really _is_ totally 
> arbitrary).
> 
> This part seems to be totally independent of all the other parts in your 
> patch-series. No?

I'm not sure this one is a good idea: drivers will need to allocate
memory during suspend/resume, and when processes are frozen/disk
driver is suspended, normal memory management will no longer work.

So, freeing 4M of memory before starting suspend seems like a good
idea. That way those small alocations will not fail.
								Pavel


> @@ -188,9 +188,6 @@ static void suspend_test_finish(const char *label)
>  
>  #endif
>  
> -/* This is just an arbitrary number */
> -#define FREE_PAGE_NUMBER (100)
> -
>  static struct platform_suspend_ops *suspend_ops;
>  
>  /**
> @@ -241,24 +238,10 @@ static int suspend_prepare(void)
>  	if (error)
>  		goto Finish;
>  
> -	if (suspend_freeze_processes()) {
> -		error = -EAGAIN;
> -		goto Thaw;
> -	}
> -
> -	free_pages = global_page_state(NR_FREE_PAGES);
> -	if (free_pages < FREE_PAGE_NUMBER) {
> -		pr_debug("PM: free some memory\n");
> -		shrink_all_memory(FREE_PAGE_NUMBER - free_pages);
> -		if (nr_free_pages() < FREE_PAGE_NUMBER) {
> -			error = -ENOMEM;
> -			printk(KERN_ERR "PM: No enough memory\n");
> -		}
> -	}
> +	error = suspend_freeze_processes();
>  	if (!error)
>  		return 0;
>  
> - Thaw:
>  	suspend_thaw_processes();
>  	usermodehelper_enable();
>   Finish:

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
