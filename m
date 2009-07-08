From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Patch 2/2: Add compression support to swsusp.
Date: Wed, 8 Jul 2009 10:03:32 +0200
Message-ID: <20090708080331.GA13403__1292.6627802246$1247040293$gmane$org@elf.ucw.cz>
References: <4A518FBD.7050102@crca.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4A518FBD.7050102@crca.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, TuxOnIce-devel <tuxonice-devel@lists.tuxonice.net>
List-Id: linux-pm@vger.kernel.org


> @@ -437,7 +439,7 @@ static int enough_swap(unsigned int nr_pages)
>  	unsigned int free_swap = count_swap_pages(root_swap, 1);
>  
>  	pr_debug("PM: Free swap pages: %u\n", free_swap);
> -	return free_swap > (nr_pages + PAGES_FOR_IO) * 1.01;
> +	return free_swap > (nr_pages + PAGES_FOR_IO) * .6;
>  }
>  
>  /**

This is buggy and was buggy before. We may not use floating point in
kernel...



								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
