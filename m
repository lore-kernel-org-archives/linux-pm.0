From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: In kernel power management domain_pm created for async schedules
Date: Wed, 6 Dec 2017 07:22:50 +0100
Message-ID: <20171206062250.GA19706@kroah.com>
References: <CGME20171206053831epcms5p58903d153d261ffd797e43b6983cda1ce@epcms5p5>
 <20171206053831epcms5p58903d153d261ffd797e43b6983cda1ce@epcms5p5>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:47820 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752423AbdLFGWp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Dec 2017 01:22:45 -0500
Content-Disposition: inline
In-Reply-To: <20171206053831epcms5p58903d153d261ffd797e43b6983cda1ce@epcms5p5>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vikas Bansal <vikas.bansal@samsung.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "len.brown@intel.com" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Dec 06, 2017 at 05:38:31AM +0000, Vikas Bansal wrote:
> If there is a driver in system which starts creating async schedules just after resume (Same as our case, in which we faced issue). Then async_synchronize_full API in PM cores starts waiting for completion of async schedules created by that driver (Even though those are in a domain). Because of this kernel resume time is increased (We faces the same issue) and whole system is delayed. 
> This problem can be solved by creating is domain for async schedules in PM core (As we solved in our case). Below patch is for solving this problem.

Please properly line-wrap your changelog text, _AND_ put it in the
changelog itself. Right now you have a patch:

> >From b8ea152eed6eef3b53275e7dd240a4d2124e9d4d Mon Sep 17 00:00:00 2001
> From: Anuj Gupta <anuj01.gupta@samsung.com>
> Date: Tue, 5 Dec 2017 21:34:49 -0800
> Subject: [PATCH] Added domain_pm to PM core
> 
> 
> Signed-off-by: Vikas Bansal <vikas.bansal@samsung.com>

With no changelog text at all.

Please look at any of the hundreds of patches on the mailing list as an
example of how to properly format this.

Also, you didn't address my review comment I made last time, why not?

thanks,

greg k-h
