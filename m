From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: Fix system suspend
Date: Thu, 10 Aug 2017 13:31:37 +0300
Message-ID: <20170810103137.GT2369@lahna.fi.intel.com>
References: <1502285302-21552-1-git-send-email-ulf.hansson@linaro.org>
 <CALAqxLW31Huu3+BWUO3tO+bsKUv7_r4_2joBy8YpZfa81zJ5tw@mail.gmail.com>
 <7cf63e74-0ece-4af2-89e9-e08b52858195@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7cf63e74-0ece-4af2-89e9-e08b52858195@linux.intel.com>
Sender: stable-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: John Stultz <john.stultz@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-i2c@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, "# v4 . 4+" <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 10, 2017 at 01:25:33PM +0300, Jarkko Nikula wrote:
> Cool, no issues from acpi_lpss.c nor mfd/intel-lpss.c platforms.
> 
> Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Looks good to me as well,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
