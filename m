From: Greg KH <greg@kroah.com>
Subject: Re: [linux-pm] [RFC/RFT][PATCH -mm 2/5] swsusp: userland interface (rev. 2)
Date: Wed, 4 Jan 2006 15:49:18 -0800
Message-ID: <20060104234918.GA15983@kroah.com>
References: <200601042340.42118.rjw@sisk.pl> <200601042351.58667.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750764AbWADXyo@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200601042351.58667.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@suse.cz>, Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 04, 2006 at 11:51:58PM +0100, Rafael J. Wysocki wrote:
> +static struct snapshot_dev interface = {
> +	.name = "snapshot",
> +};
> +
> +static ssize_t snapshot_show(struct subsystem * subsys, char *buf)
> +{
> +	return sprintf(buf, "%d:%d\n", MAJOR(interface.devno),
> +		       MINOR(interface.devno));
> +}
> +
> +static struct subsys_attribute snapshot_attr = {
> +	.attr = {
> +		.name = __stringify(snapshot),
> +		.mode = S_IRUGO,
> +	},
> +	.show = snapshot_show,
> +};
> +
> +static int __init snapshot_dev_init(void)
> +{
> +	int error;
> +
> +	error =  alloc_chrdev_region(&interface.devno, 0, 1, interface.name);
> +	if (error)
> +		return error;
> +	cdev_init(&interface.cdev, &snapshot_fops);
> +	interface.cdev.ops = &snapshot_fops;
> +	error = cdev_add(&interface.cdev, interface.devno, 1);
> +	if (error)
> +		goto Unregister;
> +	error = sysfs_create_file(&power_subsys.kset.kobj, &snapshot_attr.attr);

Heh, that's a neat hack, register a sysfs file that contains the
major:minor (there is a function that will print that the correct way,
if you really want to do that), in sysfs.  It's better to just register
a misc character device with the name "snapshot", and then udev will
create your userspace node with the proper major:minor all automatically
for you.

Unless you want to turn these into syscalls :)

thanks,

greg k-h
