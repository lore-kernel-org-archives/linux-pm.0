From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] dt-bindings: cpufreq: document for hisilicon acpu driver
Date: Mon, 2 Mar 2015 11:46:54 +0530
Message-ID: <CAKohpokXT3m0jnX4R25gzcJUAf_HFj15MueOD2mhG6DRF-0uvg@mail.gmail.com>
References: <1424956899-8891-1-git-send-email-leo.yan@linaro.org>
	<1424956899-8891-3-git-send-email-leo.yan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:63216 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbbCBGQy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Mar 2015 01:16:54 -0500
Received: by mail-ob0-f169.google.com with SMTP id wp4so29316709obc.0
        for <linux-pm@vger.kernel.org>; Sun, 01 Mar 2015 22:16:54 -0800 (PST)
In-Reply-To: <1424956899-8891-3-git-send-email-leo.yan@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Dan Zhao <dan.zhao@hisilicon.com>, zhenwei.wang@hisilicon.com, mohaoju@hisilicon.com, devicetree-discuss <devicetree-discuss@lists.ozlabs.org>, Rob Herring <rob.herring@linaro.org>

For bindings you need to cc DT list, cc'd now..

On 26 February 2015 at 18:51, Leo Yan <leo.yan@linaro.org> wrote:
> This adds documentation for hisilicon acpu's cpufreq driver.
>
> OPP library is used for device tree parsing to get frequency list;
> Furthermore, this driver can bind all CPUs to change frequency together,
> or the two clusters can trigger the frequency change independently. This
> is controlled by the dtb flag "hisilicon,coupled-clusters".
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  .../bindings/cpufreq/cpufreq-hisi-acpu.txt         | 112 +++++++++++++++++++++
>  1 file changed, 112 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-hisi-acpu.txt

Bindings must be added before using them and so this patch should have been 1/2.
Apart from that, it looks like you can reuse cpufreq-dt easily without
much trouble.


> +- hisilicon,coupled-clusters: Specify whether all clusters share one clock
> +       source. This must be defined under node cpufreq.

> +cpufreq {
> +       compatible = "hisilicon,hisi-acpu-cpufreq";
> +       hisilicon,coupled-clusters = <1>;
> +};

Such virtual nodes aren't allowed in DT.
