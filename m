From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 06/35 linux-next] power: constify of_device_id array
Date: Tue, 17 Mar 2015 11:38:04 +0000
Message-ID: <5508121C.4040104@arm.com>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be> <1426533469-25458-7-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:36685 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646AbbCQLhw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Mar 2015 07:37:52 -0400
In-Reply-To: <1426533469-25458-7-git-send-email-fabf@skynet.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Santosh Shilimkar <ssantosh@kernel.org>, Liviu Dudau <Liviu.Dudau@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>



On 16/03/15 19:17, Fabian Frederick wrote:
> of_device_id is always used as const.
> (See driver.of_match_table and open firmware functions)
>

Not sure if you really need acks for simple change like this, anyways
for vexpress parts in patch 06, 26 and 32

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Regards,
Sudeep

