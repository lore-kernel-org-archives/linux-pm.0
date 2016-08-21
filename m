From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH 2/5] firmware: Add basic support for TI System Control
 Interface (TI-SCI) protocol
Date: Sun, 21 Aug 2016 21:50:04 +0530
Message-ID: <5d03a04f-9184-10e4-43c9-8834e8a39545@ti.com>
References: <20160819225159.10758-1-nm@ti.com>
 <20160819225159.10758-3-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([198.47.19.12]:41313 "EHLO arroyo.ext.ti.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751515AbcHUQV1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 21 Aug 2016 12:21:27 -0400
In-Reply-To: <20160819225159.10758-3-nm@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: Russ Dill <Russ.Dill@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, "Andrew F . Davis" <afd@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org



On 8/20/2016 4:21 AM, Nishanth Menon wrote:
> Texas Instrument's System Control Interface (TI-SCI) Message Protocol
> is used in Texas Instrument's System on Chip (SoC) such as those
> in keystone family K2G SoC to communicate between various compute
> processors with a central system controller entity.
> 
> TI-SCI message protocol provides support for management of various
> hardware entities within the SoC. Add support driver to allow
> communication with system controller entity within the SoC using the
> mailbox client.
> 
> We introduce the basic registration and query capability for the
> driver protocol as part of this change. Subsequent patches add in
> functionality specific to the TI-SCI features.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---

[..snip..]

> +
> +static int ti_sci_remove(struct platform_device *pdev)
> +{
> +	struct ti_sci_info *info;
> +	int ret = 0;
> +
> +	info = platform_get_drvdata(pdev);
> +
> +	mutex_lock(&ti_sci_list_mutex);
> +	if (info->users)
> +		ret = -EBUSY;
> +	else
> +		list_del(&info->node);
> +	mutex_unlock(&ti_sci_list_mutex);

shouldn't the mbox channels be freed in remove?

mbox_free_channel(info->chan_tx);
mbox_free_channel(info->chan_rx);

Thanks and regards,
Lokesh

> +
> +	if (!ret)
> +		ti_sci_debugfs_destroy(pdev, info);
> +
> +	return ret;
> +}
> +
> +static struct platform_driver ti_sci_driver = {
> +	.probe = ti_sci_probe,
> +	.remove = ti_sci_remove,
> +	.driver = {
> +		   .name = "ti-sci",
> +		   .of_match_table = of_match_ptr(ti_sci_of_match),
> +	},
> +};
> +module_platform_driver(ti_sci_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("TI System Control Interface(SCI) driver");
> +MODULE_AUTHOR("Nishanth Menon");
> +MODULE_ALIAS("platform:ti-sci");
> diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
> new file mode 100644
> index 000000000000..e9dc53f26e0e
> --- /dev/null
> +++ b/drivers/firmware/ti_sci.h
> @@ -0,0 +1,93 @@
> +/*
> + * Texas Instruments System Control Interface (TISCI) Protocol
> + *
> + * Communication protocol with TI SCI hardware
> + * The system works in a message response protocol
> + * See: http://processors.wiki.ti.com/index.php/TISCI for details
> + *
> + * Copyright (C)  2015-2016 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions
> + * are met:
> + *
> + *   Redistributions of source code must retain the above copyright
> + *   notice, this list of conditions and the following disclaimer.
> + *
> + *   Redistributions in binary form must reproduce the above copyright
> + *   notice, this list of conditions and the following disclaimer in the
> + *   documentation and/or other materials provided with the
> + *   distribution.
> + *
> + *   Neither the name of Texas Instruments Incorporated nor the names of
> + *   its contributors may be used to endorse or promote products derived
> + *   from this software without specific prior written permission.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> + * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> + * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
> + * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
> + * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
> + * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> + * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
> + * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> + * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
> + * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + *
> + */
> +
> +#ifndef __TI_SCI_H
> +#define __TI_SCI_H
> +
> +/* Generic Messages */
> +#define TI_SCI_MSG_ENABLE_WDT	0x0000
> +#define TI_SCI_MSG_WAKE_RESET	0x0001
> +#define TI_SCI_MSG_VERSION	0x0002
> +#define TI_SCI_MSG_WAKE_REASON	0x0003
> +#define TI_SCI_MSG_GOODBYE	0x0004
> +
> +/**
> + * struct ti_sci_msg_hdr - Generic Message Header for All messages and responses
> + * @type:	Type of messages: One of TI_SCI_MSG* values
> + * @host:	Host of the message
> + * @seq:	Message identifier indicating a transfer sequence
> + * @flags:	Flag for the message
> + */
> +struct ti_sci_msg_hdr {
> +	u16 type;
> +	u8 host;
> +	u8 seq;
> +#define TI_SCI_MSG_FLAG(val)			(1 << (val))
> +#define TI_SCI_FLAG_REQ_GENERIC_NORESPONSE	0x0
> +#define TI_SCI_FLAG_REQ_ACK_ON_RECEIVED		TI_SCI_MSG_FLAG(0)
> +#define TI_SCI_FLAG_REQ_ACK_ON_PROCESSED	TI_SCI_MSG_FLAG(1)
> +#define TI_SCI_FLAG_RESP_GENERIC_NACK		0x0
> +#define TI_SCI_FLAG_RESP_GENERIC_ACK		TI_SCI_MSG_FLAG(1)
> +	/* Additional Flags */
> +	u32 flags;
> +} __packed;
> +
> +/**
> + * struct ti_sci_msg_resp_version - Response for a message
> + * @hdr:		Generic header
> + * @firmware_description: String describing the firmware
> + * @firmware_revision:	Firmware revision
> + * @abi_major:		Major version of the ABI that firmware supports
> + * @abi_minor:		Minor version of the ABI that firmware supports
> + *
> + * In general, ABI version changes follow the rule that minor version increments
> + * are backward compatible. Major revision changes in ABI may not be
> + * backward compatible.
> + *
> + * Response to a generic message with message type TI_SCI_MSG_VERSION
> + */
> +struct ti_sci_msg_resp_version {
> +	struct ti_sci_msg_hdr hdr;
> +	char firmware_description[32];
> +	u16 firmware_revision;
> +	u8 abi_major;
> +	u8 abi_minor;
> +} __packed;
> +
> +#endif /* __TI_SCI_H */
> diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
> new file mode 100644
> index 000000000000..e73483fd5327
> --- /dev/null
> +++ b/include/linux/soc/ti/ti_sci_protocol.h
> @@ -0,0 +1,69 @@
> +/*
> + * Texas Instruments System Control Interface Protocol
> + *
> + * Copyright (C) 2015-2016 Texas Instruments Incorporated - http://www.ti.com/
> + *	Nishanth Menon
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef __TISCI_PROTOCOL_H
> +#define __TISCI_PROTOCOL_H
> +
> +/**
> + * struct ti_sci_version_info - version information structure
> + * @abi_major:	Major ABI version. Change here implies risk of backward
> + *		compatibility break.
> + * @abi_minor:	Minor ABI version. Change here implies new feature addition,
> + *		or compatible change in ABI.
> + * @firmware_revision:	Firmware revision (not usually used).
> + * @firmware_description: Firmware description (not usually used).
> + */
> +struct ti_sci_version_info {
> +	u8 abi_major;
> +	u8 abi_minor;
> +	u16 firmware_revision;
> +	char firmware_description[32];
> +};
> +
> +/**
> + * struct ti_sci_handle - Handle returned to TI SCI clients for usage.
> + * @version:	structure containing version information
> + */
> +struct ti_sci_handle {
> +	struct ti_sci_version_info version;
> +};
> +
> +#if IS_ENABLED(CONFIG_TI_SCI_PROTOCOL)
> +const struct ti_sci_handle *ti_sci_get_handle(struct device *dev);
> +int ti_sci_put_handle(const struct ti_sci_handle *handle);
> +const struct ti_sci_handle *devm_ti_sci_get_handle(struct device *dev);
> +
> +#else	/* CONFIG_TI_SCI_PROTOCOL */
> +
> +static inline const struct ti_sci_handle *ti_sci_get_handle(struct device *dev)
> +{
> +	return ERR_PTR(-EINVAL);
> +}
> +
> +static inline int ti_sci_put_handle(const struct ti_sci_handle *handle)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline
> +const struct ti_sci_handle *devm_ti_sci_get_handle(struct device *dev)
> +{
> +	return ERR_PTR(-EINVAL);
> +}
> +
> +#endif	/* CONFIG_TI_SCI_PROTOCOL */
> +
> +#endif	/* __TISCI_PROTOCOL_H */
> 
