From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v10 1/4] device core: add device_is_bound()
Date: Sat, 24 Oct 2015 19:50:36 -0700
Message-ID: <20151025025036.GA25874@kroah.com>
References: <1445441654-31778-1-git-send-email-tomeu.vizoso@collabora.com>
 <1445441654-31778-2-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:34019 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbbJYIg7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2015 04:36:59 -0400
Content-Disposition: inline
In-Reply-To: <1445441654-31778-2-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-pm@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, martyn.welch@collabora.co.uk, Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org

On Wed, Oct 21, 2015 at 05:34:11PM +0200, Tomeu Vizoso wrote:
> Adds a function that tells whether a device is already bound to a
> driver.
> 
> This is needed to warn when there is an attempt to change the PM domain
> of a device that has finished probing already. The reason why we want to
> enforce that is because in the general case that can cause problems and
> also that we can simplify code quite a bit if we can always assume that.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
