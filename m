From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 07/17] input: tegra-kbc: drop use of IRQF_NO_SUSPEND flag
Date: Tue, 22 Sep 2015 11:00:25 +0100
Message-ID: <560126B9.2000106@arm.com>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
 <1442850433-5903-8-git-send-email-sudeep.holla@arm.com>
 <20150921232132.GE11284@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150921232132.GE11284@x1>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Hi Lee,

On 22/09/15 00:21, Lee Jones wrote:
> The $SUBJECT is not correct.
>

Any suggestions ? Most of this series I have used "remove misuse..."
But this driver was doing things correctly, just that it left this
flag as is.

Regards,
Sudeep
