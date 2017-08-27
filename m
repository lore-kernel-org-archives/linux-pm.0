From: Evgeniy Polyakov <zbr@ioremap.net>
Subject: Re: [PATCH v2 1/2] power: supply: move HDQ interface for bq27xxx from w1 to power/supply
Date: Sun, 27 Aug 2017 10:25:34 +0300
Message-ID: <1195431503818734@web4g.yandex.ru>
References: <20170719170407.14005-1-afd@ti.com>
         <20170719170407.14005-2-afd@ti.com>
         <20170725133022.xjxqas7xy24v3pqa@earth> <20170725134827.wxlkoebcwh5ycnk3@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170725134827.wxlkoebcwh5ycnk3@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi everyone

Sorry for long delay

25.07.2017, 16:48, "Sebastian Reichel" <sebastian.reichel@collabora.co.uk>:
> Here is a signed immutable branch for Andrew's patch, which moves
> bq27000 w1 driver to the power-supply subsystem. I guess git will
> figure everything out without this, but better safe than sorry :)
>
> The following changes since commit 520eccdfe187591a51ea9ab4c1a024ae4d0f68d9:
>
>   Linux 4.13-rc2 (2017-07-23 16:15:17 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/ib-w1-bq27000-4.14
>
> for you to fetch changes up to 55a9db679183bcf85a6e5c44a4f92f158bb6f03d:
>
>   power: supply: move HDQ interface for bq27xxx from w1 to power/supply (2017-07-25 15:17:39 +0200)

Greg, should it be pulled into your tree or submitted as a separate pull request or as set of patches?
Either way looks good to me, please get it into your tree.
