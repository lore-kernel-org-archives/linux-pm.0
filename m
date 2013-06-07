From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] PM: use dpm_run_callback in device_prepare
Date: Fri, 7 Jun 2013 10:37:06 -0700
Message-ID: <20130607173706.GA29615@kroah.com>
References: <1370593232-3602-1-git-send-email-shuox.liu@intel.com>
 <1370593232-3602-2-git-send-email-shuox.liu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:34932 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756005Ab3FGRhH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jun 2013 13:37:07 -0400
Content-Disposition: inline
In-Reply-To: <1370593232-3602-2-git-send-email-shuox.liu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: shuox.liu@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, pavel@ucw.cz, rjw@sisk.pl, len.brown@intel.com, yanmin_zhang@linux.intel.com, Zhang Yanmin <yanmin.zhang@intel.com>

On Fri, Jun 07, 2013 at 04:20:31PM +0800, shuox.liu@intel.com wrote:
> From: ShuoX Liu <shuox.liu@intel.com>
> 
> dpm_run_callback could show more debug info around prepare stage.

Why?  Who needs this?  What problem does it solve?

Without answers to this, why would you expect us to accept such a
change?

greg k-h
