From: Andreas Dannenberg <dannenberg@ti.com>
Subject: Re: [PATCH v5 09/11] power: bq24257: Allow input current limit sysfs
 access
Date: Tue, 22 Sep 2015 17:10:45 -0500
Message-ID: <20150922221044.GB30297@beast>
References: <1442612399-341-1-git-send-email-dannenberg@ti.com>
 <1442612399-341-10-git-send-email-dannenberg@ti.com>
 <20150922191649.GA9949@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53925 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759824AbbIVWRT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2015 18:17:19 -0400
Content-Disposition: inline
In-Reply-To: <20150922191649.GA9949@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ramakrishna Pallala <ramakrishna.pallala@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On Tue, Sep 22, 2015 at 09:16:49PM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Fri, Sep 18, 2015 at 04:39:57PM -0500, Andreas Dannenberg wrote:
> > This patch allows reading (and writing, if the D+/D- USB signal-based
> > charger type detection is disabled) of the input current limit through
> > the power supply's input_current_limit sysfs property. This allows
> > userspace to see what charger was detected and to re-configure the
> > maximum current drawn from the external supply at runtime based on
> > system-level knowledge or user input.
> 
> Maybe also support writing into input_current_limit in auto mode.
> Just disable auto detection until "auto" is written into sysfs node.

Auto-detection was enabled by default in the original driver so I think
that should be left intact. I added the ability to manually override
this via DT with a fixed value, and then configure said fixed value
through sysfs at runtime.

I'm not 100% clear on the usecase of runtime enabling/disabling auto so
I'd rather leave the implementation as-is. Either auto mode is enabled
or not -- and this is directly tied to the DT setting. But if someone
has a strong usecase for this I can certainly add it.

Regards,

--
Andreas Dannenberg
Texas Instruments Inc

> 
> -- Sebastian


