From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 1/3] dt: cpufreq: brcm: New binding document for
 brcmstb-avs-cpufreq
Date: Mon, 31 Oct 2016 00:43:03 -0500
Message-ID: <20161031054303.thdw4rjslosajyl7@rob-hp-laptop>
References: <20161027210536.98988-1-code@mmayer.net>
 <20161027210536.98988-2-code@mmayer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161027210536.98988-2-code@mmayer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Mayer <code@mmayer.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Device Tree List <devicetree@vger.kernel.org>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Markus Mayer <mmayer@broadcom.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 27, 2016 at 02:05:34PM -0700, Markus Mayer wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> Add the binding document for the new brcmstb-avs-cpufreq driver.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  .../bindings/cpufreq/brcm,stb-avs-cpu-freq.txt     | 78 ++++++++++++++++++++++
>  MAINTAINERS                                        |  7 ++
>  2 files changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/brcm,stb-avs-cpu-freq.txt

I guess if one of the nodes is used elsewhere, combining the nodes 
doesn't make sense. So:

Acked-by: Rob Herring <robh@kernel.org>
