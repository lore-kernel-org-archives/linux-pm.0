From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/6] PM: Introduce PM links framework
Date: Fri, 28 Aug 2009 11:16:40 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908281114520.4116-100000__3965.47273635424$1251472756$gmane$org@iolanthe.rowland.org>
References: <200908262220.11750.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908262220.11750.rjw@sisk.pl>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 26 Aug 2009, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Introduce a framework for representing off-tree PM dependencies
> between devices.
> 
> There are PM dependencies between devices that are not reflected by
> the structure of the device tree.  In other words, as far as PM is
> concerned, a device may depend on some other devices which are not
> its children and none of which is its parent.
> 
> Every such dependency involves two devices, one of which is a
> "master" and the other of which is a "slave", meaning that the
> "slave" have to be suspended before the "master" and cannot be
> woken up before it.  Thus every device can be given two lists of
> "dependency objects", one for the dependencies where the device is
> the "master" and the other for the dependencies where the device is
> the "slave".  Then, each "dependency object" can be represented as


> Index: linux-2.6/drivers/base/power/common.c
> ===================================================================
> --- /dev/null
> +++ linux-2.6/drivers/base/power/common.c

> +/**
> + * device_for_each_master - Execute given function for each master of a device.
> + * @slave: Device whose masters to execute the function for.
> + * @data: Data pointer to pass to the function.
> + * @fn: Function to execute for each master of @slave.
> + *
> + * The function is executed for the parent of the device, if there is one, and
> + * for each device connected to it via a pm_link object where @slave is the
> + * "slave".
> + */
> +int device_for_each_master(struct device *slave, void *data,
> +			   int (*fn)(struct device *dev, void *data))
> +{
> +	struct pm_link *link;
> +	int idx;
> +	int error = 0;
> +
> +	if (slave->parent) {
> +		error = fn(slave->parent, data);
> +		if (error)
> +			return error;
> +	}
> +
> +	idx = srcu_read_lock(&pm_link_ss);
> +
> +	list_for_each_entry(link, &slave->power.slave_links, slave_hook) {

This needs to use list_for_each_entry_rcu.  Likewise in
device_for_each_slave().

Alan Stern
