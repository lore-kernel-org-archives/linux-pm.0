From: Greg KH <gregkh@suse.de>
Subject: Re: [RFC][PATCH 1/7] PM: Update kerneldoc comments in
 drivers/base/power/main.c
Date: Wed, 19 Aug 2009 15:06:26 -0700
Message-ID: <20090819220626.GA28558__37510.5946943679$1250719803$gmane$org@suse.de>
References: <200908122218.13975.rjw@sisk.pl> <200908170215.21173.rjw@sisk.pl>
	<200908170216.38401.rjw@sisk.pl> <200908192357.31358.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200908192357.31358.rjw@sisk.pl>
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
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 19, 2009 at 11:57:31PM +0200, Rafael J. Wysocki wrote:
> On Monday 17 August 2009, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > Subject: PM: Update kerneldoc comments in drivers/base/power/main.c
> > 
> > The kerneldoc comments in drivers/base/power/main.c are generally
> > outdated and some of them don't describe the functions very
> > accurately.  Update them and standardize the format to use spaces
> > instead of tabs.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Any objections to this patch from anyone?  Greg, Alan, Randy?

Looks good to me:
	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
