From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v3 1/9] hwmon: (core) Order include files alphabetically
Date: Tue, 27 Sep 2016 23:13:14 +0200
Message-ID: <1475010794.4449.1.camel@chaos.suse>
References: <1469417552-9749-1-git-send-email-linux@roeck-us.net>
         <1469417552-9749-2-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-hwmon-owner@vger.kernel.org>
In-Reply-To: <1469417552-9749-2-git-send-email-linux@roeck-us.net>
Sender: linux-hwmon-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jonathan Cameron <jic23@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Punit Agrawal <punit.agrawal@arm.com>, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On dim., 2016-07-24 at 20:32 -0700, Guenter Roeck wrote:
> Ordering include files alphabetically makes it easier to add new ones.
> Stop including linux/spinlock.h and linux/kdev_t.h since both are not
> needed.
> 
> Reviewed-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v3: No change
> v2: Added patch
> 
>  drivers/hwmon/hwmon.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> (...)

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support

