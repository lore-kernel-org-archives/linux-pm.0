From: Phil Reid <preid@electromag.com.au>
Subject: Re: [PATCH v11 02/10] i2c: i2c-smbus: Move i2c_setup_smbus_alert from
 i2c-smbus to i2c-core-smbus
Date: Mon, 30 Oct 2017 12:23:05 +0800
Message-ID: <1397131b-c22d-9872-dbe0-9b691553cb9e@electromag.com.au>
References: <1503567070-115646-1-git-send-email-preid@electromag.com.au>
 <1503567070-115646-3-git-send-email-preid@electromag.com.au>
 <20171029154408.vmjkpj7ybqyrj3ke@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from anchovy2.45ru.net.au ([203.30.46.146]:40166 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751302AbdJ3EXP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Oct 2017 00:23:15 -0400
In-Reply-To: <20171029154408.vmjkpj7ybqyrj3ke@ninjato>
Content-Language: en-AU
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, jdelvare@suse.com, jglauber@cavium.com, david.daney@cavium.com, peda@axentia.se, benjamin.tissoires@redhat.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org

On 29/10/2017 23:44, Wolfram Sang wrote:
> On Thu, Aug 24, 2017 at 05:31:02PM +0800, Phil Reid wrote:
>> In preparation to adding of_i2c_setup_smbus_alert() move
>> i2c_setup_smbus_alert() to core module. of_i2c_setup_smbus_alert()
>> will call i2c_setup_smbus_alert() and this avoid module dependecy issues.
> 
> I am not very happy with this but don't want to cause another delay. So,
> I hope we can discuss and fix it incrementally.
> 
>  From what it does, I really think both setup_alert functions belong to
> i2c-smbus.c. Three possibilities come to my mind (untested, though):
> 
> a) use try_then_request_module somehow
> 
> b) add to CONFIG_I2C something like:
> 	select I2C_SMBUS if OF
> 
> c) get rid of i2c-smbus.c entirely and move it all into the core
> 
> Dunno if a) or b) have been tried in the course of this series already?
> 
G'day Wolfram, Thanks for reviewing.

Nope hadn't tried either a) or b).
a) is not something I was aware of.
Had a brief play and not sure how to make this work. This gives me the same linking problem.

A variant of b) was tried by selecting I2C_SMBUS from driver modules having smbalert support,
but that caused problems if the i2c core was builtin and the driver was a module. But this looks
to work for me.

A variant of c) with option to exclude the i2c-smbus code still.
Add i2c-smbus to the i2c-core module by:
Change Kconfig I2C_SMBUS to a bool
add i2c-smbus to i2c-core object.
fixup duplicate init_module calls etc.
Possibly also rename i2c-smbus to i2c-smbus-alert?

Let me know your preference and I'll put something together.


-- 
Regards
Phil Reid
