From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: [PATCH 04/11] PM / devfreq: Remove redundant frequency
 adjustment from governors
Date: Mon, 28 May 2018 13:57:44 +0900
Message-ID: <20180528045744epcms1p115f761df5eff88a1648639385425f02b@epcms1p1>
References: <20180525203043.249193-5-mka@chromium.org>
        <20180525203043.249193-1-mka@chromium.org>
        <CGME20180525203124epcas2p2db3f1996b33348f19a6a91cee55abb0b@epcms1p1>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180525203043.249193-5-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-pm@vger.kernel.org

> The userspace and simpleondemand governor determine a target frequency and
> then adjust it according to the df->min/max_freq limits that might have
> been set by user space. This adjustment is redundant, it is done in
> update_devfreq() for any governor, right after returning from
> governor->get_target_freq().
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/devfreq/governor_simpleondemand.c |  5 -----
>  drivers/devfreq/governor_userspace.c      | 16 ++++------------
>  2 files changed, 4 insertions(+), 17 deletions(-)
> 

Yes, indeed. Governors are no longer required to be aware of min/max freq.

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
