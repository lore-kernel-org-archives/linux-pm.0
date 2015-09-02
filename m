From: Laurentiu Palcu <laurentiu.palcu@intel.com>
Subject: Re: [PATCH 04/13] power: bq24257: Allow manual setting of input
 current limit
Date: Wed, 2 Sep 2015 11:23:52 +0300
Message-ID: <20150902082352.GG12822@lpalcu-desk>
References: <1441073435-12349-1-git-send-email-dannenberg@ti.com>
 <1441073435-12349-5-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:29115 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751763AbbIBIYQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 2 Sep 2015 04:24:16 -0400
Content-Disposition: inline
In-Reply-To: <1441073435-12349-5-git-send-email-dannenberg@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andreas Dannenberg <dannenberg@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On Mon, Aug 31, 2015 at 09:10:26PM -0500, Andreas Dannenberg wrote:
> A new device property called "ti,in-ilimit-autoset-disable" is
> introduced to allow disabling the D+/D- based auto-detection algorithm
> used to determine the input current limit. This feature is also
> explicitly disabled on bq25250 devices which don't support D+/D-
s/bq25250/bq24250/

The rest looks good.
laurentiu
