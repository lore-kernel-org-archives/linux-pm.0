From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v8 3/9] i2c: core: call of_i2c_setup_smbus_alert in
 i2c_register_adapter
Date: Fri, 21 Jul 2017 11:37:59 +0200
Message-ID: <20170721093759.GD11387@mail.corp.redhat.com>
References: <201707200255.SHskJrcM%fengguang.wu@intel.com>
 <c6e4dce0-853f-a4d4-be64-ef4bb0f68162@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34142 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753388AbdGUJiJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 21 Jul 2017 05:38:09 -0400
Content-Disposition: inline
In-Reply-To: <c6e4dce0-853f-a4d4-be64-ef4bb0f68162@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, jdelvare@suse.com, jglauber@cavium.com, david.daney@cavium.com, peda@axentia.se, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org

On Jul 20 2017 or thereabouts, Phil Reid wrote:
> On 20/07/2017 02:30, kbuild test robot wrote:
> > 
> 
> I understand how this is occurring.
> I2C=y, OF=y and I2C_PARPORT=m
> I2C_PARPORT selects I2C_SMBUS setting it to m
> 
> Calling a function in i2c-smbus (module) from i2c-core (builtin) is then a problem.
> 
> However there doesn't seem to be a way (that I can see) to have select statement force I2C_SMBUS=y if I2C=y

What if I2C selects I2C_SMBUS directly?

Cheers,
Benjamin

> 
> Can I get a hint on what the correct course of action is.
> 
> 
> 
> -- 
> Regards
> Phil Reid
> 
