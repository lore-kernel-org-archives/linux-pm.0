From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH] smartreflex: Neaten logging
Date: Thu, 18 Aug 2016 13:26:57 -0500
Message-ID: <m2r39mq6fi.fsf@baylibre.com>
References: <8dd34715bc267a29cade4ceec193ca1066f18db4.1470986036.git.joe@perches.com>
        <ef0d3152-a01a-9359-bfb5-3fb8ab1b6041@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ef0d3152-a01a-9359-bfb5-3fb8ab1b6041@ti.com> (Nishanth Menon's
        message of "Fri, 12 Aug 2016 07:46:30 -0500")
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Joe Perches <joe@perches.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Nishanth Menon <nm@ti.com> writes:

> On 08/12/2016 02:14 AM, Joe Perches wrote:
>> Use a more common logging style.
>>
>> Miscellanea:
>>
>> o Use pr_warn
>> o Coalesce formats adding missing spaces
>> o Argument alignment
>> o Remove unnecessary OOM messages as k.alloc does stack dumps
>>
>> Signed-off-by: Joe Perches <joe@perches.com>
>
> Acked-by: Nishanth Menon <nm@ti.com>
>
> Kevin, would you be able to pick this up?

Acked-by: Kevin Hilman <khilman@baylibre.com>

Rafael, please apply directly.  I don't have any other smartreflex
changes for this cycle.

Kevin
