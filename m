From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 8/8] dt: cpufreq: st: Provide bindings for ST's CPUFreq
 implementation
Date: Tue, 23 Jun 2015 08:04:58 +0530
Message-ID: <20150623023458.GC16776@linux>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
 <1434987837-24212-9-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36822 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932165AbbFWCfD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2015 22:35:03 -0400
Received: by paceq1 with SMTP id eq1so121747540pac.3
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2015 19:35:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1434987837-24212-9-git-send-email-lee.jones@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, robh@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com

[Adding Rob]

On 22-06-15, 16:43, Lee Jones wrote:

At least some description was required here on why you need additional
bindings are what are they.

Over that, this patch should have been present before any other
patches using these bindings.

> Cc: devicetree@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  .../devicetree/bindings/cpufreq/cpufreq-st.txt     | 48 ++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt
> new file mode 100644
> index 0000000..cfa8952
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt
> @@ -0,0 +1,48 @@
> +Binding for ST's CPUFreq driver
> +===============================

OPP-v2 bindings are out now and you can probably use them to make life
simple, they are part of Rafael's recent pull request:
https://lkml.org/lkml/2015/6/22/606

> +Required properties:
> +-------------------
> +- compatible		: Supported values are:
> +				"st,stih407-cpufreq"

Nodes for virtual devices aren't allowed in DT.

> +Required properties [for working voltage scaling]:
> +-------------------------------------------------
> +
> +Located in CPUFreq's node:
> +
> +- st,syscfg		: Phandle to Major number register
> +				First cell: offset to major number
> +- st,syscfg-eng		: Phandle to Minor number and Pcode registers
> +				First cell: offset to process code
> +				Second cell: offset to minor number
> +
> +Located in CPU's node:
> +
> +- st,opp-list		: Bootloader provided node containing one or more 'opp@X' sub-nodes

I can see that this will be passed in from the bootloader. But at
least an example on how exactly things would actually look would have
been good. In logs if not in this file.

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
