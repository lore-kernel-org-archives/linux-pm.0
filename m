From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / Domains: Add DT file to MAINTAINERS
Date: Tue, 25 Apr 2017 10:02:51 +0200
Message-ID: <CAPDyKFpQNYubZz7m_WLNYqvgfDtz7kKz1==GmTSZOnAKe=XyHw@mail.gmail.com>
References: <464469671a1b407737ee28aa41447178366ddb7c.1493104829.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <464469671a1b407737ee28aa41447178366ddb7c.1493104829.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Kevin Hilman <khilman@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 25 April 2017 at 09:22, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Add the power_domain.txt DT file to MAINTAINERS, otherwise
> get_maintainers.pl doesn't pick the right set of maintainers for changes
> to the DT file.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 67280051e30a..55b9ca2d5b98 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5610,6 +5610,7 @@ L:        linux-pm@vger.kernel.org
>  S:     Supported
>  F:     drivers/base/power/domain*.c
>  F:     include/linux/pm_domain.h
> +F:     Documentation/devicetree/bindings/power/power_domain.txt
>
>  GENERIC UIO DRIVER FOR PCI DEVICES
>  M:     "Michael S. Tsirkin" <mst@redhat.com>
> --
> 2.12.0.432.g71c3a4f4ba37
>
