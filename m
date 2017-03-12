From: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH v4 4/5] soc: ti: Add ti_sci_pm_domains driver
Date: Sun, 12 Mar 2017 10:20:51 -0700
Message-ID: <00909b96-8cb1-2c57-6072-f899dae3dcad@oracle.com>
References: <1488882154-21485-1-git-send-email-d-gerlach@ti.com>
 <1488882154-21485-5-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:49270 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934350AbdCLRXf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Mar 2017 13:23:35 -0400
In-Reply-To: <1488882154-21485-5-git-send-email-d-gerlach@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Nishanth Menon <nm@ti.com>, Keerthy <j-keerthy@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Tero Kristo <t-kristo@ti.com>, Sudeep Holla <sudeep.holla@arm.com>

On 3/7/17 2:22 AM, Dave Gerlach wrote:
> Introduce a ti_sci_pm_domains driver to act as a generic pm domain
> provider to allow each device to attach and associate it's ti-sci-id so
> that it can be controlled through the TI SCI protocol.
>
> This driver implements a simple genpd where each device node has a
> phandle to the power domain node and also must provide an index which
> represents the ID to be passed with TI SCI representing the device using
> a single phandle cell. The driver manually parses the phandle to get the
> cell value. Through this interface the genpd dev_ops start and stop
> hooks will use TI SCI to turn on and off each device as determined by
> pm_runtime usage.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
> v3->v4:
>  Parse phandle directly instead of reading ti,sci-id property per device.

Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
