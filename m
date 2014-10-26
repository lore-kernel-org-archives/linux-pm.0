From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v4 0/3] gpio-charger: add devicetree support
Date: Sun, 26 Oct 2014 13:06:28 +0100
Message-ID: <2175750.C5jxjiuVyT@diego>
References: <1411504936-21026-1-git-send-email-heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1411504936-21026-1-git-send-email-heiko@sntech.de>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, dianders@chromium.org
List-Id: linux-pm@vger.kernel.org

Hi Sebastian,

Am Dienstag, 23. September 2014, 22:42:13 schrieb Heiko Stuebner:
> This series adds devicetree support to the gpio-charger and fixes a small
> issue with the return value of gpio_get_value.
> 
> changes since v3:
> - remove of_match_ptr. All used of_xx function have stubs for !OF
>   and of_device_id also is always defined, so no need for of_match_ptr
> changes since v2:
> - fix (hopefully all) issues pointed out by Doug Anderson
> - add missing of_node assignment to charger
> changes since v1:
> - adapt binding example to show how the charger fits into the
>   power-supplies structure
> 
> 
> Heiko Stuebner (3):
>   dt-bindings: document gpio-charger bindings
>   power: gpio-charger: add device tree support
>   power: gpio-charger: do not use gpio value directly

I can see patch3 in your tree (and 3.18-rc). Will you take patches 1 and 2 for 
3.19?

The generally used 3 week period for devicetree-binding related complaints 
also should be over by now.


Heiko
