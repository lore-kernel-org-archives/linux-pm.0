From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v6 0/8] Runtime PM for Thunderbolt on Macs
Date: Tue, 14 Mar 2017 13:31:22 +0100
Message-ID: <CAPDyKFp5D5vfJVnXXRn10Mg+KLyCxM_cFyCT1RYWTEYyyOcAbA@mail.gmail.com>
References: <cover.1486913733.git.lukas@wunner.de> <20170218095250.GC1335@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ua0-f182.google.com ([209.85.217.182]:36578 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750771AbdCNMb3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Mar 2017 08:31:29 -0400
Received: by mail-ua0-f182.google.com with SMTP id 72so168633512uaf.3
        for <linux-pm@vger.kernel.org>; Tue, 14 Mar 2017 05:31:28 -0700 (PDT)
In-Reply-To: <20170218095250.GC1335@wunner.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Andreas Noever <andreas.noever@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 18 February 2017 at 10:52, Lukas Wunner <lukas@wunner.de> wrote:
> Hi Rafael,
>
> On Sun, Feb 12, 2017 at 05:07:45PM +0100, Lukas Wunner wrote:
>> Power down Thunderbolt controllers on Macs when nothing is plugged in
>> to save around 2W per controller and fix a power regression introduced
>> in v3.17 that affects millions of machines (all Macs with Thunderbolt)
>
> Patches 4, 5 and 6 of this series pertain to the PM subsystem:
> https://patchwork.kernel.org/patch/9568441/
> https://patchwork.kernel.org/patch/9568443/
> https://patchwork.kernel.org/patch/9568445/
>
> I've been posting these unmodified over the course of four iterations
> since mid December but haven't seen comments from you.  Are there any
> objections?  If not, would it be possible for you to include them in
> your second pull for 4.11?  This would help greatly as I wouldn't have
> to post them over and over again.
>
> Thanks,
>
> Lukas

Lukas, I will try to help review the PM specific parts of this series.
However I am not monitoring linux-pci, perhaps you can explicitly add
me on cc for the next revision instead.

Kind regards
Uffe
