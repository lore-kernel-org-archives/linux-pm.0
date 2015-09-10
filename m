From: Laurentiu Palcu <laurentiu.palcu@intel.com>
Subject: Re: [PATCH v2 09/13] power: bq24257: Allow input current limit sysfs
 access
Date: Thu, 10 Sep 2015 17:06:30 +0300
Message-ID: <20150910140630.GK21512@lpalcu-desk>
References: <1441757557-7266-1-git-send-email-dannenberg@ti.com>
 <1441757557-7266-10-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:7215 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752116AbbIJOGd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 10 Sep 2015 10:06:33 -0400
Content-Disposition: inline
In-Reply-To: <1441757557-7266-10-git-send-email-dannenberg@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andreas Dannenberg <dannenberg@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On Tue, Sep 08, 2015 at 07:12:33PM -0500, Andreas Dannenberg wrote:
> This patch allows reading (and writing, if the D+/D- USB signal-based
> charger type detection is disabled) of the input current limit through
> the POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT sysfs property. This allows
> userspace to see what charger was detected and to re-configure the
> maximum current drawn from the external supply at runtime based on
> system-level knowledge or user input.
> 
> Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
Reviewed-by: Laurentiu Palcu <laurentiu.palcu@intel.com>
