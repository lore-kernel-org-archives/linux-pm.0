From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v5 1/2] of: Rename "poweroff-source" property to
 "system-power-controller"
Date: Tue, 25 Nov 2014 15:07:00 +0100
Message-ID: <20141125140700.GC19910@localhost>
References: <1416918506-9366-1-git-send-email-romain.perier@gmail.com>
 <1416918506-9366-2-git-send-email-romain.perier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1416918506-9366-2-git-send-email-romain.perier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Romain Perier <romain.perier@gmail.com>
Cc: heiko@sntech.de, johan@kernel.org, lee.jones@linaro.org, broonie@kernel.org, grant.likely@linaro.org, robh@kernel.org, devicetree@vger.kernel.org, lgirdwood@gmail.com, mark.rutland@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 25, 2014 at 12:28:25PM +0000, Romain Perier wrote:
> It reverts commit a4b4e0461ec5 ("of: Add standard property for poweroff capability").
> As discussed on the mailing list, it makes more sense to rename back to the
> old established property name, without the vendor prefix. Problem being that
> the word "source" usually tends to be used for inputs and that is out of control
> of the OS. The poweroff capability is an output which simply turns the
> system-power off. Also, this property might be used by drivers which power-off
> the system and power back on subsequent RTC alarms. This seems to suggest to
> remove "poweroff" from the property name and to choose "system-power-controller"
> as the more generic name. This patchs adds the required renaming changes and
> defines an helper function which checks if this property is set.
> 
> Signed-off-by: Romain Perier <romain.perier@gmail.com>

Acked-by: Johan Hovold <johan@kernel.org>

Mark, this is for the regulator tree.

Thanks,
Johan
