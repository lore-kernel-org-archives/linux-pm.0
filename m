From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/2] Freezer: Fix JFFS2 garbage collector
	freezing issue
Date: Tue, 4 Dec 2007 00:59:05 +0100
Message-ID: <200712040059.05935.rjw__40055.3986001343$1196725415$gmane$org@sisk.pl>
References: <1196624925-17220-1-git-send-email-lenb@kernel.org>
	<200712031755.44441.rjw@sisk.pl> <200712031803.21260.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200712031803.21260.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>, Pete MacKay <armlinux@architechnical.net>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday, 3 of December 2007, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Fix breakage caused by commit d5d8c5976d6adeddb8208c240460411e2198b393
> "freezer: do not send signals to kernel threads" in
> jffs2_garbage_collect_thread() that assumed it would be sent signals
> by the freezer.

Scratch this one.  I'll send an updated version.

The other one is fine, though.

Thanks,
Rafael


> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> Cc: Pete MacKay <armlinux@architechnical.net>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  fs/jffs2/background.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> Index: linux-2.6/fs/jffs2/background.c
> ===================================================================
> --- linux-2.6.orig/fs/jffs2/background.c
> +++ linux-2.6/fs/jffs2/background.c
> @@ -103,15 +103,17 @@ static int jffs2_garbage_collect_thread(
>  		   get there first. */
>  		yield();
>  
> +		/* If system suspend is in progress, go to the refrigerator and
> +		   start again when the suspend is done */
> +		if (try_to_freeze())
> +			goto again;
> +
>  		/* Put_super will send a SIGKILL and then wait on the sem.
>  		 */
>  		while (signal_pending(current)) {
>  			siginfo_t info;
>  			unsigned long signr;
>  
> -			if (try_to_freeze())
> -				goto again;
> -
>  			signr = dequeue_signal_lock(current, &current->blocked, &info);
>  
>  			switch(signr) {
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
