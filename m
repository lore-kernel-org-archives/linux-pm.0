From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/3] PM / OPP: Add "opp-supported-hw" binding
Date: Mon, 2 Nov 2015 21:38:02 +0530
Message-ID: <20151102160802.GH3639@ubuntu>
References: <cover.1446167359.git.viresh.kumar@linaro.org>
 <2d52388bd7d3cc546ac3ab5afeb47bfcb3012213.1446167359.git.viresh.kumar@linaro.org>
 <20151030221826.GM19782@codeaurora.org>
 <20151031022003.GV3716@ubuntu>
 <CAL_JsqJ5tyQ11b5p=xigJwD2stPuqk7akJBhNU-NR6sov5uCiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33055 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288AbbKBQIH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Nov 2015 11:08:07 -0500
Received: by pabfh17 with SMTP id fh17so28545743pab.0
        for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2015 08:08:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAL_JsqJ5tyQ11b5p=xigJwD2stPuqk7akJBhNU-NR6sov5uCiA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Rafael Wysocki <rjw@rjwysocki.net>, Lee Jones <lee.jones@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Nishanth Menon <nm@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On 02-11-15, 09:13, Rob Herring wrote:
> There is no special meaning, just convention which is the unit-address
> should match the reg property address. I'm okay with an exception
> here.

Thanks, I will update this separately.

-- 
viresh
