From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v9 1/4] gadget: Introduce the usb charger framework
Date: Wed, 6 Apr 2016 16:11:24 +0800
Message-ID: <20160406081124.GE21101@shlinux2.ap.freescale.net>
References: <cover.1459494743.git.baolin.wang@linaro.org>
 <6c594cc66fd06b575b04cc8bb0fe0374d0501d4d.1459494744.git.baolin.wang@linaro.org>
 <20160406072513.GB21101@shlinux2.ap.freescale.net>
 <87vb3v2nm8.fsf@intel.com>
 <20160406074310.GC21101@shlinux2.ap.freescale.net>
 <87shyz2md5.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35963 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754721AbcDFISJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2016 04:18:09 -0400
Content-Disposition: inline
In-Reply-To: <87shyz2md5.fsf@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: Baolin Wang <baolin.wang@linaro.org>, gregkh@linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, lee.jones@linaro.org, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org

On Wed, Apr 06, 2016 at 11:05:26AM +0300, Felipe Balbi wrote:
> Peter Chen <hzpeterchen@gmail.com> writes:
> > On Wed, Apr 06, 2016 at 10:38:23AM +0300, Felipe Balbi wrote:
> >> Peter Chen <hzpeterchen@gmail.com> writes:
> >> > On Fri, Apr 01, 2016 at 03:21:49PM +0800, Baolin Wang wrote:
> >> >  +
> >> >> +static struct attribute *usb_charger_attrs[] = {
> >> >> +	&dev_attr_sdp_current.attr,
> >> >> +	&dev_attr_dcp_current.attr,
> >> >> +	&dev_attr_cdp_current.attr,
> >> >> +	&dev_attr_aca_current.attr,
> >> >> +	&dev_attr_charger_type.attr,
> >> >> +	&dev_attr_charger_state.attr,
> >> >> +	NULL
> >> >> +};
> >> >
> >> > The user may only care about current limit, type and state, why they
> >> > need to care what type's current limit, it is the usb charger
> >> > framework handles, the framework judge the current according to
> >> > charger type and USB state (connect/configured/suspended).
> >> 
> >> it might be useful if we want to know that $this charger doesn't really
> >> give us as much current as it advertises.
> >> 
> >
> > As my understanding, the current limit is dynamic value, it should
> > report the value the charger supports now, eg, it connects SDP, but
> > the host is suspended now, then the value should be 2mA.
> 
> yes, and that's the limit. Now consider we connect to DCP or CDP and
> limit is 2000mA but we're charging at 1000mA ;-)
> 

The user doesn't need to know the value which spec designs.

-- 

Best Regards,
Peter Chen
