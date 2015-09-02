From: Andreas Dannenberg <dannenberg@ti.com>
Subject: Re: [PATCH 00/13] power: bq24257: Add support for bq24250/bq24251
Date: Wed, 2 Sep 2015 09:09:38 -0500
Message-ID: <20150902140938.GB24076@borg>
References: <1441073435-12349-1-git-send-email-dannenberg@ti.com>
 <20150902080754.GE12822@lpalcu-desk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50048 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751876AbbIBOKL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 2 Sep 2015 10:10:11 -0400
Content-Disposition: inline
In-Reply-To: <20150902080754.GE12822@lpalcu-desk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laurentiu Palcu <laurentiu.palcu@intel.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On Wed, Sep 02, 2015 at 11:07:54AM +0300, Laurentiu Palcu wrote:
> On Mon, Aug 31, 2015 at 09:10:22PM -0500, Andreas Dannenberg wrote:
> > Also if you could recommend an embedded HW platform that I could
> > generally use to test ACPI support I'd appreciate that (MinnowBoard
> > MAX?).
> I suppose you could use a Minnow Max quite well, if you wish. It has I2C
> pins available on the Low Speed Expansion connector and you could easily
> connect an EVB to it. You'll need to override the ACPI tables though, in
> order to add your own device description.

Thanks, will get one. I don't like to modify/change code without being
able to really test all aspects of it (like in this case, ACPI) so this
will fill an important gap.

Regards,

--
Andreas Dannenberg
Texas Instruments Inc


> 
> laurentiu
>  
