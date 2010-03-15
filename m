From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] i2c: Use generic subsystem-level power
	management callbacks
Date: Mon, 15 Mar 2010 23:06:42 +0100
Message-ID: <201003152306.42083.rjw__30034.6192242161$1268690683$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1003151630370.1332-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1003151630370.1332-100000@iolanthe.rowland.org>
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
Cc: Jean Delvare <khali@linux-fr.org>, pm list <linux-pm@lists.linux-foundation.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Linux I2C <linux-i2c@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday 15 March 2010, Alan Stern wrote:
> On Mon, 15 Mar 2010, Rafael J. Wysocki wrote:
> 
> > In fact, I'd like the "legacy" callbacks to go, at least at the subsystem
> > level, so I'd prefer not to make it easier to keep them around.
> > 
> > How many bus types are there and how many of them actually implement power
> > management callbacks?  I don't really think the issue is so big.
> 
> I have no idea.  But I'm in the middle of implementing runtime PM for
> SCSI.  SCSI already has bus-level legacy callbacks, so to add the
> runtime methods without changing the existing system sleep behavior
> requires something like this.
> 
> The alternative is to write a bunch of tiny "shim" functions, sort of
> like what I ended up doing in the USB stack (see usb_dev_prepare() and
> the following routines in drivers/usb/core/usb.c).

I prefer this approach to changing the core.  If we changed the core, it would
defeat the whole purpose of introducing the new framework.

Rafael
