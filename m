From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [RFC][PATCH] PM: Update device power management
	document
Date: Mon, 15 Mar 2010 13:32:06 -0700
Message-ID: <4B9E9946.20001__24244.0220005394$1268685225$gmane$org@xenotime.net>
References: <201003142103.19420.rjw@sisk.pl> <4B9DA9F4.7040906@xenotime.net>
	<201003152104.24882.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201003152104.24882.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 03/15/10 13:04, Rafael J. Wysocki wrote:
> 
> Updated patch is appended.
> 
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: PM: Update device power management document
> 
> The device PM document, Documentation/power/devices.txt, is badly
> outdated and requires total rework to fit the current design of the
> PM framework.  Make it more up to date.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Reviewed-by: Randy Dunlap <randy.dunlap@oracle.com>

> ---
>  Documentation/power/devices.txt |  722 ++++++++++++++++++++++++----------------
>  1 file changed, 443 insertions(+), 279 deletions(-)
> 
> Index: linux-2.6/Documentation/power/devices.txt
> ===================================================================
> --- linux-2.6.orig/Documentation/power/devices.txt
> +++ linux-2.6/Documentation/power/devices.txt


-- 
~Randy
