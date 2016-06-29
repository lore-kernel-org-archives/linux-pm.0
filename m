From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] power: qcom-smbb: add extcon dependency
Date: Wed, 29 Jun 2016 11:10:34 -0700
Message-ID: <57740F1A.5040007@codeaurora.org>
References: <20160629143056.7405-1-arnd@arndb.de>
 <20160629143803.GA28325@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160629143803.GA28325@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Courtney Cavin <courtney.cavin@sonymobile.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 06/29/2016 07:38 AM, Sebastian Reichel wrote:
> Hi,
>
> On Wed, Jun 29, 2016 at 04:30:02PM +0200, Arnd Bergmann wrote:
>> Building the smbb driver without extcon results in a link failure:
>>
>> drivers/power/built-in.o: In function `smbb_usb_valid_handler':
>> :(.text+0x3190): undefined reference to `extcon_set_cable_state_'
>> drivers/power/built-in.o: In function `smbb_charger_probe':
>> :(.text+0x3880): undefined reference to `devm_extcon_dev_allocate'
>> :(.text+0x3898): undefined reference to `devm_extcon_dev_register'
>>
>> This adds a Kconfig dependency.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Fixes: 56d7df8716b2 ("power: Add Qualcomm SMBB driver")

extcon use was only recently introduced so this should be

Fixes: 0b7fe26ae602 ("power: qcom_smbb: Make an extcon for usb cable
detection")

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
