From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v3 3/3] power: wm831x_power: Support USB charger current
 limit management
Date: Tue, 25 Jul 2017 10:38:59 +0100
Message-ID: <20170725093859.dtohintweufce32f@localhost.localdomain>
References: <cover.1500968744.git.baolin.wang@linaro.org>
 <c6dbaa6b4417eb9213032404b90330c924613ed0.1500968745.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c6dbaa6b4417eb9213032404b90330c924613ed0.1500968745.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: balbi@kernel.org, gregkh@linuxfoundation.org, sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, jun.li@nxp.com, peter.chen@freescale.com, broonie@kernel.org, john.stultz@linaro.org, neilb@suse.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 25, 2017 at 04:00:01PM +0800, Baolin Wang wrote:
> Integrate with the newly added USB charger interface to limit the current
> we draw from the USB input based on the input device configuration
> identified by the USB stack, allowing us to charge more quickly from high
> current inputs without drawing more current than specified from others.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
