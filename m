From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] PM / Domains: Don't return -EEXIST at attach when PM
 domain exists
Date: Mon, 14 May 2018 17:53:42 -0700
Message-ID: <20180515005342.GM98604@atomide.com>
References: <1526309557-7995-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1526309557-7995-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, "linux-samsung-soc @ vger . kernel . org" <linux-samsung-soc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

* Ulf Hansson <ulf.hansson@linaro.org> [180514 14:55]:
> As dev_pm_domain_attach() isn't the only way to assign PM domain pointers
> to devices, clearly we must allow a device to have the pointer already
> being assigned. For this reason, return 0 instead of -EEXIST.
> 
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Tested-by: Tested-by: Krzysztof Kozlowski <krzk@kernel.org>

Fixes the issue for me too:

Tested-by: Tony Lindgren <tony@atomide.com>
