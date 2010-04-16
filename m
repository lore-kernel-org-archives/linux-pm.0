From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v2] runtime pm: add sysfs debug files
Date: Fri, 16 Apr 2010 14:55:02 +0200
Message-ID: <20100416125502.GA7877@comet.dominikbrodowski.net>
References: <20100415174704.GA31336@comet.dominikbrodowski.net>
	<Pine.LNX.4.44L0.1004151429340.1562-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1004151429340.1562-100000@iolanthe.rowland.org>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 15, 2010 at 02:33:02PM -0400, Alan Stern wrote:
> > From: Dominik Brodowski <linux@dominikbrodowski.net>
> > Date: Sun, 11 Apr 2010 15:56:49 +0200
> > Subject: [PATCH] runtime pm: add sysfs debug files
> > 
> > Add a few sysfs files relating to runtime power management for
> > advanced debug purposes:
> > 
> > runtime_enabled: is runtime PM enabled for this device? States
> > 	are "enabled", "disabled", "forbidden" or a combination
> > 	of the latter two.
> > 
> > runtime_status:	what state is the device in currently? E.g., it
> > 	reports "suspended" for runtime-suspended devices, and
> >         "active" for active devices. NOTE: if runtime_enabled
> > 	returns "disabled", the value of this file may not
> > 	reflect its physical state.
> > 
> > runtime_usage: the runtime PM usage count of a device
> > 
> > runtime_active_kids: the runtime PM children usage count of a device, or
> > 	0 if the ignore_children flag is set.
> > 
> > Also, CONFIG_PM_SLEEP_ADVANCED_DEBUG is not defined in any Kconfig
> > file, so replace it with CONFIG_PM_ADVANCED_DEBUG.
> > 
> > Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

Who shall carry it upstream? Or shall I take it directly to Linus?

Best,
	Dominik
