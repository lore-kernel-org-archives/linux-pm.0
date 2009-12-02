From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] uswsusp: automatically free the in-memory
 image once s2disk has finished with it
Date: Wed, 2 Dec 2009 22:11:07 +0100
Message-ID: <20091202211107.GA20830__23513.3923277774$1259788449$gmane$org@elf.ucw.cz>
References: <4B1575AC.6080904@tuffmail.co.uk> <20091201214529.GA1457@csn.ul.ie>
	<200912012253.08522.rjw@sisk.pl> <4B16545B.3090703@tuffmail.co.uk>
	<20091202122019.GD1457@csn.ul.ie> <4B16797C.3010304@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4B16797C.3010304@tuffmail.co.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Mel Gorman <mel@csn.ul.ie>, pm list <linux-pm@lists.linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed 2009-12-02 14:28:12, Alan Jenkins wrote:
> The original in-kernel suspend (swsusp) frees the in-memory hibernation
> image before powering off the machine.  s2disk doesn't, so there is
> _much_ less free memory when it tries to power off.
> 
> This is a gratuitous difference.  The userspace suspend interface
> /dev/snapshot only allows the hibernation image to be read once.
> Once the s2disk program has read the last page, we can free the entire
> image.
> 
> This avoids a hang after writing the hibernation image which was
> triggered by commit 5f8dcc21211a3d4e3a7a5ca366b469fb88117f61
> "page-allocator: split per-cpu list into one-list-per-migrate-type":

Yes, you work around page-allocator hang. But is it right thing to do?

I mean... Power down should not be too memory-critical. Why can't new
page allocator handle that?

(And yes, when page allocator is fixed we may want to do something
like that, but...)

								Pavel

> --- a/kernel/power/user.c
> +++ b/kernel/power/user.c
> @@ -165,6 +165,10 @@ static ssize_t snapshot_read(struct file *filp, char __user *buf,
> 			res = -EFAULT;
> 		else
> 			*offp = data->handle.offset;
> +	} else {
> +		swsusp_free();
> +		memset(&data->handle, 0, sizeof(struct snapshot_handle));
> +		data->ready = 0;
> 	}
> 
>  Unlock:

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
