From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v3 0/8] PM / ACPI / i2c: Deploy runtime PM centric path
 for system sleep
Date: Mon, 4 Sep 2017 07:46:37 +0200
Message-ID: <20170904054637.GA23707@wunner.de>
References: <1504018610-10822-1-git-send-email-ulf.hansson@linaro.org>
 <3033151.kbPpEQGlRq@aspire.rjw.lan>
 <CAPDyKFqAqiDcdwEOwEu1m7icnP8MijYf4UNrMqN9YhNbug_upg@mail.gmail.com>
 <1668277.7DWLdgHGid@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1668277.7DWLdgHGid@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Sep 04, 2017 at 02:17:21AM +0200, Rafael J. Wysocki wrote:
> OTOH I'm starting to think that direct_complete is only theoretically
> useful and may not be actually set very often in practice, whereas it
> adds significant complexity to the code, so I'm not sure about it any
> more.

That makes me come out of the woodwork as a direct_complete fan:

Runtime resuming a discrete GPU on a modern dual GPU laptop takes about
1.5 sec, runtime resuming Thunderbolt controllers more than 2 sec.
A discrete GPU easily consumes 10W, a Thunderbolt controller 2W.

So not having direct_complete would noticeably delay system suspend and
resume as well as reduce battery life.

Lukas
