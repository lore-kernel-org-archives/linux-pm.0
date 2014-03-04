From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] MAINTAINERS: add maintainers for arm64 acpi
Date: Mon, 03 Mar 2014 18:21:55 -0800
Message-ID: <1393899715.20435.8.camel@joe-AO722>
References: <1393899345-7397-1-git-send-email-graeme.gregory@linaro.org>
	 <1393899345-7397-2-git-send-email-graeme.gregory@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1393899345-7397-2-git-send-email-graeme.gregory@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Graeme Gregory <graeme.gregory@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, grant.likely@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, lenb@kernel.org, rjw@rjwysocki.net
List-Id: linux-pm@vger.kernel.org

On Tue, 2014-03-04 at 10:15 +0800, Graeme Gregory wrote:
> Add maintainers for the arm-core file for arm64 ACPI support

Shouldn't something have to be in the kernel
tree before there's a MAINTAINERS entry?

> diff --git a/MAINTAINERS b/MAINTAINERS
> index c6d0e93..c770d3a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -259,6 +259,13 @@ F:	drivers/pci/*/*acpi*
>  F:	drivers/pci/*/*/*acpi*
>  F:	tools/power/acpi
>  
> +ACPI ARM64
> +M:	Hanjun Guo <hanjun.guo@linaro.org>
> +M:	Graeme Gregory <graeme.gregory@linaro.org>
> +S:	Supported
> +L:	linux-acpi@vger.kernel.org
> +F:	drivers/acpi/plat/arm-core.c
> +
>  ACPI COMPONENT ARCHITECTURE (ACPICA)
>  M:	Robert Moore <robert.moore@intel.com>
>  M:	Lv Zheng <lv.zheng@intel.com>



