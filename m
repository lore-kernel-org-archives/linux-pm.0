From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: Select PM_OPP rather than depending on it
Date: Mon, 16 Dec 2013 14:50:08 +0530
Message-ID: <CAKohpomVwjTrbsQ-A3o943h+rpbDa2qhvE+7DX8VCvpv2t2pFg@mail.gmail.com>
References: <1386799947-6041-1-git-send-email-broonie@kernel.org>
	<1386799947-6041-2-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1386799947-6041-2-git-send-email-broonie@kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <rob.herring@calxeda.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Mark Brown <broonie@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 12 December 2013 03:42, Mark Brown <broonie@kernel.org> wrote:
> From: Mark Brown <broonie@linaro.org>
>
> PM_OPP is a helper library used by several of the existing cpufreq drivers.
> Some of the drivers select this symbol while others depend on it and rely
> on the architecture to enable it. Make this behaviour more consistent and
> obvious by having all the drivers select the symbol. This will also allow
> better build coverage of the affected drivers.
>
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  drivers/cpufreq/Kconfig     | 3 ++-
>  drivers/cpufreq/Kconfig.arm | 6 ++++--
>  2 files changed, 6 insertions(+), 3 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
