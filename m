From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/3] PM / OPP: Cleanup a little bit of a bitrot
Date: Fri, 30 Jan 2015 01:15:24 +0100
Message-ID: <4187062.hmyJpUahmT@vostro.rjw.lan>
References: <1419441777-25651-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59317 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753206AbbA2Xwg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jan 2015 18:52:36 -0500
In-Reply-To: <1419441777-25651-1-git-send-email-nm@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday, December 24, 2014 11:22:54 AM Nishanth Menon wrote:
> It is a little usual to see with multiple contributors that file tends to loose
> a consistent feel. So, try and fix it up in this trivial change series - no
> functional changes at all.
> 
> 
> based on v3.19-rc1 tag
> 
> Nishanth Menon (3):
>   PM / OPP: export dev_pm_opp_get_notifier
>   PM / OPP: Ensure consistent naming of static functions
>   PM / OPP: Update kernel documentation
> 
>  drivers/base/power/opp.c |  190 +++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 146 insertions(+), 44 deletions(-)

Whole series queued up for 3.20, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
