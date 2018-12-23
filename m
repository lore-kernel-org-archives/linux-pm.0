From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v2 07/11] drivers: thermal: Hide PCI driver when
 CONFIG_PCI is unset
Date: Sun, 23 Dec 2018 23:23:24 +0100
Message-ID: <e695ac50-0e7c-6cc4-5f63-42c842787fd7@kernel.org>
References: <20181222090720.19234-1-okaya@kernel.org>
 <20181222090720.19234-8-okaya@kernel.org>
 <CAJZ5v0j6Z42pk16fFGpQz+xvU-gVnarkoafcWJuQPWY=X532YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0j6Z42pk16fFGpQz+xvU-gVnarkoafcWJuQPWY=X532YQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, sumeet.r.pawnikar@intel.com, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 12/23/2018 10:48 PM, Rafael J. Wysocki wrote:
> Can you actually test this driver with your new #ifdef stuff and with
> CONFIG_PCI unset?
> 
> Have you really test it in that configuration?
> 

No, I haven't. Code was compile tested only.

> If not, you shouldn't even post this patch.
> 

I was hoping the maintainer to chime in. By looking at the code, it was
registering a platform and PCI driver. I assumed that it was generic code
that can be used with and without PCI.

> Please make the driver depend on PCI.

I can do that.
