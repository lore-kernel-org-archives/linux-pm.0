From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH v3 0/9] PM / Domains: Generic OF-based support
Date: Fri, 05 Sep 2014 08:39:07 -0700
Message-ID: <7h61h2yt44.fsf@paris.lan>
References: <1409838756-31963-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1409838756-31963-1-git-send-email-ulf.hansson@linaro.org> (Ulf
	Hansson's message of "Thu, 4 Sep 2014 15:52:27 +0200")
Sender: linux-acpi-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Chris Ball <chris@printf.net>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

> Changes in v3:
> 	- Aligned on terminology, now using "PM domain" in comments and commit
> 	- messages/headers.
> 	- Improved English and grammar in comments and commit messages/headers.
> 	- Adopted proposal from Geert, to have compile-time-check wrapper
> 	  functions for the API that adds xlate_simple and xlate_onecell
> 	  providers.
>  	- Renamed "domain_num" to "num_domains", in genpd_onecell_data struct.
> 	- Handle non-contiguous arrays for onecell PM domain providers.
> 	- Rebased the Exynos patch to follow the new genpd API changes.
>
>
> Changes in v2:
> 	- Fix the ACPI patch, it didn't even compile for CONFIG_ACPI.
> 	- Updated some comments in code and in commit messages.
> 	- Fixed the dev_pm_domain_attach API to handle EPROBE_DEFER properly.
> 	- Rebased the ARM Exynos patch.
> 	- Added some Tested-by tags.
>
>
> This patchset has a bit of a history and some parts of it has been posted
> earlier.
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/262725.html
>
> In the first revision I intentially didn't increase version number of the
> patches, since I think it would have cause more confusion than clarity.
>
> A summary of changes in V1 and since the last patchset, from the link above:
> 	- Instead of letting driver core handling the device to power domain
> 	binding/unbinding, follow the behavior of how the ACPI power domain
> 	is handled.
>
>
> This is a summary of what these patches are intended to do:
>
> 1)
> Add generic power domain OF-based support which also includes APIs to handle
> attach/detach of generic power domains to devices.
>
> 2)
> Adding a common API to attach/detach power domains and include support for the
> ACPI and the generic power domain in there.
>
> 3)
> From subsystem level code, at probe/remove, convert from invoking the ACPI
> specific power domain attach/detach functions to the new common attach/detach
> APIs.
>
> 4)
> Add support for the AMBA bus to attach/detach power domains, using the new
> common APIs.
>
> 5)
> Convert Exynos to use the new generic power domain OF support.
>
> Obviously, there are dependencies througout this patchset, which means if they
> get accepted the all need to go together. It might also be convenient to share
> them through an immutable branch.

Reviewed-by: Kevin Hilman <khilman@linaro.org>
