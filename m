From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v2 0/9] PM / ACPI / i2c: Deploy runtime PM centric path
 for system sleep
Date: Fri, 25 Aug 2017 17:10:10 +0300
Message-ID: <4f22e64f-8a3c-9ce2-d12d-d3ff2c4108c9@linux.intel.com>
References: <1503499329-28834-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1503499329-28834-1-git-send-email-ulf.hansson@linaro.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 08/23/2017 05:42 PM, Ulf Hansson wrote:
> This series has been tested on an ARM64 Hikey board, which isn't having the
> i2c device attached to the ACPI PM domain. This means that the ACPI changes
> needs to be tested on some relevant Intel SoCs and it's greatly appreciated
> is someone could help out with this, so is of course review comments.
> 
I tested this set on both platforms using drivers/acpi/acpi_lpss.c and 
drivers/mfd/intel-lpss.c and didn't see any issues.

I guess tested-by is not needed yet as details are cooking in ACPI part 
of the set.

-- 
Jarkko
