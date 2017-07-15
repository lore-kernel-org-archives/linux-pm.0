From: Mason <slash.tmp@free.fr>
Subject: Re: [RFC 1/2] PM / suspend: Add platform_suspend_target_state()
Date: Sun, 16 Jul 2017 01:34:53 +0200
Message-ID: <53f90d62-111f-57ae-907d-aa347b7033e0@free.fr>
References: <20170622085102.mpk7vxodpgxtrlfd@piout.net>
 <20170715164626.GA1373@amd> <1a5ef0ae-16f3-5a61-ae4e-083664cb30c0@gmail.com>
 <1578637.1XJQpJurXn@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:26995 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751198AbdGOXfW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 15 Jul 2017 19:35:22 -0400
In-Reply-To: <1578637.1XJQpJurXn@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Florian Fainelli <f.fainelli@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm <linux-pm@vger.kernel.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, JB <jb_lescher@sigmadesigns.com>, Kevin Hilman <khilman@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On 16/07/2017 01:24, Rafael J. Wysocki wrote:

> On Saturday, July 15, 2017 10:20:27 AM Florian Fainelli wrote:
>
>> The enum offers the advantage of centralizing how many different states
>> exist for all the platforms we know about in the kernel, it's easy to
>> define common values for platforms that have the same semantics, just
>> like it's simple to add new values for platform specific details.
> 
> Well, you seem to be liking this, so why don't you just implement it?

At the end of his message, Florian wrote:

> In any case, just agree and I will be happy to follow-up with patches.

Regards.
