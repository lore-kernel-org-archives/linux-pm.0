From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: CPUfreq lockdep issue
Date: Mon, 22 Feb 2016 14:40:35 +0530
Message-ID: <20160222091035.GL28226@vireshk-i7>
References: <1455793609.9851.45.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34192 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbcBVJKy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Feb 2016 04:10:54 -0500
Received: by mail-pf0-f169.google.com with SMTP id x65so89646446pfb.1
        for <linux-pm@vger.kernel.org>; Mon, 22 Feb 2016 01:10:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1455793609.9851.45.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Daniel Vetter <daniel.vetter@intel.com>

On 18-02-16, 13:06, Joonas Lahtinen wrote:
> Hi,
> 
> The Intel P-state driver has a lockdep issue as described below. It
> could in theory cause a deadlock if initialization and suspend were to
> be performed simultaneously. Conflicting calling paths are as follows:

Hi,

I have cc'd you to a patch today, can you please test that and verify
that the problem is gone now ?

-- 
viresh
