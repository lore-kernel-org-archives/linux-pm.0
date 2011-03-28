From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 6/7] ARM / Samsung: Use struct syscore_ops
	for "core" power management
Date: Mon, 28 Mar 2011 21:42:21 +0200
Message-ID: <201103282142.21810.rjw__27907.4603728533$1301341372$gmane$org@sisk.pl>
References: <201103280125.11750.rjw@sisk.pl> <201103280129.50192.rjw@sisk.pl>
	<20110327234521.GH9995@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110327234521.GH9995@trinity.fluff.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: Russell King <linux@arm.linux.org.uk>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Kay Sievers <kay.sievers@suse.de>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Monday, March 28, 2011, Ben Dooks wrote:
> On Mon, Mar 28, 2011 at 01:29:49AM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Replace sysdev classes and struct sys_device objects used for "core"
> > power management by Samsung platforms with struct syscore_ops objects
> > that are simpler.
> > 
> > This generally reduces the code size and the kernel memory footprint.
> > It also is necessary for removing sysdevs entirely from the kernel in
> > the future.
> 
> Hmm, does it still allow the system to choose which bits are bound
> depending on the cpu being registered, as for the s3c stuff it isn't
> just about the suspend/resume, it's binding items that get registered
> early in the startup sequence?

The registering is still done through sysdevs, the syscore_ops are only
used for power management.  I did my best to retain the existing flow of
control as far as possible.

Thanks,
Rafael
