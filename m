From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 2/9] i2c: reject new transfers when adapters are
 suspended
Date: Mon, 24 Dec 2018 22:32:55 +0100
Message-ID: <5e560c2e-4da9-05ef-9bfa-3391fdd8ad23@redhat.com>
References: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
 <20181222202623.4521-3-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------34983B75F30C509E4209A341"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181222202623.4521-3-wsa+renesas@sang-engineering.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------34983B75F30C509E4209A341
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Thank you for this new version.

On 22-12-18 21:26, Wolfram Sang wrote:
> Using the 'is_suspended' flag from the PM core, we now reject new
> transfers if the parent of the adapter is already marked suspended.

I've been running some tests and I'm afraid that those have
exposed multiple issues:

1) It seems that adap->dev.parent can be NULL in some cases, specifically
this patch causes the i915 driver to crash during probe on an Apollo Lake
laptop with an eDP panel. I've attached a fixup patch which fixes this.

2) There are multiple suspend stages: prepare suspend, suspend_late,
suspend_no_irq and several devices which need access to i2c-transfers
suspend from the suspend_late or even the suspend_no_irq handler.

The way this works is that first all devices are moved to the prepared
state, then a second run is done moving all devices over to suspended,
then a third run moving all devices over to suspend_late, etc.

To make this work, e.g. the i2c-designware driver has a nop suspend
callback and does the actual suspend from its suspend_late or
suspend_no_irq callback. But the is_suspended flag we are testing for
now gets set during the suspend phase. So when we are then asked to
do an i2c-transfer during the suspend_late phase we get a false-positive
triggering of the:

	if (WARN(device_is_suspended(adap->dev.parent),
		 "Accessing already suspended I2C/SMBus adapter"))
		return -ESHUTDOWN;

WARN and a return of -ESHUTDOWN, because the adapter is in the
suspended state, but it has not actually been suspended / moved
to the D3 low-power state as that happens later when we reach
e.g. the suspend_no_irq phase of the suspend.

This is not only a problem with the somewhat complex PMIC
situation on some Cherry Trail devices, but it also breaks the
i915 driver since as a PCI device the i915 device also only
really gets turned off from the suspend_no_irq phase of the suspend.

Sorry, this is something which I should have realized before, but
well I didn't.

TL;DR: really only the adapter driver knows when the device is
put in such a state that it can no longer do transfers, as it
actually turns of clks / moves it D3 / etc. Which may happen at
any of the 3 suspend phases so any "core" based solution is going
to get this wrong.

I share your desire to have the check for this shared in core code,
but I'm afraid that just is not going to work.

Regards,

Hans










> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>   Documentation/i2c/fault-codes | 4 ++++
>   drivers/i2c/i2c-core-base.c   | 3 +++
>   drivers/i2c/i2c-core-smbus.c  | 4 ++++
>   3 files changed, 11 insertions(+)
> 
> diff --git a/Documentation/i2c/fault-codes b/Documentation/i2c/fault-codes
> index 47c25abb7d52..0cee0fc545b4 100644
> --- a/Documentation/i2c/fault-codes
> +++ b/Documentation/i2c/fault-codes
> @@ -112,6 +112,10 @@ EPROTO
>   	case is when the length of an SMBus block data response
>   	(from the SMBus slave) is outside the range 1-32 bytes.
>   
> +ESHUTDOWN
> +	Returned when a transfer was requested using an adapter
> +	which is already suspended.
> +
>   ETIMEDOUT
>   	This is returned by drivers when an operation took too much
>   	time, and was aborted before it completed.
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 28460f6a60cc..3ce238b782f3 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -1865,6 +1865,9 @@ int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
>   
>   	if (WARN_ON(!msgs || num < 1))
>   		return -EINVAL;
> +	if (WARN(device_is_suspended(adap->dev.parent),
> +		 "Accessing already suspended I2C/SMBus adapter"))
> +		return -ESHUTDOWN;
>   
>   	if (adap->quirks && i2c_check_for_quirks(adap, msgs, num))
>   		return -EOPNOTSUPP;
> diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
> index 9cd66cabb84f..e0f7f22feabd 100644
> --- a/drivers/i2c/i2c-core-smbus.c
> +++ b/drivers/i2c/i2c-core-smbus.c
> @@ -547,6 +547,10 @@ s32 __i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
>   	int try;
>   	s32 res;
>   
> +	if (WARN(device_is_suspended(adapter->dev.parent),
> +		 "Accessing already suspended I2C/SMBus adapter"))
> +		return -ESHUTDOWN;
> +
>   	/* If enabled, the following two tracepoints are conditional on
>   	 * read_write and protocol.
>   	 */
> 

--------------34983B75F30C509E4209A341
Content-Type: text/x-patch;
 name="0001-FIXUP-i2c-reject-new-transfers-when-adapters-are-sus.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-FIXUP-i2c-reject-new-transfers-when-adapters-are-sus.pa";
 filename*1="tch"

>From 0ff431b48f7f2d08bbf299265c67589a598ec5d4 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 24 Dec 2018 22:00:31 +0100
Subject: [PATCH] FIXUP: i2c: reject new transfers when adapters are suspended

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/i2c/i2c-core-base.c  | 2 +-
 drivers/i2c/i2c-core-smbus.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 3ce238b782f3..e2fae7ec6c95 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1865,7 +1865,7 @@ int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 
 	if (WARN_ON(!msgs || num < 1))
 		return -EINVAL;
-	if (WARN(device_is_suspended(adap->dev.parent),
+	if (WARN(adap->dev.parent && device_is_suspended(adap->dev.parent),
 		 "Accessing already suspended I2C/SMBus adapter"))
 		return -ESHUTDOWN;
 
diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
index e0f7f22feabd..1376620ae204 100644
--- a/drivers/i2c/i2c-core-smbus.c
+++ b/drivers/i2c/i2c-core-smbus.c
@@ -547,7 +547,8 @@ s32 __i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
 	int try;
 	s32 res;
 
-	if (WARN(device_is_suspended(adapter->dev.parent),
+	if (WARN(adapter->dev.parent &&
+			device_is_suspended(adapter->dev.parent),
 		 "Accessing already suspended I2C/SMBus adapter"))
 		return -ESHUTDOWN;
 
-- 
2.20.1


--------------34983B75F30C509E4209A341--
