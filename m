From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 11/17] pm: bf609: remove misuse of IRQF_NO_SUSPEND flag
Date: Mon, 19 Oct 2015 18:38:37 +0100
Message-ID: <56252A9D.1070505@arm.com>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
 <1442850433-5903-12-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51376 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753164AbbJSRik (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 19 Oct 2015 13:38:40 -0400
In-Reply-To: <1442850433-5903-12-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Steven Miao <realmz6@gmail.com>, "adi-buildroot-devel@lists.sourceforge.net" <adi-buildroot-devel@lists.sourceforge.net>
Cc: Sudeep Holla <Sudeep.Holla@arm.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>



On 21/09/15 16:47, Sudeep Holla wrote:
> The IRQF_NO_SUSPEND flag is used to identify the interrupts that should
> be left enabled so as to allow them to work as expected during the
> suspend-resume cycle, but doesn't guarantee that it will wake the system
> from a suspended state, enable_irq_wake is recommended to be used for
> the wakeup.
>
> This patch removes the use of IRQF_NO_SUSPEND flags replacing it with
> enable_irq_wake instead.
>
> Cc: Steven Miao <realmz6@gmail.com>

Gentle Ping !

-- 
Regards,
Sudeep
