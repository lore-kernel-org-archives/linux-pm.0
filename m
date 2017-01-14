From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 0/7] mfd/iio: move the AB8500 GPADC driver to IIO
Date: Sat, 14 Jan 2017 14:48:46 +0000
Message-ID: <3edbf321-ce38-6e40-048c-9cada7ad5a14@kernel.org>
References: <20170110234745.29691-1-linus.walleij@linaro.org>
 <20170112030419.j7ux7igi54556koc@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51847 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbdANOss (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 14 Jan 2017 09:48:48 -0500
In-Reply-To: <20170112030419.j7ux7igi54556koc@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Mboumba Cedric Madianga <cedric.madianga@gmail.com>, linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org

On 12/01/17 03:04, Sebastian Reichel wrote:
> Hi,
> 
> On Wed, Jan 11, 2017 at 12:47:38AM +0100, Linus Walleij wrote:
>> I don't know the best merge path for this but suspect that as
>> usual Lee can merge them all and provide an immutable branch to
>> the other subsystems, which he has lots of routine in handling.
>> The final DTS patch can probably be merged separately through
>> ARM SoC.
> 
> I'm fine with that solution.
> 
> -- Sebastian
> 
Agreed, that's the best way to do these.

Jonathan
