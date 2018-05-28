From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: [PATCH 08/11] PM / devfreq: Make update_devfreq() public
Date: Mon, 28 May 2018 14:24:17 +0900
Message-ID: <20180528052417epcms1p171d27949f7827550911218e9c46c6715@epcms1p1>
References: <20180525203043.249193-9-mka@chromium.org>
        <20180525203043.249193-1-mka@chromium.org>
        <CGME20180525203128epcas2p21a65a88fed7838221d02f6419f58bf26@epcms1p1>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180525203043.249193-9-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-pm@vger.kernel.org

>Currently update_devfreq() is only visible to devfreq governors outside
>of devfreq.c. Make it public to allow drivers that adjust devfreq policies
>to cause a re-evaluation of the frequency after a policy change.
>
>Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>---
> drivers/devfreq/governor.h | 3 ---
> include/linux/devfreq.h    | 8 ++++++++
> 2 files changed, 8 insertions(+), 3 deletions(-)

With the requirement from patch 9/11, this commit is reasonable enough.

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
