From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3 2/2] thermal: Introduce Amazon's Annapurna Labs Thermal
 Driver
Date: Fri, 12 Apr 2019 14:32:37 +0200
Message-ID: <61186ba3-659c-cc62-cb70-532e89aaae44@linaro.org>
References: <1554978168-17369-1-git-send-email-talel@amazon.com>
 <1554978168-17369-3-git-send-email-talel@amazon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554978168-17369-3-git-send-email-talel@amazon.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Talel Shenhar <talel@amazon.com>, robh@kernel.org, edubezval@gmail.com, dwmw@amazon.co.uk, jonnyc@amazon.com, rui.zhang@intel.com, hhhawa@amazon.com, ronenk@amazon.com, hanochu@amazon.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 11/04/2019 12:22, Talel Shenhar wrote:
> This is a generic thermal driver for simple MMIO sensors, of which
> amazon,al-thermal is one.
> 
> This device uses a single MMIO transaction to read the temperature and
> report it to the thermal subsystem.
> 
> Signed-off-by: Talel Shenhar <talel@amazon.com>
> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
