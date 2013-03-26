From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v5 0/8] Reset controller API to reset IP modules on i.MX5
 and i.MX6
Date: Tue, 26 Mar 2013 22:13:38 +0100
Message-ID: <201303262213.39068.marex@denx.de>
References: <1364231189-12497-1-git-send-email-p.zabel@pengutronix.de>
 <20130326181909.GA31593@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130326181909.GA31593-tWAi6jLit6GreWDznjuHag@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Pavel Machek <pavel-ynQEQJNshbs@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Dear Pavel Machek,

> Hi!
> 
> > The system reset controller (SRC) on i.MX51, i.MX53, and i.MX6q controls
> > reset lines to the GPU, VPU, IPU, and OpenVG IP modules.
> > 
> > The following patches add a simple API for devices to request being reset
> > by separate reset controller hardware and implements the reset signal
> > device tree binding proposed by Stephen Warren. Contrary to Tegra
> > hardware, the i.MX SRC contains self-deasserting reset registers, so
> > I've included both ops to manually assert/deassert a reset line, as well
> > as a "reset" operation that is supposed to assert the reset line and
> > wait for it to deassert.
> > 
> > The i.MX SRC is enhanced to provide a reset controller and the IPU driver
> > is made to request being reset by calling the device_reset(&pdev->dev)
> > convenience wrapper during probing.
> > 
> > Changes since v4:
> >  - removed flags parameter from .of_xlate / of_reset_simple_xlate
> >  - warn also if reset_spec->args_count > rcdev->of_reset_n_cells
> >  - unlock list mutex only after try_module_get
> >  - tighten devm_reset_control_match a bit
> 
> Series looks mostly ok to me. (Should the last patch be actually
> first, so that reset functionality is kept between 5/8 and 8/8?)

Not first, but rather third.

You can add my
Reviewed-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>

Best regards,
Marek Vasut
