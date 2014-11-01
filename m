From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 30/47] x86: iris: Register with kernel power-off handler
Date: Sat, 01 Nov 2014 14:15:49 -0700
Message-ID: <54554D85.2030308@roeck-us.net>
References: <1414425354-10359-1-git-send-email-linux@roeck-us.net> <1414425354-10359-31-git-send-email-linux@roeck-us.net> <alpine.DEB.2.11.1411012040510.5308@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:35867 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760205AbaKAVRA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 1 Nov 2014 17:17:00 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1Xkg2e-001dri-4H
	for linux-pm@vger.kernel.org; Sat, 01 Nov 2014 21:17:00 +0000
In-Reply-To: <alpine.DEB.2.11.1411012040510.5308@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org

On 11/01/2014 12:41 PM, Thomas Gleixner wrote:
> On Mon, 27 Oct 2014, Guenter Roeck wrote:
>
>> Register with kernel power-off handler instead of setting pm_power_off
>> directly. Register with high priority to reflect that the original code
>> overwrites existing power-off handlers.
>
> Acked-by-me for all the x86 parts of that series.
>
Thanks!

Guenter


