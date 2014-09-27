From: Pramod Gurav <pramod.gurav@smartplayin.com>
Subject: Re: [PATCH v4] power: reset: use restart_notifier mechanism for msm-poweroff
Date: Sat, 27 Sep 2014 09:28:10 +0530
Message-ID: <542635D2.6060004@smartplayin.com>
References: <1411644831-2931-1-git-send-email-pramod.gurav@smartplayin.com> <20140926202523.GB27687@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp101.ord1c.emailsrvr.com ([108.166.43.101]:49785 "EHLO
	smtp101.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751281AbaI0D6V (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Sep 2014 23:58:21 -0400
In-Reply-To: <20140926202523.GB27687@earth.universe>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Josh Cartwright <joshc@codeaurora.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Stephen Boyd <sboyd@codeaurora.org>, linux-pm@vger.kernel.org

On 27-09-2014 01:55 AM, Sebastian Reichel wrote:
> Hi,
> 
> On Thu, Sep 25, 2014 at 05:03:51PM +0530, Pramod Gurav wrote:
>> This change replaces use of arm_pm_restart with recently introduced
>> reset mechanism in Linux kernel called restart_notifier.
>>
>> Choosing priority 128, which is default priority, as according to 
>> documentation, this mechanism is sufficient to restart the entire system.
> 
> http://git.infradead.org/battery-2.6.git/commit/18a702e0de9879d5c0225a09f494443f0b91a0cc

Thanks Sebastian.
> 
> -- Sebastian
> 
