From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: ACPI PCC probe failed.
Date: Wed, 4 Feb 2015 18:38:39 -0500
Message-ID: <CAJ5Y-eY7H=3su7Ahnk47CCfDt+Gnwz0zUAC7XqizyydhhTuG-Q@mail.gmail.com>
References: <CABwnbUkGNJEZkW5bL9pXvcZwqz4fZKiub_-vTRDLp=FeiQq8cw@mail.gmail.com>
	<2240641.KgmUOJm3t4@vostro.rjw.lan>
	<CAJ5Y-eY=1YAeD3jCxSzuws=9qZQu2vcTgG9eBR0Nu+C6qNst2g@mail.gmail.com>
	<3901813.ZV5Z0Wofju@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:41812 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756042AbbBDXik (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Feb 2015 18:38:40 -0500
Received: by mail-we0-f181.google.com with SMTP id k48so4648322wev.12
        for <linux-pm@vger.kernel.org>; Wed, 04 Feb 2015 15:38:39 -0800 (PST)
In-Reply-To: <3901813.ZV5Z0Wofju@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Cristian <caravena@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On 4 February 2015 at 18:04, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, February 04, 2015 05:06:26 PM Ashwin Chaugule wrote:
>> > I have one more concern about this driver.  Namely, what benefit is there to
>> > people like Cristian from it at all?
>>
>> Its of use only if they have a PCC client (MPST, CPPC, RAS) driver.
>> Looks like PCC was explicitly enabled in this kernel.
>>
>> config PCC
>> bool "Platform Communication Channel Driver"
>> depends on ACPI
>
> Can we make it depend on the clients instead and be set automatically
> when at least one of the clients is enabled?
>
> Otherwise distros will have a problem with deciding whether or not they
> should enable this driver and most of them will end up enabling it.

I see your point, but I'm not aware of any upstreamed client as of
yet. There might be folks using this driver internally though with
other clients. In such a case, is there a way to keep PCC disabled
until a client (e.g. CPPC) is upstreamed?

Alternately, is it that bad to keep it the way it is, given that the
driver wont do anything unless PCCT is detected in firmware and a PCC
client explicitly uses its API?

Thanks,
Ashwin
