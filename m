From: Andreas Dannenberg <dannenberg@ti.com>
Subject: Re: [PATCH v4 08/10] power: bq24257: Allow input current limit sysfs
 access
Date: Wed, 16 Sep 2015 14:45:28 -0500
Message-ID: <20150916194527.GE27772@beast>
References: <1442339914-25843-1-git-send-email-dannenberg@ti.com>
 <1442339914-25843-9-git-send-email-dannenberg@ti.com>
 <55F90CAA.5090701@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43387 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751689AbbIPTqF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 16 Sep 2015 15:46:05 -0400
Content-Disposition: inline
In-Reply-To: <55F90CAA.5090701@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Ramakrishna Pallala <ramakrishna.pallala@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On Wed, Sep 16, 2015 at 03:31:06PM +0900, Krzysztof Kozlowski wrote:
> On 16.09.2015 02:58, Andreas Dannenberg wrote:
> > This patch allows reading (and writing, if the D+/D- USB signal-based
> > charger type detection is disabled) of the input current limit through
> > the POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT sysfs property. This allows
> > userspace to see what charger was detected and to re-configure the
> > maximum current drawn from the external supply at runtime based on
> > system-level knowledge or user input.
> > 
> > Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
> > ---
> >  drivers/power/bq24257_charger.c | 67 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 67 insertions(+)
> > 
> 
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> BTW you are exposing more and more sysfs attributes which are userspace
> interfaces. They should be documented:
> Documentation/SubmitChecklist - point 19
> Documentation/ABI/README

The patch comment is not 100% accurate. I'm not declaring/exposing a new
sysfs property but rather use the power supply framework to expose the
sysfs property that's associated with POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT
which is actually called "input_current_limit". Will reword the description
to make this clearer.

Regards,

--
Andreas Dannenberg
Texas Instruments Inc

> 
> Although not all new drivers (and perhaps not all reviewers) follow this
> rule...
> 
> Best regards,
> Krzysztof
> 
