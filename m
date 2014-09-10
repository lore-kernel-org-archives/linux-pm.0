From: Anup Chenthamarakshan <anupc@chromium.org>
Subject: Re: [PATCH] intel_pstate: track and export frequency residency stats
 via sysfs.
Date: Wed, 10 Sep 2014 16:39:05 -0700
Message-ID: <20140910233905.GA2439@google.com>
References: <1410221424-20590-1-git-send-email-anupc@chromium.org>
 <54107EC2.1010501@intel.com>
 <20140910221508.GA18951@google.com>
 <1610826.tK4V65ABJD@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:54446 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176AbaIJXjJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Sep 2014 19:39:09 -0400
Received: by mail-pa0-f51.google.com with SMTP id kx10so8598021pab.10
        for <linux-pm@vger.kernel.org>; Wed, 10 Sep 2014 16:39:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1610826.tK4V65ABJD@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, Sameer Nanda <snanda@chromium.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Sep 11, 2014 at 12:49:48AM +0200, Rafael J. Wysocki wrote:
> On Wednesday, September 10, 2014 03:15:08 PM Anup Chenthamarakshan wrote:
> > 
> > Tools like powertop and turbostat are not present by default on all systems,
> > so it is not always possible to use them :(
> 
> Which systems are you referring to in particular?

We're testing on Chrome OS devices (Chromebooks).

> 
> -- 
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
