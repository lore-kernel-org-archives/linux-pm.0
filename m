From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH v6 1/5] qcom: spm: Add Subsystem Power Manager driver
Date: Fri, 26 Sep 2014 12:30:40 -0700
Message-ID: <7hr3yy2n8f.fsf@deeprootsystems.com>
References: <1411516281-58328-1-git-send-email-lina.iyer@linaro.org>
	<1411516281-58328-2-git-send-email-lina.iyer@linaro.org>
	<1F7E5951-7704-4ADE-A1D1-2E380FF2540A@codeaurora.org>
	<20140924184750.GA1004@ilina-mac.local>
	<7hwq8q2og3.fsf@deeprootsystems.com>
	<20140926191253.GH390@ilina-mac.local>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:50845 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754111AbaIZTam (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 26 Sep 2014 15:30:42 -0400
In-Reply-To: <20140926191253.GH390@ilina-mac.local> (Lina Iyer's message of
	"Fri, 26 Sep 2014 13:12:53 -0600")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Kumar Gala <galak@codeaurora.org>, sboyd@codeaurora.org, daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, lorenzo.pieralisi@arm.com, linux-pm@vger.kernel.org

Lina Iyer <lina.iyer@linaro.org> writes:

> On Fri, Sep 26 2014 at 13:04 -0600, Kevin Hilman wrote:
>>Lina Iyer <lina.iyer@linaro.org> writes:
>>
>>> On Wed, Sep 24 2014 at 12:07 -0600, Kumar Gala wrote:

[...]

>>>>
>>>>General comment, lets use qcom instead of msm for various things.
>>>>
>>>>[snip]
>>>>
>>> OK, Done. I renamed all msm_ functions to qcom_ functions as well.
>>>
>>
>>Does that apply to the other parts of this series too?  like the msm-pm
>>and cpuidle layers?
>>
> Yes, there are no more msm's anymore :)
>

<can of worms>

What about Documentation/devicetree/bindings/arm/msm?

</can of worms>
