From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 2/4] time: Print wall time at die and reboot
Date: Wed, 19 Jul 2017 00:06:39 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1707190002300.2425@nanos>
References: <20170718212117.123296-1-salyzyn@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:40985 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752222AbdGRWGq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jul 2017 18:06:46 -0400
In-Reply-To: <20170718212117.123296-1-salyzyn@android.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Salyzyn <salyzyn@android.com>
Cc: linux-kernel@vger.kernel.org, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, linux-rtc@vger.kernel.org, Mark Salyzyn <salyzyn@google.com>, Thierry Strudel <tstrudel@google.com>

On Tue, 18 Jul 2017, Mark Salyzyn wrote:

> Permits power state and battery life diagnosis.

This changelog is useless as long as you do not explain in which whay that
permits power state and battery life diagnosis.

I really have a hard time to figure out why you need to print RTC time on
oops or any of the other actions. That whole thing looks pretty
overengineered for a dubious value.

What kind of information is the current stuff missing and how are you using
this new information for better diagnosis?

Thanks,

	tglx
