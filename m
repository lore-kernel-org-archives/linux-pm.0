From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH] power: reset: Add MAX77620 support
Date: Thu, 12 Jan 2017 23:05:05 +0530
Message-ID: <5877BE49.2010008@nvidia.com>
References: <20170112161507.23774-1-thierry.reding@gmail.com> <5877B088.5040007@nvidia.com> <20170112173513.GA22794@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170112173513.GA22794@ulmo.ba.sec>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Martin Michlmayr <tbm@cyrius.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chaitanya Bandi <bandik@nvidia.com>
List-Id: linux-pm@vger.kernel.org


On Thursday 12 January 2017 11:05 PM, Thierry Reding wrote:
> * PGP Signed by an unknown key
>
> On Thu, Jan 12, 2017 at 10:06:24PM +0530, Laxman Dewangan wrote:
>> On Thursday 12 January 2017 09:45 PM, Thierry Reding wrote:
>>>
>>> +	dev_dbg(&pdev->dev, "event recorder: %#x\n", value);
>>> +
>>> +	system_power_controller = power;
>>> +	pm_power_off = max77620_pm_power_off;
>>> +#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
>>> +	arm_pm_restart = max77620_pm_restart;
>> What if we want to reset via the Tegra and not through PMIC?
> In that case I assume we either don't have a PMIC, or we should not add
> the system-power-controller device tree property to the PMIC node. In
> the latter case this driver won't install any power off or restart
> callbacks.


We need reset from Tegra and power of from PMIC. Tegra does not support 
power OFF.
