From: Markus Mayer <markus.mayer@broadcom.com>
Subject: Re: [PATCH v5 1/3] dt: cpufreq: brcm: New binding document for brcmstb-avs-cpufreq
Date: Mon, 31 Oct 2016 09:37:40 -0700
Message-ID: <CAGt4E5tG7tS7Pxph42-Wu748cB9qSKA-rO7aXX6GSo1+Da5kzw@mail.gmail.com>
References: <20161027210536.98988-1-code@mmayer.net> <20161027210536.98988-2-code@mmayer.net>
 <20161031054303.thdw4rjslosajyl7@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:36116 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S944363AbcJaQhm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Oct 2016 12:37:42 -0400
Received: by mail-vk0-f41.google.com with SMTP id p9so7150696vkd.3
        for <linux-pm@vger.kernel.org>; Mon, 31 Oct 2016 09:37:41 -0700 (PDT)
In-Reply-To: <20161031054303.thdw4rjslosajyl7@rob-hp-laptop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Markus Mayer <code@mmayer.net>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Device Tree List <devicetree@vger.kernel.org>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 30 October 2016 at 22:43, Rob Herring <robh@kernel.org> wrote:
> On Thu, Oct 27, 2016 at 02:05:34PM -0700, Markus Mayer wrote:
>> From: Markus Mayer <mmayer@broadcom.com>
>>
>> Add the binding document for the new brcmstb-avs-cpufreq driver.
>>
>> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>  .../bindings/cpufreq/brcm,stb-avs-cpu-freq.txt     | 78 ++++++++++++++++++++++
>>  MAINTAINERS                                        |  7 ++
>>  2 files changed, 85 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/cpufreq/brcm,stb-avs-cpu-freq.txt
>
> I guess if one of the nodes is used elsewhere, combining the nodes
> doesn't make sense. So:
>
> Acked-by: Rob Herring <robh@kernel.org>

Thanks, Rob.

The series, with Acks added, is also available here:
https://github.com/mmayer/linux/tree/upstream-avs-cpufreq-4.9-v5

Regards,
-Markus
