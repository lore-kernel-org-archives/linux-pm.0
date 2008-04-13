From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/3] PM: Introduce new top level suspend and
	hibernation callbacks (rev. 7)
Date: Sun, 13 Apr 2008 15:31:09 +0200
Message-ID: <200804131531.11650.rjw__21752.8934627355$1208093944$gmane$org@sisk.pl>
References: <200804040111.15255.rjw@sisk.pl> <200804040112.45769.rjw@sisk.pl>
	<20080412002302.GA27656@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080412002302.GA27656@kroah.com>
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
To: Greg KH <greg@kroah.com>
Cc: Nigel Cunningham <ncunningham@crca.org.au>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, 12 of April 2008, Greg KH wrote:
> On Fri, Apr 04, 2008 at 01:12:44AM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Introduce 'struct pm_ops' and 'struct pm_ext_ops' ('ext' meaning
> > 'extended') representing suspend and hibernation operations for bus
> > types, device classes, device types and device drivers.
> 
> <snip>
> 
> This is probably because I took a few days to merge this, but it doesn't
> apply to my tree anymore, with some wierd merge errors that I don't
> think I can easily resolve without having to totally guess as to what it
> should be (the apm_32.c area especially...)
> 
> Care to respin these patches?

Sure, they'll go in replies to this message.  They include a couple of fixes
from Andrew that are in -mm.

I have tested them on top of the current linux-next with
pm-remove-destroy_suspended_device.patch, so they should apply to your tree
this time.

> Sorry for the delay. 

No big deal.

Thanks,
Rafael
