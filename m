From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: Regression in 4.8 - CPU speed set very low
Date: Thu, 29 Sep 2016 11:24:29 -0500
Message-ID: <67ccf531-8b8a-701f-49a3-faed02e7dabe@lwfinger.net>
References: <f89dffb9-cc78-9849-9539-74ce89e773cd@lwfinger.net>
 <CAJZ5v0j3fJ7pDoR+LhY6x1T0yQEhq6omFL7-BrBcMy68eFiMMg@mail.gmail.com>
 <5271ed6f-5798-e930-d7fd-17fe6bb7ea96@lwfinger.net>
 <16590757.26uEfRfeet@vostro.rjw.lan>
 <1475164576.5547.10.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:36850 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755540AbcI2QYd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Sep 2016 12:24:33 -0400
In-Reply-To: <1475164576.5547.10.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Doug Smythies <dsmythies@telus.net>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On 09/29/2016 10:56 AM, Srinivas Pandruvada wrote:
> On Thu, 2016-09-29 at 14:19 +0200, Rafael J. Wysocki wrote:
>
> [...]
>
>>> My laptop was inadvertently put to sleep while I was gone. I forgot
>>> to leave a
>>> note for my wife and she quieted the noisy cpu fan. :)
>> It looks like in 4.8-rc we made a change that caused the "high" trip
>> point to
>> be acted on.
> This high trip point we don't expose in thermal subsystem (the thermal
>  zone dump didn't show this anywhere as a trip). This is exposed by
> core-dts driver only. This is the point BIOS is supposed to act, I
> guess that's why you are seeing 50% clock modulation.
>
>
> Are you running thermald
>
> What is?
> # ps -e | grep thermald

The output is blank. I am not running thermald.

Larry

