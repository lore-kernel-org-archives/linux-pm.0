From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 2/3] thermal: Add Mediatek thermal controller support
Date: Wed, 26 Aug 2015 01:41:03 +0800
Message-ID: <CAGS+omA9g7u+VswqTLoJw=Hmz1Lh2TYgrK_BBQHKsa1ktnp-XQ@mail.gmail.com>
References: <1440057962-13373-1-git-send-email-s.hauer@pengutronix.de> <1440057962-13373-3-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440057962-13373-3-git-send-email-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mediatek@lists.infradead.org, Sasha Hauer <kernel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Sascha,

On Thu, Aug 20, 2015 at 4:06 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> This adds support for the Mediatek thermal controller found on MT8173
> and likely other SoCs.
> The controller is a bit special. It does not have its own ADC, instead
> it controls the on-SoC AUXADC via AHB bus accesses. For this reason
> we need the physical address of the AUXADC. Also it controls a mux
> using AHB bus accesses, so we need the APMIXEDSYS physical address aswell.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Please respond to Daniel Lezcano's comments too.
But beyond that, all three patches in this set are:

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
