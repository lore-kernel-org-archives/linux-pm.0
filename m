From: Rob Herring <robherring2@gmail.com>
Subject: Re: spear-cpufreq + multiplatform?
Date: Mon, 3 Mar 2014 17:04:23 -0600
Message-ID: <CAL_JsqJ1sHAXu3vzx7Q3mvFT=3JuH-a6d-tJHYZ=JCHUCF6Luw@mail.gmail.com>
References: <20140303180809.GA28282@joshc.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ve0-f178.google.com ([209.85.128.178]:57341 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755016AbaCCXEY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Mar 2014 18:04:24 -0500
Received: by mail-ve0-f178.google.com with SMTP id jw12so1629229veb.9
        for <linux-pm@vger.kernel.org>; Mon, 03 Mar 2014 15:04:24 -0800 (PST)
In-Reply-To: <20140303180809.GA28282@joshc.qualcomm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Josh Cartwright <joshc@codeaurora.org>
Cc: Viresh Kumar <viresh.linux@gmail.com>, Shiraz Hashim <shiraz.hashim@st.com>, Deepak Sikri <deepak.sikri@st.com>, spear-devel@list.st.com, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Mon, Mar 3, 2014 at 12:08 PM, Josh Cartwright <joshc@codeaurora.org> wrote:
> Hey folks-
>
> I noticed booting today's next on a non-spear platform, that I'm seeing
> the following in my logs:
>
>         [    2.126494] spear_cpufreq: Invalid cpufreq_tbl
>
> Looking closer, it looks like the spear-cpufreq driver has a
> late_initcall() that's not too multiplatform friendly.  Perhaps the
> spear cpufreq initialization routine should be called explicitly from
> some platform-specific code, or explicitly check to ensure it's running
> on SPEAr?

Yes, I've seen this on 3.14 as well.

There are also less harmful driver printk's for drivers where the
device is not present. Serial and EHCI drivers are the main culprits.

Rob

>
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> hosted by The Linux Foundation
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
