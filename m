Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490766;
	b=eUObc4W+TXcV8WM7yla/Pou4SA6yd75Eyru18VzugTt9on5I9VrnzeQAfwJzmNb9cw4V
	 skNwi+yqvELs1lVO28vMmI9d0oQ4eey1DnJh/2jKK+oIUerXhF9E+se7Ah2Syd9dewh6/
	 AsWysruA7gBlDhdsv2HIofZ6Mi9FzzQvMp4ws2ng9SSANlS2I6ma+f1Cnxb2dI2+EpGYT
	 37+3ZPMAPeeShf5Aw8Vi7gKNzKO7hdNw5GkHMB6R5pIyxZHfUj9d3DnTQS+2XZx7lDRcX
	 +4g6D+/innD4KvgYs6jzR6BDKkyJ05/2NePc357a2ZXInKxl9s3CocxcBjIGp8NWA4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490766;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=6mTsU7SiJn/LCB9rHS17WTPqu/JpjhK0J6xpMHSVII8=;
	b=vQVN7MzsN2oX0DDomRFg6kk6LZOeN1RKqIDQRl2oUsOCjQP22pZclNcRNGKLCxrBm0Uc
	 6y4jb18yCRmsuGOnVirG2Uz3eSLowf4u+bAXBAiiO9JsEL4w40YLHV+gugGTC2l3L8VQG
	 VEg/1VJpmtAiWTCqozP3PRwI9vBXzqH2i4qOsX5hvpaHG/gv05bdRBR8GJbmR90g6WbOT
	 9j5mD5tJUtYxPktoa9fp3NJOSneGnbZ1x+Zm1rN1W1ll2KGPEXiRw+Kt1qcvitly8TnzH
	 SPXiMLqeeVOKRipb7MdPDRvGQwZ40rLgwyPsxQlCufBW941tMoIvYSIIH6RoNZLqIeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GpLKvZTW;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAF2606A31C;
	Thu, 12 Nov 2026 13:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FAF2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GpLKvZTW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794490766; x=1826026766;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SFwVMt/H0xErcXlhJS33OEJlSasnR5vPHpX9RH9wU5A=;
  b=GpLKvZTWD7OyTv5fB62EcSB+Lv2cgaWBlUA6x94vRRvZJ/1K5yS2x/7p
   7zQVhCBiOJQYdHgWUQScSsPjpjeeTJ0ahaih5NuR6e5MPb3zn0wQ+FOta
   bWYiRVx3Hpd3889bOc9jTJA+txs5Eb/OUdkVY7c7EsR2+WZQJm8bj0VgQ
   oRVXUv9N/FEz/d+k2NE+/IPsaJblVRPJas28F7i9Wqr7ofDleKe7sQq8s
   xLNftvRfJuDSoDwwNMtJmEwVCuoGy4lG/YtWHJDkowBBZ1EaZBJU107hP
   BOaIuP6yCXWAKSWzkDpiJvs0TNDAQqEUE/rmzW95dubKPSU3a/ypQDm+1
   A==;
X-CSE-ConnectionGUID: dgKHZlPqSi6tSNN0aDXF8A==
X-CSE-MsgGUID: w7UZFzg6QCmUf81+x8cBTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3305821"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3305821"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 05:39:25 -0800
X-CSE-ConnectionGUID: tpYu0zSdRsWVI3EnQFrG1w==
X-CSE-MsgGUID: SrVBhbs8TpuaatP+Ljp65w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8485126"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.6])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 05:39:22 -0800
Date: Thu, 12 Nov 2026 15:39:19 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kamal.wadhwa@oss.qualcomm.com,
	Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Subject: Re: [PATCH] thermal: qcom-spmi-adc-tm5-gen3: move hardirq actions
 into threaded handler
Message-ID: <avXBhyKMlqaLUeGQ@ashevche-desk.local>
References: <20261111-adctm5_gen3_hardirq_removal-v1-1-536ed503396c@oss.qualcomm.com>
 <avR6cHb6ZUsDzIV2@ashevche-desk.local>
 <5c879271-6e88-4683-a280-eef292c442ba@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c879271-6e88-4683-a280-eef292c442ba@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 12, 2026 at 01:54:13PM +0530, Jishnu Prakash wrote:
> On 11/11/2026 7:53 PM, Andy Shevchenko wrote:
> > On Wed, Nov 11, 2026 at 02:12:01PM +0530, Jishnu Prakash wrote:

...

> >> -static irqreturn_t adctm5_gen3_isr(int irq, void *dev_id)
> >> +static irqreturn_t adctm5_gen3_isr_thread(int irq, void *dev_id)
> >>  {
> >>  	struct adc_tm5_gen3_chip *adc_tm5 = dev_id;
> >> -	int ret, sdam_num;
> >> +	int sdam_index, ret;
> > 
> > Was the variable rename so important for the fix? Can we defer it to the later
> > cleanups, if ever needed?
> > 
> >>  	u8 tm_status[2];
> >>  	u8 status, val;

...

> >> -	struct adc_tm5_gen3_chip *adc_tm5 = dev_id;
> >> -	u8 tm_status[2];
> >> -	int sdam_index;
> > 
> > Okay, I see the reason now why it's done, but I noticed no mention of this in
> > the commit message. Also it's unclear which variable is used more often and
> > what is the real semantics of its value. Is it number or index?

> > With all this
> > in mind, please at bare minimum elaborate in the commit message and, if it's
> > actually a number, replace the other part instead.

^^^

> In both adctm5_gen3_isr() and adctm5_gen3_isr_thread(), we needed a variable to
> store the index of the SDAM whose IRQ was triggered. We called it 'sdam_num'
> in adctm5_gen3_isr() and 'sdam_index' in adctm5_gen3_isr_thread(). In the rest
> of the file, it is called 'sdam_index', so ideally that same name should have
> been used in adctm5_gen3_isr() too, as it is more accurate than 'sdam_num'.
> 
> As I mentioned at the end of the commit message, I just meant to drop adctm5_gen3_isr()
> and expand adctm5_gen3_isr_thread() to include the actions formerly done in
> adctm5_gen3_isr(), but I see the diff makes it look more like I modified adctm5_gen3_isr()
> into adctm5_gen3_isr_thread() with a variable rename, which is a bit misleading.
> 
> I can add a line in the commit message to emphasize that 'sdam_num' is the same as
> 'sdam_index' if you think it helps.

Yes, see above.

-- 
With Best Regards,
Andy Shevchenko


