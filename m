From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] x86_pkg_temp_thermal: Do not expose as a hwmon device
Date: Sun, 2 Mar 2014 18:04:52 +0100
Message-ID: <20140302180452.73fa2f8a@endymion.delvare>
References: <20140302153335.0f1326b6@endymion.delvare>
	<53135650.3070909@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33886 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751776AbaCBRE4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 2 Mar 2014 12:04:56 -0500
In-Reply-To: <53135650.3070909@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>

On Sun, 02 Mar 2014 08:03:28 -0800, Guenter Roeck wrote:
> On 03/02/2014 06:33 AM, Jean Delvare wrote:
> > The temperature value reported by x86_pkg_temp_thermal is already
> > reported by the coretemp driver. So, do not expose this thermal zone
> > as a hwmon device, because it would be redundant.
> >
> > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Eduardo Valentin <eduardo.valentin@ti.com>
> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> 
> Does that make the "Fix thermal zone type" patch unnecessary ?

I think both patches are needed, as type "pkg-temp-0" is wrong anyway,
regardless of the hwmon side of things. But it is less important with
this patch applied, indeed.

> If so, this patch would be a candidate for stable.

I'm still not 100% certain we want either patch in stable. After all,
they aren't fixing any critical bug, and they change user interfaces so
they could impact some users in unpredictable ways.

-- 
Jean Delvare
SUSE L3 Support
