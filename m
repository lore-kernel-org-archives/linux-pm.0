From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] arm64: dts: exynos: fix type of thermal trip points for
 Exynos7
Date: Tue, 15 May 2018 18:02:02 +0200
Message-ID: <66371602.d1UHUK4g0h@amdc3058>
References: <CGME20180515123755eucas1p278a9c1e9cb0101e406e3839e27f8b3b1@eucas1p2.samsung.com>
        <1702366.qL959G52Hi@amdc3058>
        <CAJKOXPdW7Ovo9GW=29tqa3rEAkSFgrEzbxm_wdGmRpamgk2-ig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAJKOXPdW7Ovo9GW=29tqa3rEAkSFgrEzbxm_wdGmRpamgk2-ig@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, May 15, 2018 02:59:33 PM Krzysztof Kozlowski wrote:
> On Tue, May 15, 2018 at 2:37 PM, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
> > Currently Exynos thermal driver treats as "active" all specified
> > trip points before reaching maximum number of hardware supported
> > trip points.
> 
> The trip point type describe the way how system should act - use
> active or passive cooling. It is independent of thermal driver. I do

OK, I see it now. Please disregard this patch.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
