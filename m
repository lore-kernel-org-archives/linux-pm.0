From: Andreas Dannenberg <dannenberg@ti.com>
Subject: Re: [RFC] TI BQ242xx Battery Charger Development/Consolidation Plans
Date: Wed, 12 Aug 2015 11:20:41 -0500
Message-ID: <55CB7259.3010608@ti.com>
References: <1438706177-8115-1-git-send-email-dannenberg@ti.com>	<55C23441.2030305@ti.com> <CAD03FC+DqSdg_LZ-SNaCNLsh9eZS9hSeJL5Q+8aWU+bGVcVPDQ@mail.gmail.com> <D854C92F57B1B347B57E531E78D05EAD578BCD90@BGSMSX104.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35018 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932165AbbHLQVJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 12 Aug 2015 12:21:09 -0400
In-Reply-To: <D854C92F57B1B347B57E531E78D05EAD578BCD90@BGSMSX104.gar.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Pallala, Ramakrishna" <ramakrishna.pallala@intel.com>, Laurentiu Palcu <lpalcu@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, "Palcu, Laurentiu" <laurentiu.palcu@intel.com>, =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

Hi Ram,

On 08/11/2015 06:12 AM, Pallala, Ramakrishna wrote:
> I have a separate driver for bq24261 charger and it is ready for upstream. Can I push the patch?
> 
> Thanks,
> Ram
> 

Wow I'm impressed! You are doing all the TI drivers so there is nothing left
for me to do :) On a more serious note thanks for chiming in here.

Could you please share/post the driver that you have?

The bq24261 is basically the same as the bq24261M and bq24262 that I'm working
on so I would like to check feature completeness and how I could potentially
integrate pieces of my work into yours.

Also while we are at it, please note the bq24261 is "not recommended for new
designs" by TI. What should be used instead moving forward is the bq24261M.

Thanks and Regards,

-- 
Andreas Dannenberg
Texas Instruments Inc.
