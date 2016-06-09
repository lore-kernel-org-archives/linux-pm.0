From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: RFI: devm_power_supply_register and sys/class name
Date: Thu, 9 Jun 2016 12:22:32 +0200
Message-ID: <CAJKOXPdJ=9gKs=HrmaxxbRMSw6Q6PqZJ-RFuUQ=YSmJKUfy9Sg@mail.gmail.com>
References: <44d06e13-714a-c91a-6d7c-1aaa83758e7f@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:34263 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbcFIKWe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jun 2016 06:22:34 -0400
Received: by mail-oi0-f42.google.com with SMTP id e72so56030485oib.1
        for <linux-pm@vger.kernel.org>; Thu, 09 Jun 2016 03:22:33 -0700 (PDT)
In-Reply-To: <44d06e13-714a-c91a-6d7c-1aaa83758e7f@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>
Cc: linux-pm@vger.kernel.org

On Thu, Jun 9, 2016 at 11:39 AM, Phil Reid <preid@electromag.com.au> wrote:
> G'day All,
>
> I'm implementing a driver for a sbs manager chip (ltc1760) and running into
> a problem.
> This is a dual smart battery charger ic.
>
> Our hard has two of these connected via a i2c / smbus mux.
>
> One registering the second device with devm_power_supply_register  I am
> getting a warning
> in regards duplicate sysfs entries.
> The first device creates this entry
> /sys/class/power_supply/sbs-manager/
>
> The second device also creates the same entry.
>
> This name appears to come from power_supply_desc .name field.
>
> Which needs to exists for the lifetime of the driver.
> So I'm assuming I need to allocate local memory for this struct in the
> driver and set a unique name.
>
> Is this the correct way to go or should devm_power_supply_register be made
> more
> flexible to ensure unique names?

Hi,

You need to provide one power_supply_desc per power supply instance.
So in your case - you need two of them (with different names). Look at
other drivers doing this.

Best regards,
Krzysztof
