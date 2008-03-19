From: Greg KH <greg@kroah.com>
Subject: Re: [RFC][PATCH 1/3] PM: Introduce new top level suspend
	and	hibernation callbacks
Date: Tue, 18 Mar 2008 17:53:40 -0700
Message-ID: <20080319005340.GC8298@kroah.com>
References: <200803170020.55473.rjw@sisk.pl> <200803170022.30345.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200803170022.30345.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 17, 2008 at 12:22:29AM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Introduce 'struct pm_ops' representing a set of suspend and
> hibernation operations for bus types, device classes and device
> types.

Ok, I must have missed the thread describing why we need to do this, so,
why do we need to do this?  What is this going to buy us in the end
after everything is changed?

> +struct pm_ops {
> +#ifdef CONFIG_PM_SLEEP
> +	int (*prepare)(struct device *dev);
> +	void (*complete)(struct device *dev);
> +#endif
> +#ifdef CONFIG_SUSPEND
> +	int (*suspend)(struct device *dev);
> +	int (*resume)(struct device *dev);
> +#endif
> +#ifdef CONFIG_HIBERNATION
> +	int (*freeze)(struct device *dev);
> +	int (*thaw)(struct device *dev);
> +	int (*poweroff)(struct device *dev);
> +	int (*quiesce)(struct device *dev);
> +	int (*restore)(struct device *dev);
> +	int (*recover)(struct device *dev);
> +#endif


Don't ifdef stuff like this, it only causes ifdefs to be needed to the
.c code as well for all places these structures are defined in
drivers/busses, right?

thanks,

greg k-h
