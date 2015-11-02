From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/3] PM / OPP: Add "opp-supported-hw" binding
Date: Mon, 2 Nov 2015 09:13:17 -0600
Message-ID: <CAL_JsqJ5tyQ11b5p=xigJwD2stPuqk7akJBhNU-NR6sov5uCiA@mail.gmail.com>
References: <cover.1446167359.git.viresh.kumar@linaro.org> <2d52388bd7d3cc546ac3ab5afeb47bfcb3012213.1446167359.git.viresh.kumar@linaro.org>
 <20151030221826.GM19782@codeaurora.org> <20151031022003.GV3716@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35197 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752246AbbKBPNj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 2 Nov 2015 10:13:39 -0500
In-Reply-To: <20151031022003.GV3716@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Rafael Wysocki <rjw@rjwysocki.net>, Lee Jones <lee.jones@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Nishanth Menon <nm@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Fri, Oct 30, 2015 at 9:20 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 30-10-15, 15:18, Stephen Boyd wrote:
>> A side-note. I wonder if it would be better style to have the
>> node name be:
>>
>>               opp@600000000 {
>
> I thought the @... had a special meaning and we might end up creating
> some device for the node then? Perhaps I am mistaken.

There is no special meaning, just convention which is the unit-address
should match the reg property address. I'm okay with an exception
here.

Rob
