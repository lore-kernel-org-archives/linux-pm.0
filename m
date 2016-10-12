From: Markus Mayer <markus.mayer@broadcom.com>
Subject: Re: [PATCH v3 2/3] cpufreq: brcmstb-avs-cpufreq: AVS CPUfreq driver
 for Broadcom STB SoCs
Date: Wed, 12 Oct 2016 09:08:24 -0700
Message-ID: <CAGt4E5uV4y3mKarxNL1hjYAZSu02H6eHdRTCRgc-U03hb5ApLw@mail.gmail.com>
References: <1475882487-2155-1-git-send-email-mmayer@broadcom.com>
 <1475882487-2155-3-git-send-email-mmayer@broadcom.com> <20161012053842.GF19385@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:34458 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753422AbcJLQI0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Oct 2016 12:08:26 -0400
Received: by mail-io0-f176.google.com with SMTP id r30so55606189ioi.1
        for <linux-pm@vger.kernel.org>; Wed, 12 Oct 2016 09:08:26 -0700 (PDT)
In-Reply-To: <20161012053842.GF19385@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Device Tree List <devicetree@vger.kernel.org>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 11 October 2016 at 22:38, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 07-10-16, 16:21, Markus Mayer wrote:
>> +static int brcm_avs_cpufreq_exit(struct cpufreq_policy *policy)
>> +{
>> +     struct private_data *priv = policy->driver_data;
>> +
>> +     iounmap(priv->base);
>> +     iounmap(priv->avs_intr_base);
>> +
>> +     return 0;
>> +}
>
> Shouldn't the above be done in the below routine instead ?

Good point. I'll move it.

>> +static int brcm_avs_cpufreq_remove(struct platform_device *pdev)
>> +{
>> +     platform_set_drvdata(pdev, NULL);
>> +
>> +     return cpufreq_unregister_driver(&brcm_avs_driver);
>> +}
>
> --
> viresh
