From: Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCH v3] drivers: base: add support to skip power management
 in device/driver model
Date: Thu, 14 Feb 2019 21:09:37 +0100
Message-ID: <20190214200937.GA21536@vmlxhi-102.adit-jv.com>
References: <20190214182910.20600-1-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190214182910.20600-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jisheng Zhang <jszhang@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>, Steve Longerbeam <slongerbeam@gmail.com>, Joshua Frkuska <joshua_frkuska@mentor.com>, Eugeniu Rosca <roscaeugeniu@gmail.com>, Eugeniu Rosca <erosca@de.adit-jv.com>, "Rafael J. Wysocki" <rafael@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hello Sudeep,

On Thu, Feb 14, 2019 at 06:29:10PM +0000, Sudeep Holla wrote:
[..]
> 
> Lets add no_pm_required flags to indicate that the device doesn't

s/no_pm_required/no_pm/ ?

> require any sort of pm activities and all of them can be completely
> skipped. We can use the same flag to also avoid adding not used *power*
> sysfs entries for these devices. For now, lets use this for cpu cache
> devices.
[..]

Running suspend/resume ~500 times on H3-Salvator-X with this patch
didn't reveal any regressions. The annoying warnings are gone.
Console log and .config are available at:
https://gist.github.com/erosca/1af11aa62e16903e1b6964be6a9eea77

Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>

Thanks!
Eugeniu.
