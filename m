From: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
Subject: Re: [PATCH v3 2/2] power: Adds support for Smart Battery System
 Manager
Date: Mon, 25 Jul 2016 21:49:36 +0200
Message-ID: <1469476176.22243.10.camel@amnesix>
References: <1bIiDr-0004G1-0P>
	 <1468349295-4935-1-git-send-email-karl-heinz@schneider-inet.de>
	 <1468349295-4935-3-git-send-email-karl-heinz@schneider-inet.de>
	 <20160719041729.GC1640@katana> <1468954265.3053.3.camel@amnesix>
	 <e252c587-560e-ee85-5016-a0b92124e422@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from schneider-inet.de ([85.214.76.205]:53467 "EHLO
	h1714509.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273AbcGYTts (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Jul 2016 15:49:48 -0400
In-Reply-To: <e252c587-560e-ee85-5016-a0b92124e422@axentia.se>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, Rob Herring <robh@kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Phil Reid <preid@electromag.com.au>

Hi Peter, Hi Rob,

Am Montag, den 25.07.2016, 12:44 +0200 schrieb Peter Rosin:
> On 2016-07-19 20:51, Karl-Heinz Schneider wrote:
> >> Other than that, looks good to me, yet Peter has more insight to
> >> i2c-muxes these days.
> >>
> > Tanks for review. 
> > 
> > Will wait another few days before sending a new revision, hence changes
> > are rather small.
> 
> Looks good to me from a muxing perspective, with very a minor nit that the
> devicetree bindings do not point to i2c-mux.txt for where "standard i2c-mux
> nodes" are described.
Right, will add it.

like this: 
@@ -7,7 +7,8 @@ Required properties:
 From OS view the device is basically an i2c-mux used to communicate with up to
 four smart battery devices at address 0xb. The driver actually implements this
 behaviour. So standard i2c-mux nodes can be used to register up to four slave
-batteries. Channels will be numerated starting from 1 to 4.
+batteries. See Documentation/devicetree/bindings/i2c/i2c-mux.txt for more
+information on i2c-mux nodes. Channels will be numerated starting from 1 to 4.
 
 Example:

Rob, are you OK with that change?
> 
> Cheers,
> Peter
tanks.
-- 
Karl-Heinz


