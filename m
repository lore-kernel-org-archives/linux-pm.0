From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [update] Re: [RFC][PATCH] PM / PCI: Update PCI power
 management documentation
Date: Mon, 17 May 2010 15:32:17 -0700
Message-ID: <4BF1C3F1.3000904__31083.4488169805$1274135804$gmane$org@oracle.com>
References: <201005162149.31770.rjw@sisk.pl> <4BF0B1C5.4060601@oracle.com>
	<201005180023.24885.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005180023.24885.rjw@sisk.pl>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On 05/17/10 15:23, Rafael J. Wysocki wrote:
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: PM / PCI: Update PCI power management documentation
> 
> The PCI power management document, Documentation/power/pci.txt, is
> outdated and partially inaccurate.  It also is missing some important
> information about the power management of PCI device.  Rewrite it to
> make it more up to date and more complete.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Thanks for the updates.
Reviewed-by: Randy Dunlap <randy.dunlap@oracle.com>


> ---
>  Documentation/power/pci.txt | 1308 ++++++++++++++++++++++++++++++++++----------
>  1 file changed, 1017 insertions(+), 291 deletions(-)
> 
> Index: linux-2.6/Documentation/power/pci.txt
> ===================================================================
> --- linux-2.6.orig/Documentation/power/pci.txt
> +++ linux-2.6/Documentation/power/pci.txt


-- 
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
