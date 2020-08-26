Return-Path: <SRS0=+XkI=CE=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE2FC433DF
	for <linux-pm@archiver.kernel.org>; Wed, 26 Aug 2020 13:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70E3D2080C
	for <linux-pm@archiver.kernel.org>; Wed, 26 Aug 2020 13:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598447844;
	bh=VBxaz2sqKo4QjFLnFCNyV3E2BQCcwIjon9lvQIM+huc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=w+78hdiAD005MGeRlJR8W4RtFLRXlB1grThx+Qr5gI2yDux0i4mJjsEd9gI5OjZes
	 gYgjlVYv9gJBAnS3dlbMUAh/RGotKkFLzEE7b5c8Nj2V6Io/Z5i3/cKrSoWKkt/oJC
	 YC1cDjiZ20ms+oV5ywJj6X9LIuli8fiTq8fF3iOs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbgHZNRX (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:17:23 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35675 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729177AbgHZNRX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2020 09:17:23 -0400
Received: by mail-ot1-f66.google.com with SMTP id w10so1445937oti.2;
        Wed, 26 Aug 2020 06:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VBxaz2sqKo4QjFLnFCNyV3E2BQCcwIjon9lvQIM+huc=;
        b=rS9J3vqP7mvccDyrmdoSknlLzlf3Pegje48ZkBqyMMJno6QwGiPi2H5slqC+VbJXKa
         y9Y/sPrhx3P+1TSqmbgdoG1RYmhry9L94ryQ64RTAqgl4PBn5S7PbEtdqbxy8UYqGMOE
         A9Vk4rKbSuARl1R/XQ1C3ivWPxnNWWVBcUQMQ7PtLLvf5JuJl2nEUhZLMSvnXFs1/PAt
         Q60+vATQUTfZH1VxLlT7SkiB8XXC2MqkrMuIMAAkvwLfUrSxqqHbE1T5E3HOgYIvDTTV
         6A3DMO8ZfMybZvY5pfd2Jw3vixmQz0wq1ZvSy4qFYWOxO70zRGXmbuioeav/rO9k+HOs
         CHaA==
X-Gm-Message-State: AOAM531gKEh1AQAZT9wJYgm74yMz9xxOJEL9TpJAqlcxCMG1UQXbkxd/
        tg2MJI2o3jY8b0OG7gA8ZT+n6DIGQ79bzk3fYfU0cT9hCFI=
X-Google-Smtp-Source: ABdhPJw9ndZAwmlxKXhoMO8scmV67bF608r+qN1oevn8zWxk+A9z/icxZK6n9xVy1EWbOHNdrvxIdb9Hvo+LywLft4M=
X-Received: by 2002:a9d:7e99:: with SMTP id m25mr1315148otp.118.1598447842090;
 Wed, 26 Aug 2020 06:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200826120421.44356-1-guilhem@barpilot.io> <CAJZ5v0i8XUF39Vv=EM4TgyXgK6zHniZW3tGYFPweO3kg+BrxOQ@mail.gmail.com>
 <CAGX5Wg0655U71nFcaAJXmj1XMA3MjnCVn=q1Pf=7LLyryHhroQ@mail.gmail.com>
In-Reply-To: <CAGX5Wg0655U71nFcaAJXmj1XMA3MjnCVn=q1Pf=7LLyryHhroQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 26 Aug 2020 15:17:10 +0200
Message-ID: <CAJZ5v0hEEDp6thXSOM2ruVjKU02f1Jfn_nEms1yHUrQR2Q_XaQ@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: Add ICL support
To:     Guilhem Lettron <guilhem@barpilot.io>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 26, 2020 at 2:59 PM Guilhem Lettron <guilhem@barpilot.io> wrote:
>
> On my laptop, a Dell XPS 13 7390 2-in-1 with i7-1065G7, ACPI only report "C1_ACPI", "C2_ACPI" and "C3_ACPI".

Can you list the properties of the idle states in this configuration, that is:

$ grep -r '.*' /sys/devices/system/cpu/cpu0/cpuidle/state1/

and analogously for state2 and state3, and send the output of this?

On my desktop system the above comment produces the following output:

/sys/devices/system/cpu/cpu0/cpuidle/state1/disable:0
/sys/devices/system/cpu/cpu0/cpuidle/state1/above:1022634
/sys/devices/system/cpu/cpu0/cpuidle/state1/time:2556533185
/sys/devices/system/cpu/cpu0/cpuidle/state1/power:0
/sys/devices/system/cpu/cpu0/cpuidle/state1/residency:2
/sys/devices/system/cpu/cpu0/cpuidle/state1/latency:2
/sys/devices/system/cpu/cpu0/cpuidle/state1/usage:17625391
/sys/devices/system/cpu/cpu0/cpuidle/state1/desc:MWAIT 0x00
/sys/devices/system/cpu/cpu0/cpuidle/state1/below:6578613
/sys/devices/system/cpu/cpu0/cpuidle/state1/default_status:enabled
/sys/devices/system/cpu/cpu0/cpuidle/state1/name:C1
/sys/devices/system/cpu/cpu0/cpuidle/state1/s2idle/time:0
/sys/devices/system/cpu/cpu0/cpuidle/state1/s2idle/usage:0

Thanks!
