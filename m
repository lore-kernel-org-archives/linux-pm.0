From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/2] thermal: imx: handle error path in one place to save
 duplicated code
Date: Thu, 13 Sep 2018 15:43:05 +0200
Message-ID: <d60f6f26-9662-c2f0-b801-582099f97cdf@linaro.org>
References: <1536829986-23702-1-git-send-email-Anson.Huang@nxp.com>
 <1536829986-23702-2-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1536829986-23702-2-git-send-email-Anson.Huang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <Anson.Huang@nxp.com>, rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 13/09/2018 11:13, Anson Huang wrote:
> During probe phase, the error path can be handled in one place and
> use goto method to save many duplicated code.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Thanks for this cleanup.

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
