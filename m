From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v8 3/9] i2c: core: call of_i2c_setup_smbus_alert in
 i2c_register_adapter
Date: Fri, 21 Jul 2017 16:33:10 +0200
Message-ID: <20170721163310.1c003963@endymion>
References: <201707200255.SHskJrcM%fengguang.wu@intel.com>
        <c6e4dce0-853f-a4d4-be64-ef4bb0f68162@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <c6e4dce0-853f-a4d4-be64-ef4bb0f68162@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, jglauber@cavium.com, david.daney@cavium.com, peda@axentia.se, benjamin.tissoires@redhat.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Phil,

On Thu, 20 Jul 2017 12:44:52 +0800, Phil Reid wrote:
> Calling a function in i2c-smbus (module) from i2c-core (builtin) is then a problem.
> 
> However there doesn't seem to be a way (that I can see) to have select statement force I2C_SMBUS=y if I2C=y
> 
> Can I get a hint on what the correct course of action is.

Well, i2c-smbus is supposed to go on top of i2c-core. This means
i2c-smbus can make use of functions from i2c-core but not the other way
around.

So far, the split worked fine because i2c_setup_smbus_alert() was
always called from individual device drivers (typically built as
modules.) It was not supposed to be called from core code, but this is
what you are trying to do now (indirectly.)

I can think of 3 ways to sort it out:
1* (Part of) the code you added (and possibly dependencies thereof)
   should be in i2c-core instead of i2c-smbus.
2* The call you added to i2c-core should in fact be somewhere else (for
   example a dedicated module, which would depend on both i2c-core and
   i2c-smbus).
3* The whole idea of splitting the i2c-smbus code to a separate module
   no longer flies, and i2c-core should be built from i2c-core.c +
   i2c-smbus.c (and CONFIG_I2C_SMBUS becomes a boolean.)

-- 
Jean Delvare
SUSE L3 Support
