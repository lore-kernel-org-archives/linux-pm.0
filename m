From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Subject: Re: [RESEND PATCH v4] thermal: tango: add resume support
Date: Wed, 14 Sep 2016 17:35:58 +0200
Message-ID: <57D96E5E.6070102@sigmadesigns.com>
References: <57CFD031.7020500@sigmadesigns.com> <6763387.6QdSyfOt0d@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from a.mx.sdesigns.eu ([78.31.43.6]:35166 "EHLO a.mx.sdesigns.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759988AbcINPgA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 14 Sep 2016 11:36:00 -0400
In-Reply-To: <6763387.6QdSyfOt0d@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm <linux-pm@vger.kernel.org>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mason <slash.tmp@free.fr>

On 07/09/2016 10:55, Arnd Bergmann wrote:

> On Wednesday, September 7, 2016 10:30:41 AM CEST Marc Gonzalez wrote:
>
>> When this platform is suspended, firmware powers the entire SoC down,
>> except a few hardware blocks waiting for wakeup events. There is no
>> context to save for this particular block.
>>
>> Therefore, there is nothing useful for the driver to do on suspend;
>> so we define a NULL suspend hook. On resume, the driver initializes
>> the block exactly as is done in the probe callback.
>>
>> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
>> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Hello Rui, Eduardo,

The present patch has been reviewed by both Kevin Hilman and Arnd Bergmann,
two arm-soc maintainers. Can you pick it up in time for inclusion in v4.9?

Regards.

