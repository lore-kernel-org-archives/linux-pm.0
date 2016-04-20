From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V4 2/2] thermal: generic-adc: Add ADC based thermal
 sensor driver
Date: Wed, 20 Apr 2016 16:43:23 -0700
Message-ID: <20160420234322.GA2558@localhost.localdomain>
References: <1461050521-6080-1-git-send-email-ldewangan@nvidia.com>
 <1461050521-6080-2-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33176 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029AbcDTXn1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Apr 2016 19:43:27 -0400
Content-Disposition: inline
In-Reply-To: <1461050521-6080-2-git-send-email-ldewangan@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: jic23@kernel.org, robh@kernel.org, rui.zhang@intel.com, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org

Laxman,

On Tue, Apr 19, 2016 at 12:52:01PM +0530, Laxman Dewangan wrote:
> In some of platform, thermal sensors like NCT thermistors are
> connected to the one of ADC channel. The temperature is read by
> reading the voltage across the sensor resistance via ADC. Lookup
> table for ADC read value to temperature is referred to get
> temperature. ADC is read via IIO framework.
> 
> Add support for thermal sensor driver which read the voltage across
> sensor resistance from ADC through IIO framework.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>

I really like this driver, as I mentioned  before. Just one comment
though.

> 
> +
> +	gti->tz_dev = thermal_zone_of_sensor_register(&pdev->dev, 0,
> +						      gti, &gadc_thermal_ops);

Why not using the devm_ version you introduced?

Any particular reason?

