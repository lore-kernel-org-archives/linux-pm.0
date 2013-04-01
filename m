From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: potential NULL dereference at get_target_state in
 drivers/thermal/fair_share.c
Date: Mon, 01 Apr 2013 09:09:14 +0800
Message-ID: <1364778554.2178.11.camel@rzhang1-mobl4>
References: <CAHdPZaOiONMyRdMsYVEQYeMjNsMQb3LG8zfKC0GYJNRtfAVPpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:17597 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752830Ab3DABJR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 31 Mar 2013 21:09:17 -0400
In-Reply-To: <CAHdPZaOiONMyRdMsYVEQYeMjNsMQb3LG8zfKC0GYJNRtfAVPpA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "devendra.aaru" <devendra.aaru@gmail.com>
Cc: linux-pm@vger.kernel.org, Durgadoss R <durgadoss.r@intel.com>

On Sat, 2013-03-30 at 15:35 +0530, devendra.aaru wrote:
> Hello Zhang, Durgadoss,
> 
> I have found a code that does this cdev->ops->get_max_state
> 
> static long get_target_state(struct thermal_zone_device *tz,
>                 struct thermal_cooling_device *cdev, int weight, int level)
> {
>         unsigned long max_state;
> 
>         cdev->ops->get_max_state(cdev, &max_state);
> 
>         return (long)(weight * level * max_state) / (100 * tz->trips);
> }
> 
> as the ops can be NULL the panic can occur. if not i have to check for
> a valid get_max_state pointer. so if the ops->get_max_state is NULL
> what should i suppose to be returning here?
> 
any cdev must be registered with valid ops and ops->get_max_state.
if ops or ops->get_max_state is NULL, it suggests a big problem, like
racing issue, etc, and IMO, a panic is more meaningful for us to debug
the problem here.

thanks,
rui

