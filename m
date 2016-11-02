From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v3 2/4] ARM: dts: pxa: add pxa25x cpu operating points
Date: Wed, 02 Nov 2016 22:53:49 +0100
Message-ID: <878tt1zgya.fsf@belgarion.home>
References: <1477943696-23477-1-git-send-email-robert.jarzmik@free.fr>
        <1477943696-23477-3-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:27095 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752877AbcKBVxw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Nov 2016 17:53:52 -0400
In-Reply-To: <1477943696-23477-3-git-send-email-robert.jarzmik@free.fr>
        (Robert Jarzmik's message of "Mon, 31 Oct 2016 20:54:54 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rafael J Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> Add the relevant data taken from the PXA 25x Electrical, Mechanical, and
> Thermal Specfication. This will be input data for cpufreq-dt driver.
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
> Since v2: opp definition amended as per Viresh's comment
Queued to pxa/dt.

--
Robert

