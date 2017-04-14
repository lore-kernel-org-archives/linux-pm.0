From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 03/13] power: max17047_battery: The temp alert values are
 8-bit 2's complement
Date: Fri, 14 Apr 2017 17:39:22 +0200
Message-ID: <20170414153922.56i27vhiseiuzcqf@kozik-lap>
References: <20170414125919.25771-1-hdegoede@redhat.com>
 <20170414125919.25771-3-hdegoede@redhat.com>
 <20170414150927.eo5n2derv26dskcd@kozik-lap>
 <cd0d961a-6ad0-6298-5319-d8dc96da7059@redhat.com>
 <20170414152601.waxqjuu5z6tde7b4@kozik-lap>
 <4e27bcd0-8989-d92d-e938-15833ba6ef36@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33221 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751720AbdDNPj0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2017 11:39:26 -0400
Received: by mail-wr0-f196.google.com with SMTP id l28so12872463wre.0
        for <linux-pm@vger.kernel.org>; Fri, 14 Apr 2017 08:39:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4e27bcd0-8989-d92d-e938-15833ba6ef36@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org

On Fri, Apr 14, 2017 at 05:36:57PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 14-04-17 17:26, Krzysztof Kozlowski wrote:
> > On Fri, Apr 14, 2017 at 05:16:32PM +0200, Hans de Goede wrote:
> > > Hi,
> > > 
> > > On 14-04-17 17:09, Krzysztof Kozlowski wrote:
> > > > On Fri, Apr 14, 2017 at 02:59:09PM +0200, Hans de Goede wrote:
> > > > > The temp alert values are 8-bit 2's complement, so sign-extend them
> > > > > before reporting them back to the caller.
> > > > 
> > > > Are you sure that these are reported with sign bit? I couldn't find
> > > > confirmation of this in datasheet.
> > > 
> > > From: MAX17047-MAX17050.pdf
> > > 
> > > "T ALRT Threshold Register (02h)
> > > The T ALRT Threshold register sets upper and lower limits
> > > that generate an ALRT pin interrupt if exceeded by the
> > > Temperature register value. The upper 8 bits set the maxi-
> > > mum value and the lower 8 bits set the minimum value.
> > > Interrupt threshold limits are stored in two’s-complement
> > > format"
> > 
> > That does not say it is signed. It might be still from 0 to 255.
> 
> Two's complement format is always signed that is its whole
> purpose, from: https://en.wikipedia.org/wiki/Two's_complement
>

Ahh, yes.


Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
