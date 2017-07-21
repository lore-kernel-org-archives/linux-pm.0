From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v8 3/9] i2c: core: call of_i2c_setup_smbus_alert in
 i2c_register_adapter
Date: Fri, 21 Jul 2017 16:45:33 +0200
Message-ID: <20170721164533.54855e1d@endymion>
References: <201707200255.SHskJrcM%fengguang.wu@intel.com>
        <c6e4dce0-853f-a4d4-be64-ef4bb0f68162@electromag.com.au>
        <20170721093759.GD11387@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33389 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753859AbdGUOpi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 21 Jul 2017 10:45:38 -0400
In-Reply-To: <20170721093759.GD11387@mail.corp.redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Phil Reid <preid@electromag.com.au>, kbuild test robot <lkp@intel.com>, kbuild-all@01.org, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, jglauber@cavium.com, david.daney@cavium.com, peda@axentia.se, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org

Hi Benjamin,

On Fri, 21 Jul 2017 11:37:59 +0200, Benjamin Tissoires wrote:
> On Jul 20 2017 or thereabouts, Phil Reid wrote:
> > On 20/07/2017 02:30, kbuild test robot wrote:  
> > >   
> > 
> > I understand how this is occurring.
> > I2C=y, OF=y and I2C_PARPORT=m
> > I2C_PARPORT selects I2C_SMBUS setting it to m
> > 
> > Calling a function in i2c-smbus (module) from i2c-core (builtin) is then a problem.
> > 
> > However there doesn't seem to be a way (that I can see) to have select statement force I2C_SMBUS=y if I2C=y  
> 
> What if I2C selects I2C_SMBUS directly?

Selecting I2C_SMBUS is what device drivers are indeed supposed to do.
However doing it from i2c-core seems awkward, because i2c-smbus itself
depends on i2c-core. If they end up both built in, I guess it will be
fine. But if they are modular, I'm afraid you won't be able to load the
modules, because each of them requires the other to be loaded first for
proper symbol resolution.

-- 
Jean Delvare
SUSE L3 Support
