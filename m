From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: In kernel power management domain_pm created for async schedules
Date: Tue, 5 Dec 2017 16:28:00 +0100
Message-ID: <CAJZ5v0hnWeO7LJtmmfpR6Sqj_hyhzEz=VUfv4k-Gxvx3cWcBLg@mail.gmail.com>
References: <CGME20171205092418epcms5p5c9404c09716e2efe84114cae3ce6b534@epcms5p5>
 <20171205092418epcms5p5c9404c09716e2efe84114cae3ce6b534@epcms5p5>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f182.google.com ([74.125.82.182]:41094 "EHLO
        mail-ot0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753224AbdLEP2B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Dec 2017 10:28:01 -0500
Received: by mail-ot0-f182.google.com with SMTP id b54so535462otd.8
        for <linux-pm@vger.kernel.org>; Tue, 05 Dec 2017 07:28:01 -0800 (PST)
In-Reply-To: <20171205092418epcms5p5c9404c09716e2efe84114cae3ce6b534@epcms5p5>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: vikas.bansal@samsung.com
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "len.brown@intel.com" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Tue, Dec 5, 2017 at 10:24 AM, Vikas Bansal <vikas.bansal@samsung.com> wrote:
> From 8e948f8c697d661f38c2c3a85787e4c48b165adc Mon Sep 17 00:00:00 2001
> From: Vikas Bansal <vikas.bansal@samsung.com>
> Date: Tue, 5 Dec 2017 01:14:41 -0800
> Subject: [PATCH] Put all the async schdules in PM core in domain with name
>  domain_pm. This avoids pm core to wait for async schedules
>  in system other than PM core.

What exactly is the problem that you are trying to address with this?

Thanks,
Rafael
