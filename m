From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v6 00/48] kernel: Add support for power-off handler call
 chain
Date: Mon, 10 Nov 2014 06:12:35 -0800
Message-ID: <5460C7D3.10505@roeck-us.net>
References: <1415583785-6980-1-git-send-email-linux@roeck-us.net> <20141110083347.GA29543@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58715 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014AbaKJONY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Nov 2014 09:13:24 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1Xnpie-003MT0-DQ
	for linux-pm@vger.kernel.org; Mon, 10 Nov 2014 14:13:24 +0000
In-Reply-To: <20141110083347.GA29543@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Alexander Graf <agraf@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Heiko Stuebner <heiko@sntech.de>, Lee Jones <lee.jones@linaro.org>, Len Brown <len.brown@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Romain Perier <romain.perier@gmail.com>

On 11/10/2014 12:33 AM, Pavel Machek wrote:
> Hi!
>
>> Introduce a system power-off handler call chain to solve the described
>> problems.  This call chain is expected to be executed from the architecture
>> specific machine_power_off() function.  Drivers providing system power-off
>> functionality are expected to register with this call chain.  By using the
>> priority field in the notifier block, callers can control power-off
>> handler
>
> Linus rather disliked the idea of notifier chains for this... And I
> don't see how it got addressed.
>
As I understand, Linus primarily disliked the idea of callbacks, which is
what the code does, only with no order or protection against race conditions.

Frankly I have no idea how to solve the power-off problem without callbacks.
If you have one, please let me know.

Guenter

