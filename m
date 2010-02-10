From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 8/9] PCI / ACPI / PM: Platform support for
	PCI PME wake-up (rev. 7)
Date: Thu, 11 Feb 2010 00:25:39 +0100
Message-ID: <201002110025.39316.rjw__45251.0219686248$1265844370$gmane$org@sisk.pl>
References: <201001101431.38630.rjw@sisk.pl> <201002102358.00359.rjw@sisk.pl>
	<20100210230438.GC17115@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100210230438.GC17115@us.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Gary Hade <garyhade@us.ibm.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Moore,
	Robert" <robert.moore@intel.com>, linux-pm@lists.linux-foundation.org, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Thursday 11 February 2010, Gary Hade wrote:
> On Wed, Feb 10, 2010 at 11:58:00PM +0100, Rafael J. Wysocki wrote:
> > On Wednesday 10 February 2010, Gary Hade wrote:
...
> > > Yes, 6/9 also appeared to be the most likely suspect to me and
> > > I was already doing what you asked except in the opposite order.
> > > With 1/9 through 6/9 both the hot-add and hot-remove issues still
> > > reproduced.  After removing 6/9 both issues disappeared.
> > 
> > Thanks for verifying, I've already started to look for bugs in it.
> 
> Thanks!
> 
> > 
> > What's your kernel command line, BTW?
> 
> root=/dev/disk/by-id/scsi-35000c5000036ffcb-part7 ip=9.47.66.9:9.47.67.50:9.47.66.1:255.255.254.0 resume=/dev/disk/by-id/scsi-35000c50000370247-part3 crashkernel=256M-:128M console=tty0 console=ttyS0,115200 pci=use_crs pci=norom

Thanks.  We found a bug in the patch, but it would require you to use a
specific command line switch to trigger, which you don't use.

I'll let you know if I have anything to test.

Rafael
