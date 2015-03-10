From: Todd E Brandt <todd.e.brandt@linux.intel.com>
Subject: Re: [PATCH v4 0/3] X-Power AXP288 PMIC Fuel Gauge Driver
Date: Tue, 10 Mar 2015 11:00:43 -0700
Message-ID: <20150310180043.GA1818@linux.intel.com>
References: <cover.1423082056.git.todd.e.brandt@linux.intel.com>
 <20150307192610.GC5233@earth>
Reply-To: todd.e.brandt@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:19579 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752446AbbCJSAr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 10 Mar 2015 14:00:47 -0400
Content-Disposition: inline
In-Reply-To: <20150307192610.GC5233@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, todd.e.brandt@intel.com, jacob.jun.pan@linux.intel.com, sameo@linux.intel.com, lee.jones@linaro.org, david.woodhouse@intel.com, jic23@kernel.org, ramakrishna.pallala@intel.com

On Sat, Mar 07, 2015 at 08:26:11PM +0100, Sebastian Reichel wrote:
> Hi,
> 
> On Wed, Feb 04, 2015 at 04:24:35PM -0800, Todd Brandt wrote:
> > New power_supply driver at driver/power which interfaces with the
> > axp20x mfd driver as a cell. Provides battery info, monitors for
> > changes, and generates alerts on temperature and capacity issues
> > 
> > Sebestian, please review the patch set and consider it for 3.20 rc1.
> > I've applied it over git.infradead.org/battery-2.6.git/master and
> > verified that it works. Thanks.
> > 
> > Todd Brandt (3):
> >   mfd/axp20x: change battery cell name to fuel gauge
> >   mfd/axp20x: add support for fuel gauge cell
> >   X-Power AXP288 PMIC Fuel Gauge Driver
> 
> Thanks, queued for 4.1: 
> 
> http://git.infradead.org/battery-2.6.git/commit/5a5bf49088f4c92f36786a2e4c20e17f715f0827
> 
> -- Sebastian

Excellent, thanks! Also, I should also mention that Ramakrishna Pallala was
the author of the original draft of the XPower fuel gauge driver. I ported
and tested it for upstream use. He can also serve as a maintainer.
