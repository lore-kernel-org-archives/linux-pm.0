From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 3/5] power: supply: sc27xx: Add fuel gauge low voltage alarm
Date: Mon, 26 Nov 2018 14:15:28 +0800
Message-ID: <CAMz4kuLtsDRcYBqPa5ryNuMMQJkJ0OAn7JZgZj5g5nx33puaqw@mail.gmail.com>
References: <cover.1542185618.git.baolin.wang@linaro.org> <ee1dd39f126bd03fb88381de9663d32df994d341.1542185618.git.baolin.wang@linaro.org>
 <20181125214501.GA9913@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181125214501.GA9913@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, yuanjiang.yu@unisoc.com, Mark Brown <broonie@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Pavel,
On Mon, 26 Nov 2018 at 05:45, Pavel Machek <pavel@ucw.cz> wrote:
>
> On Wed 2018-11-14 17:07:06, Baolin Wang wrote:
> > From: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
> >
> > Add low voltage alarm support to make sure the battery capacity
> > more accurate in lower voltage stage.
> >
> > Signed-off-by: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>
> Should we also shut down the system when that happens, as battery is
> empty?
>
> Or is there any lower threshold when we should do the shutdown?

We do not shutdown the system when battery is empty in fuel gauge
driver, instead we should do that in charger manager service or other
upper layers. In fuel gauge driver, we should just supply the accurate
battery capacity for upper layer.

-- 
Baolin Wang
Best Regards
