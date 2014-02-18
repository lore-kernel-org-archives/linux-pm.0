From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/6] drivers/acpi: fix driver compile errors when CONFIG_PM_SLEEP is undefined
Date: Tue, 18 Feb 2014 02:03:39 +0100
Message-ID: <2205879.dV8tEujxdx@vostro.rjw.lan>
References: <cover.1392250669.git.shuah.kh@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <cover.1392250669.git.shuah.kh@samsung.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Shuah Khan <shuah.kh@samsung.com>
Cc: lenb@kernel.org, rui.zhang@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, shuahkhan@gmail.com
List-Id: linux-pm@vger.kernel.org

On Wednesday, February 12, 2014 08:19:04 PM Shuah Khan wrote:
> The following acpi drivers fail with compile errors when CONFIG_PM_SLEEP
> is undefined.

I'm going to push all of these patches as fixes for 3.14.  Thanks!

> Shuah Khan (6):
>   drivers/acpi: fix ac driver compile error when CONFIG_PM_SLEEP is
>     undefined
>   drivers/acpi: fix battery driver compile error when CONFIG_PM_SLEEP is
>     undefined
>   drivers/acpi: fix button driver compile error when CONFIG_PM_SLEEP is
>     undefined
>   drivers/acpi: fix fan driver compile error when CONFIG_PM_SLEEP is
>     undefined
>   drivers/acpi: fix sbs driver compile error when CONFIG_PM_SLEEP is
>     undefined
>   drivers/acpi: fix thermal driver compile error when CONFIG_PM_SLEEP
>     is undefined
> 
>  drivers/acpi/ac.c      |    2 ++
>  drivers/acpi/battery.c |    2 ++
>  drivers/acpi/button.c  |    2 ++
>  drivers/acpi/fan.c     |    3 +++
>  drivers/acpi/sbs.c     |    2 ++
>  drivers/acpi/thermal.c |    2 ++
>  6 files changed, 13 insertions(+)
> 
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
