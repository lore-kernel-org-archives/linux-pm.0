From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [RFC/RFT 5/6] i2c: qup: Get rid of clock handling as its done
 using runtime callbacks
Date: Fri, 24 Apr 2015 08:02:12 +0530
Message-ID: <5539AB2C.5060503@codeaurora.org>
References: <1429778744-13352-1-git-send-email-rnayak@codeaurora.org>	<1429778744-13352-6-git-send-email-rnayak@codeaurora.org> <7hoame5yw3.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <7hoame5yw3.fsf@deeprootsystems.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 04/24/2015 02:46 AM, Kevin Hilman wrote:
> Rajendra Nayak <rnayak@codeaurora.org> writes:
>
>> Remove all clock handling from the driver as this is not handled from
>> within platform runtime callbacks.
>
> s/not/now/  ??

yeah, it was a typo. I will fix it here and in the next (6/6) patch.
thanks for taking a look.

regards,
Rajendra
