From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 3/3] power: wm831x_power: Support USB charger current
 limit management
Date: Tue, 25 Jul 2017 10:17:09 +0100
Message-ID: <20170725091709.2vhee725rhbu7pwk@dell>
References: <cover.1500968744.git.baolin.wang@linaro.org>
 <c6dbaa6b4417eb9213032404b90330c924613ed0.1500968745.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c6dbaa6b4417eb9213032404b90330c924613ed0.1500968745.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: balbi@kernel.org, gregkh@linuxfoundation.org, sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, jun.li@nxp.com, peter.chen@freescale.com, broonie@kernel.org, john.stultz@linaro.org, neilb@suse.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 25 Jul 2017, Baolin Wang wrote:

> Integrate with the newly added USB charger interface to limit the current
> we draw from the USB input based on the input device configuration
> identified by the USB stack, allowing us to charge more quickly from high
> current inputs without drawing more current than specified from others.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/wm831x.txt |    1 +

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
