From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: New Contributor
Date: Thu, 9 Jun 2016 12:30:08 +0200
Message-ID: <CAJKOXPc1Rgnum64S6HkXu2jiUX2RuTYheZyYZJeJu9AOipPLGQ@mail.gmail.com>
References: <ee830e2c-b2a4-7ea7-8869-23fb1dbc0da9@lapa.com.au> <575536E6.1050807@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:34054 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbcFIKaJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jun 2016 06:30:09 -0400
Received: by mail-oi0-f41.google.com with SMTP id e72so56268808oib.1
        for <linux-pm@vger.kernel.org>; Thu, 09 Jun 2016 03:30:09 -0700 (PDT)
In-Reply-To: <575536E6.1050807@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: chris@lapa.com.au, linux-pm@vger.kernel.org

On Mon, Jun 6, 2016 at 10:40 AM, Mason <slash.tmp@free.fr> wrote:
> On 06/06/2016 06:09, Chris Lapa wrote:
>
>> I'm new to contributing to the kernel and am just wondering what the
>> correct etiquette is for having my patches reviewed/accepted.

Usually the etiquette for pinging/resending is to wait for two weeks.
Although I think it is not written anywhere explicitly.

>
> This document provides some guidelines:
> https://www.kernel.org/doc/Documentation/SubmittingPatches
>
> The MAINTAINERS file is useful to figure out *who* to send patches to:
> https://www.kernel.org/doc/linux/MAINTAINERS

A little bit easier it might be to use scripts/get_maintainer.pl.

In your case the DT bindings should get an ack from device tree folks
and you did not cc them. get_maintainer.pl will help you with that.

Best regards,
Krzysztof
