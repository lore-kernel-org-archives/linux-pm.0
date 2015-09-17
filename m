From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] driver core: Ensure proper suspend/resume ordering
Date: Thu, 17 Sep 2015 02:55:14 +0200
Message-ID: <110984645.8TkJahYnoj@vostro.rjw.lan>
References: <1441880343-30852-1-git-send-email-thierry.reding@gmail.com> <2849486.q7QWJNfWm1@vostro.rjw.lan> <55F970BF.2050107@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:47399 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752424AbbIQA1N (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2015 20:27:13 -0400
In-Reply-To: <55F970BF.2050107@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday, September 16, 2015 04:38:07 PM Grygorii Strashko wrote:
> On 09/16/2015 04:18 AM, Rafael J. Wysocki wrote:
> > On Tuesday, September 15, 2015 05:53:02 PM Thierry Reding wrote:

[cut]

> 
> >
> > Did that patch manipulate dpm_list?
> 
> no.

So whether or not there were any problems with it is meaningless here.

Thanks,
Rafael

