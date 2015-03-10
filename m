From: "Tc, Jenny" <jenny.tc@intel.com>
Subject: RE: [RFC 1/4] power_supply: Introduce charging object table
Date: Tue, 10 Mar 2015 05:16:53 +0000
Message-ID: <20ADAB092842284E95860F279283C5642EECB1D7@BGSMSX104.gar.corp.intel.com>
References: <20ADAB092842284E95860F279283C5642EEC90C3@BGSMSX104.gar.corp.intel.com>
 <20150309140831.GA950@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:50130 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750773AbbCJFQ7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Mar 2015 01:16:59 -0400
In-Reply-To: <20150309140831.GA950@earth>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Sebastian Reichel' <sre@kernel.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Anton Vorontsov <anton.vorontsov@linaro.org>, David Woodhouse <dwmw2@infradead.org>, "jonghwa3.lee@samsung.com" <jonghwa3.lee@samsung.com>, "myungjoo.ham@gmail.com" <myungjoo.ham@gmail.com>, "Pallala, Ramakrishna" <ramakrishna.pallala@intel.com>

> 
> On Mon, Mar 09, 2015 at 12:26:21PM +0000, Tc, Jenny wrote:
> > > > +	char name[PSY_MAX_BAT_NAME_LEN];
> > >
> > > char *name;
> > >
> > > No need for arbitrary length limitation.
> >
> > The length limitation is introduced to form a packed structure so that
> > the data can be read directly from memory without parsing.
> 
> This reason is ok for a device driver, but not for a kernel
> subsystem.

Agree, will fix this. Same for psy_temp_mon_table temp_mon_table

-Jenny
