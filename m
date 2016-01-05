From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2] drivers: qcom: spm: avoid module usage in non-modular
 SPM driver
Date: Tue, 5 Jan 2016 06:45:24 +0100
Message-ID: <568B5874.5060101@linaro.org>
References: <1451930308-8087-1-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1451930308-8087-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>, andy.gross@linaro.org, sboyd@codeaurora.org
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: linux-pm@vger.kernel.org

On 01/04/2016 06:58 PM, Lina Iyer wrote:
> SPM driver provides cpuidle support on some QC SoC's. The functionali=
ty
> is non-modular and there is no need for module support. Convert modul=
e
> platform init to builtin platform driver init. The driver functionali=
ty
> is not affected by this change.
>
> Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
