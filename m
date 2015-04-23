From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [RFC/RFT 5/6] i2c: qup: Get rid of clock handling as its done using runtime callbacks
Date: Thu, 23 Apr 2015 14:16:12 -0700
Message-ID: <7hoame5yw3.fsf@deeprootsystems.com>
References: <1429778744-13352-1-git-send-email-rnayak@codeaurora.org>
	<1429778744-13352-6-git-send-email-rnayak@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1429778744-13352-6-git-send-email-rnayak@codeaurora.org>
	(Rajendra Nayak's message of "Thu, 23 Apr 2015 14:15:43 +0530")
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Rajendra Nayak <rnayak@codeaurora.org> writes:

> Remove all clock handling from the driver as this is not handled from
> within platform runtime callbacks.

s/not/now/  ??

Kevin
