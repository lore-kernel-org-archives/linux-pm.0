From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 0/3] PM: Asynchronous suspend and resume
Date: Fri, 14 Aug 2009 21:12:38 +0200
Message-ID: <200908142112.38557.rjw__21203.1968091198$1250277255$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0908141044220.2987-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0908141044220.2987-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Friday 14 August 2009, Alan Stern wrote:
> On Thu, 13 Aug 2009, Rafael J. Wysocki wrote:
> 
> > > No, I've only tested it with a few selected drivers.  I'm going to try the
> > > "async everyone" scenario, though.
> > 
> > On HP nx6325 booted with init=/bin/bash it doesn't pass the
> > 'echo devices > /sys/power/pm_test && echo mem > /sys/power/state' test.
> > 
> > The suspend part actually seems to work, but the resume part crashes
> > miserably.
> 
> Any details?  Can you tell where it crashes?

Unfortunately it ends up in a continuous flood of backtraces, so I can't
say much.

However, if I set async_suspend for all PCI devices, as well as for ACPI battery
and i8042, everything apparently works, even with real suspend-resume.

Thanks,
Rafael
