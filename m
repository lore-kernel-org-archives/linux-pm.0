From: Phil Reid <preid@electromag.com.au>
Subject: Re: [RFC v2 2/3] i2c: Kconfig: rename variable I2C_SMBUS to
 I2C_SMBUS_ALERT
Date: Wed, 29 Nov 2017 09:58:44 +0800
Message-ID: <21647bb9-0818-8823-0935-87b270a80f26@electromag.com.au>
References: <1511840309-37964-1-git-send-email-preid@electromag.com.au>
 <1511840309-37964-3-git-send-email-preid@electromag.com.au>
 <20171128230855.20bb64be@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from anchovy2.45ru.net.au ([203.30.46.146]:52985 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751706AbdK2B6u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Nov 2017 20:58:50 -0500
In-Reply-To: <20171128230855.20bb64be@endymion>
Content-Language: en-AU
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: realmz6@gmail.com, wsa@the-dreams.de, sre@kernel.org, adi-buildroot-devel@lists.sourceforge.net, linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org, benjamin.tissoires@redhat.com

G'day Jean,

Thanks for looking at this.

On 29/11/2017 06:08, Jean Delvare wrote:
> Hi Phil,
> 
> On Tue, 28 Nov 2017 11:38:28 +0800, Phil Reid wrote:
>> i2c-smbus now only contains code related to the smbus_alert driver.
>> Other smbus protocols have been moved from this into the i2c-core-smbus.
>> Change the Kconfig variable name to reflect this.
> 
> Not really. i2c-core-smbus.c contains essentially SMBus transaction
> helpers, which have never been in i2c-smbus.c. They aren't really SMBus
> protocols, more like a subset of I2C transactions suitable for general
> purpose. The only really SMBus protocol specific portion is relative to
> SMBus Alert, and that's only a small part of it. The other supported
> SMBus-specific protocol, Host Notify, is in i2c-core-base.c.
> 
> My original intent was to have all the SMBus protocols specific code in
> one file, controlled by one Kconfig option, which could be built as a
> separate module. I wasn't certain it would be viable, it was a bet
> which I lost, as it turns out there are too many dependencies.
> 
> If the code can no longer build as a separate module, there is no
> benefit in having it in a separate file. Let's just merge it into
> i2c-code-smbus.c, where the rest of the SMBus alert code already is.
> That would make things more simple.
I had to put of_i2c_setup_smbus_alert in there to deal with dependencies.
This was seen as a little messy at the time. It was accepted provided
that I clean things up somehow.

The question is how. This series is just one proposal for that to stir some
discussion. Your approach is certainly the simpler one.

> 
> I also don't think renaming this configuration option and moving code
> to a separate file (as your patch 3/3 does) makes sense. Having a
> separate option for each SMBus-specific protocol seems overkill to me,
> having one for all of them was and still is more reasonable. I wonder
> why the SMBus Notify code does NOT depend on CONFIG_I2C_SMBUS, and why
> it is in i2c-core-base.c instead of i2c-core-smbus.c. Wolfram?
> 
> And more generally, renaming a Kconfig option has a non-trivial cost
> for distribution kernel maintainers, so it shall not be done lightly.
> So you need a clear and strong rationale.

My only rational is that it didn't encompass all the SMBUS specific protocols.
It currently seems a little ambiguous to me. Especially with regard the current
Kconfig help description is not accurate with regard the Host Notify protocol.

> 
>> Signed-off-by: Phil Reid <preid@electromag.com.au>
>> ---
>>   arch/blackfin/configs/BF527-TLL6527M_defconfig |  2 +-
>>   drivers/i2c/Kconfig                            | 11 +++++------
>>   drivers/i2c/Makefile                           |  2 +-
>>   drivers/i2c/busses/Kconfig                     |  8 ++++----
>>   drivers/i2c/i2c-core-smbus.c                   |  2 +-
>>   drivers/i2c/i2c-core.h                         |  2 +-
>>   drivers/power/supply/Kconfig                   |  2 +-
>>   7 files changed, 14 insertions(+), 15 deletions(-)
>> (...)
>> diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
>> index efc3354..fcd4bea 100644
>> --- a/drivers/i2c/Kconfig
>> +++ b/drivers/i2c/Kconfig
>> @@ -55,7 +55,7 @@ config I2C_CHARDEV
>>   	  programs use the I2C bus.  Information on how to do this is
>>   	  contained in the file <file:Documentation/i2c/dev-interface>.
>>   
>> -	  This support is also available as a module.  If so, the module
>> +	  This support is also available as a module.  If so, the module
>>   	  will be called i2c-dev.
>>   
>>   config I2C_MUX
> 
> Please don't mix white-space clean-ups with actual changes. It might
> be tolerated by some maintainers if within a chunk you are already
> touching. But if such a change creates a new patch chunk then it's a
> no-go.
> 
> Your patch 1/3 suffers from similar issues.
> 
>> @@ -84,12 +84,11 @@ config I2C_HELPER_AUTO
>>   
>>   	  In doubt, say Y.
>>   
>> -config I2C_SMBUS
>> -	tristate "SMBus-specific protocols" if !I2C_HELPER_AUTO
>> +config I2C_SMBUS_ALERT
>> +	tristate "SMBus-alert protocol" if !I2C_HELPER_AUTO
> 
> "SMBus Alert" is the correct spelling.
> 
>>   	help
>> -	  Say Y here if you want support for SMBus extensions to the I2C
>> -	  specification. At the moment, two extensions are supported:
>> -	  the SMBus Alert protocol and the SMBus Host Notify protocol.
>> +	  Say Y here if you want support for SMBus alert extensions to the I2C
>> +	  specification.
> 
> "extension" without "s".
> 
>>   
>>   	  This support is also available as a module.  If so, the module
>>   	  will be called i2c-smbus.
> 


-- 
Regards
Phil Reid
