From: Phil Reid <preid@electromag.com.au>
Subject: Re: [PATCH v8 3/9] i2c: core: call of_i2c_setup_smbus_alert in
 i2c_register_adapter
Date: Mon, 24 Jul 2017 16:27:21 +0800
Message-ID: <4bb4c374-4934-ce19-7714-728661aa4416@electromag.com.au>
References: <201707200255.SHskJrcM%fengguang.wu@intel.com>
 <c6e4dce0-853f-a4d4-be64-ef4bb0f68162@electromag.com.au>
 <20170721163310.1c003963@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20170721163310.1c003963@endymion>
Content-Language: en-AU
Sender: linux-i2c-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, jglauber@cavium.com, david.daney@cavium.com, peda@axentia.se, benjamin.tissoires@redhat.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

G'day Jean,
On 21/07/2017 22:33, Jean Delvare wrote:
> Hi Phil,
> 
> On Thu, 20 Jul 2017 12:44:52 +0800, Phil Reid wrote:
>> Calling a function in i2c-smbus (module) from i2c-core (builtin) is then a problem.
>>
>> However there doesn't seem to be a way (that I can see) to have select statement force I2C_SMBUS=y if I2C=y
>>
>> Can I get a hint on what the correct course of action is.
> 
> Well, i2c-smbus is supposed to go on top of i2c-core. This means
> i2c-smbus can make use of functions from i2c-core but not the other way
> around.
> 
> So far, the split worked fine because i2c_setup_smbus_alert() was
> always called from individual device drivers (typically built as
> modules.) It was not supposed to be called from core code, but this is
> what you are trying to do now (indirectly.)
> 
> I can think of 3 ways to sort it out:
> 1* (Part of) the code you added (and possibly dependencies thereof)
>     should be in i2c-core instead of i2c-smbus.
> 2* The call you added to i2c-core should in fact be somewhere else (for
>     example a dedicated module, which would depend on both i2c-core and
>     i2c-smbus).
> 3* The whole idea of splitting the i2c-smbus code to a separate module
>     no longer flies, and i2c-core should be built from i2c-core.c +
>     i2c-smbus.c (and CONFIG_I2C_SMBUS becomes a boolean.)
> 
Thanks for the detailed response. That really clears things up for me.

Moving i2c_setup_smbus_alert & of_i2c_setup_smbus_alert to i2c-core-smbus, as per 1*,
seems to fix the problem.



-- 
Regards
Phil Reid
