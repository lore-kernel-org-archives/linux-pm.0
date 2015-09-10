From: Laurentiu Palcu <laurentiu.palcu@intel.com>
Subject: Re: [PATCH v2 06/13] power: bq24257: Add input DPM voltage threshold
 setting support
Date: Thu, 10 Sep 2015 16:27:46 +0300
Message-ID: <20150910132745.GH21512@lpalcu-desk>
References: <1441757557-7266-1-git-send-email-dannenberg@ti.com>
 <1441757557-7266-7-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:27270 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751971AbbIJN1t (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 10 Sep 2015 09:27:49 -0400
Content-Disposition: inline
In-Reply-To: <1441757557-7266-7-git-send-email-dannenberg@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andreas Dannenberg <dannenberg@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On Tue, Sep 08, 2015 at 07:12:30PM -0500, Andreas Dannenberg wrote:
> A new optional device property called "ti,in-dpm-voltage" is introduced
> to allow configuring the input voltage threshold for the devices'
> dynamic power path management (DPM) feature. In short, it can be used to
> prevent the input voltage from dropping below a certain value as current
> is drawn to charge the battery or supply the system.
> 
> Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
Reviewed-by: Laurentiu Palcu <laurentiu.palcu@intel.com>
