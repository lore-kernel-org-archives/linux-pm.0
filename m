From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v9 03/20] PM / devfreq: Add devfreq_get_devfreq_by_phandle()
Date: Tue, 12 Apr 2016 09:24:13 +0200
Message-ID: <570CA29D.9030308@samsung.com>
References: <1460347078-15175-1-git-send-email-cw00.choi@samsung.com>
 <1460347078-15175-4-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1460347078-15175-4-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, kgene@kernel.org, s.nawrocki@samsung.com, tomasz.figa@gmail.com
Cc: rjw@rjwysocki.net, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux.amoon@gmail.com, m.reichl@fivetechno.de, tjakobi@math.uni-bielefeld.de, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 04/11/2016 05:57 AM, Chanwoo Choi wrote:
> This patch adds the new devfreq_get_devfreq_by_phandle() OF helper function
> which can find the instance of devfreq device by using phandle ("devfreq").
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> [m.reichl and linux.amoon: Tested it on exynos4412-odroidu3 board]
> Tested-by: Markus Reichl <m.reichl@fivetechno.de>
> Tested-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/devfreq/devfreq.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/devfreq.h   |  9 +++++++++
>  2 files changed, 53 insertions(+)
> 

Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
