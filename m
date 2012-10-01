From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RFC PATCH 5/6] ACPI: Introduce ACPI I2C controller enumeration
 driver
Date: Mon, 1 Oct 2012 09:55:26 +0300
Message-ID: <20121001065526.GH15548@intel.com>
References: <1348818032.10877.325.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1348818032.10877.325.camel-fuY85erJQUO75v1z/vFq2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-pm <linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Len, Brown" <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Sep 28, 2012 at 03:40:32PM +0800, Zhang Rui wrote:
> +acpi_status __init i2c_enumerate_slave(acpi_handle handle, u32 level,
> +				       void *data, void **return_value)
> +{
> +	int result;
> +	acpi_status status;
> +	struct acpi_buffer buffer;
> +	struct acpi_resource *resource;
> +	struct acpi_resource_gpio *gpio;
> +	struct acpi_resource_i2c_serialbus *i2c;
> +	int i;
> +	struct acpi_i2c_root *root = data;
> +	struct i2c_board_info info;
> +	struct acpi_device *device;
> +
> +	if (acpi_bus_get_device(handle, &device))
> +		return AE_OK;
> +
> +	status = acpi_get_current_resources(handle, &buffer);
> +	if (ACPI_FAILURE(status)) {
> +		dev_err(&device->dev, "Failed to get ACPI resources\n");
> +		return AE_OK;
> +	}
> +
> +	for (i = 0; i < buffer.length; i += sizeof(struct acpi_resource)) {
> +		resource = (struct acpi_resource *)(buffer.pointer + i);
> +
> +		switch (resource->type) {
> +		case ACPI_RESOURCE_TYPE_GPIO:
> +			gpio = &resource->data.gpio;
> +
> +			if (gpio->connection_type == ACPI_RESOURCE_GPIO_TYPE_INT) {
> +				result =
> +				    acpi_device_get_gpio_irq
> +				    (gpio->resource_source.string_ptr,
> +				     gpio->pin_table[0], &info.irq);

acpi_device_get_gpio_irq() is not defined in this patch series?

Also you need to do the gpio_request()/gpio_to_irq() things somewhere. Are
they handled in acpi_device_get_gpio_irq()?

How about GpioIo resources?

> +				if (result)
> +					dev_err(&device->dev,
> +						"Failed to get IRQ\n");
> +			}
> +			break;
> +		case ACPI_RESOURCE_TYPE_SERIAL_BUS:
> +			i2c = &resource->data.i2c_serial_bus;
> +
> +			info.addr = i2c->slave_address;
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	add_slave(root, &info);
> +
> +	kfree(buffer.pointer);
> +	return AE_OK;
> +}
> +
> +static int __devinit acpi_i2c_root_add(struct acpi_device *device)
> +{
> +	acpi_status status;
> +	struct acpi_i2c_root *root;
> +	struct resource *resources;
> +	int result;
> +
> +	if (!device->pnp.unique_id) {
> +		dev_err(&device->dev,
> +			"Unsupported ACPI I2C controller. No UID\n");

Where does this restriction come from? As far as I understand UID is
optional.

> +		return -ENODEV;
> +	}
> +
> +	root = kzalloc(sizeof(struct acpi_i2c_root), GFP_KERNEL);
> +	if (!root)
> +		return -ENOMEM;
> +
> +	root->device = device;
> +
> +	kstrtoint(device->pnp.unique_id, 10, &root->busnum);
> +
> +	/* enumerate I2C controller */
> +	root->pdev =
> +	    platform_device_alloc(acpi_device_hid(device), root->busnum);
> +	if (!root->pdev) {
> +		dev_err(&device->dev, "Failed to alloc platform device\n");
> +		goto err;
> +	}
> +
> +	result = acpi_get_generic_resources(device, &resources);
> +	if (result < 0) {
> +		dev_err(&device->dev, "Failed to get resources\n");
> +		goto err;
> +	}
> +
> +	platform_device_add_resources(root->pdev, resources, result);
> +	platform_device_add(root->pdev);
> +
> +	/* enumerate I2C slave devices */
> +	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, root->device->handle, 1,
> +				     i2c_enumerate_slave, NULL, root, NULL);
> +
> +	if (ACPI_FAILURE(status)) {
> +		dev_err(&root->device->dev, "i2c ACPI namespace walk error!\n");
> +		kfree(root);
> +		return -ENODEV;
> +	}
> +
> +	register_slaves(root);
> +
> +	return 0;
> +err:
> +	kfree(root);
> +	return -ENODEV;
> +}
