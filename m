From: viresh kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/7] OPP: Redefine bindings to overcome shortcomings
Date: Wed, 25 Feb 2015 09:15:32 +0530
Message-ID: <54ED455C.3010700@linaro.org>
References: <cover.1423642246.git.viresh.kumar@linaro.org>	<be795ef7ec98669bc5aa90ec426a1ec1fbc32b6c.1423642246.git.viresh.kumar@linaro.org>	<7ha904b6hp.fsf@deeprootsystems.com>	<CAKohpo=CRkJTkp2FXgYNwd2eEtMVRFuwJ=GPtX7+9WnQD6CK2Q@mail.gmail.com> <7h8ufn8c8q.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:41913 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121AbbBYDpr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 Feb 2015 22:45:47 -0500
Received: by pdno5 with SMTP id o5so1731282pdn.8
        for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2015 19:45:47 -0800 (PST)
In-Reply-To: <7h8ufn8c8q.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Rob Herring <rob.herring@linaro.org>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viswanath Puttagunta <viswanath.puttagunta@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, santosh shilimkar <santosh.shilimkar@oracle.com>, Rafael Wysocki <rjw@rjwysocki.net>, "olof@lixom.net" <olof@lixom.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Mike Turquette <mike.turquette@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Grant Likely <grant.likely@linaro.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lucas Stach <l.stach@pengutronix.de>

On Tuesday 24 February 2015 10:42 PM, Kevin Hilman wrote:
> Viresh Kumar <viresh.kumar@linaro.org> writes:

> s/they share clock lines/they share clock and/or voltage lines/

Hmm, will update that.

> OK, fair enough.  Looks like it's been thought through.  
> 
> However, in the end, I don't think it's going to avoid the "help of some
> algorithms."  The flag will tell you it's shared, but not how, and that
> will likely still need to be determined.

What did you mean by 'how' here? You wanted to say which devices share the
OPP? Yeah, a small piece of code is required and that's present in my patchset.

