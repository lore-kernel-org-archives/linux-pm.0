From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH -next] Hibernate: Take overlapping zones into
	account
Date: Tue, 11 Nov 2008 13:07:15 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811111300580.4480__31082.4659224183$1226427098$gmane$org@localhost.localdomain>
References: <200811081356.13060.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <200811081356.13060.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@suse.cz>, Andy Whitcroft <apw@shadowen.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Dave Hansen <dave@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org



On Sat, 8 Nov 2008, Rafael J. Wysocki wrote:

> Hi Len,
> 
> Please add this patch to the suspend branch.

Please re-send a checkpatch clean version.

Also, the comments on this patch (and the next) are mal-formed.
The commit message must be before the first "---" and the throw-away
comments must be after it, rather thant the reverse.

I ask others to get this right, so it seems most fair that I do the
same for you -- otherwise your next patch will have the same problems
and others will follow your example of not sending the "perfect patch"

thanks,
-Len


> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: Hibernate: Take overlapping zones into account
> 
> It has been requested to make hibernation work with memory
> hotplugging enabled and for this purpose the hibernation code has to
> be reworked to take the possible overlapping of zones into account.
> Thus, rework the hibernation memory bitmaps code to prevent
> duplication of PFNs from occuring and add checks to make sure that
> one page frame will not be marked as saveable many times.
> 
> Additionally, use list.h lists instead of open-coded lists to
> implement the memory bitmaps.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> Cc: Pavel Machek <pavel@suse.cz>
> Cc: Dave Hansen <dave@linux.vnet.ibm.com>
> Cc: Andy Whitcroft <apw@shadowen.org>
> ---
>  kernel/power/snapshot.c |  331 ++++++++++++++++++++++++------------------------
>  1 file changed, 169 insertions(+), 162 deletions(-)
> 
> Index: linux-2.6/kernel/power/snapshot.c
> ===================================================================
> --- linux-2.6.orig/kernel/power/snapshot.c
> +++ linux-2.6/kernel/power/snapshot.c
> @@ -25,6 +25,7 @@
