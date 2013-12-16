From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: Make ARM big.LITTLE switcher depend on ARM
Date: Mon, 16 Dec 2013 14:50:20 +0530
Message-ID: <CAKohpomoBdK61wc2sG8BZgukuCA_dXWADUF4PrkVU0M5Ykth8A@mail.gmail.com>
References: <1386799947-6041-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1386799947-6041-1-git-send-email-broonie@kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <rob.herring@calxeda.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Mark Brown <broonie@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 12 December 2013 03:42, Mark Brown <broonie@kernel.org> wrote:
> From: Mark Brown <broonie@linaro.org>
>
> The patch currently under review to enable ARM cpufreq drivers for ARM64
> which is useful due to the large amount of shared IP between ARM and ARM64
> SoCs. However the big.LITTLE switcher relies on an architecture interface
> to build which is not present on ARM64. Add a dependency until that is
> resolved.
>
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  drivers/cpufreq/Kconfig.arm | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
