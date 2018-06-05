From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/3] mfd: cros: add charger port count command definition
Date: Tue, 5 Jun 2018 08:11:20 +0100
Message-ID: <20180605071120.GI21163@dell>
References: <20180530031704.18597-1-fparent@baylibre.com>
 <20180530031704.18597-2-fparent@baylibre.com>
 <20180604085900.GN25455@dell>
 <CAOwMV_xyqj027+iRAQtZ5Hv8NDUc6s9OfS0vAkumUyyc4LUjzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOwMV_xyqj027+iRAQtZ5Hv8NDUc6s9OfS0vAkumUyyc4LUjzw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabien Parent <fparent@baylibre.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Enric Balletbo Serra <eballetbo@gmail.com>, Guillaume Pain <gpain@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 04 Jun 2018, Fabien Parent wrote:

> On Mon, Jun 4, 2018 at 1:59 AM, Lee Jones <lee.jones@linaro.org> wrote:
> > On Tue, 29 May 2018, Fabien Parent wrote:
> >
> >> A new more command has been added to the ChromeOS embedded controller
> >> that allows to get the number of charger port count. Unlike
> >> EC_CMD_USB_PD_PORTS, this new command also includes the dedicated
> >> port if present.
> >>
> >> This command will be used to expose the dedicated charger port
> >> in the ChromeOS charger driver.
> >>
> >> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> >> ---
> >>  include/linux/mfd/cros_ec_commands.h | 10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >
> > Does not want to apply.  I didn't investigate why.
> >
> > Please rebase and resend?
> 
> Sorry, I forgot to add you as "to:" to the patch series.
> This patch applies on top of https://lkml.org/lkml/2018/5/2/590
> ([PATCH v4 1/3] mfd: cros_ec: Add USBPD charger commands and struct
> definitions)

Okay.  Please re-submit after that set has landed then.

Please, also add my Ack to the patch:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
