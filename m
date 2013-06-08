From: Yanmin Zhang <yanmin_zhang@linux.intel.com>
Subject: Re: [PATCH 1/2] PM: use dpm_run_callback in device_prepare
Date: Sat, 08 Jun 2013 08:43:55 +0800
Message-ID: <1370652235.4432.70.camel@ymzhang.sh.intel.com>
References: <1370593232-3602-1-git-send-email-shuox.liu@intel.com>
	 <1370593232-3602-2-git-send-email-shuox.liu@intel.com>
	 <20130607173706.GA29615@kroah.com>
Reply-To: yanmin_zhang@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:26455 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753726Ab3FHAls (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 7 Jun 2013 20:41:48 -0400
In-Reply-To: <20130607173706.GA29615@kroah.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: shuox.liu@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, pavel@ucw.cz, rjw@sisk.pl, len.brown@intel.com, Zhang Yanmin <yanmin.zhang@intel.com>

On Fri, 2013-06-07 at 10:37 -0700, Greg KH wrote:
> On Fri, Jun 07, 2013 at 04:20:31PM +0800, shuox.liu@intel.com wrote:
> > From: ShuoX Liu <shuox.liu@intel.com>
> > 
> > dpm_run_callback could show more debug info around prepare stage.
> 
> Why?  Who needs this?  What problem does it solve?
> 
> Without answers to this, why would you expect us to accept such a
> change?
It's to provide more debug info and developers can quickly find what
prepare/complete callback consumes too much time.


