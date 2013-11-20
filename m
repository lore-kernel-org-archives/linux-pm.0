From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH 3/7] idle, thermal, acpi: Remove home grown idle implementations
Date: Wed, 20 Nov 2013 08:40:49 -0800
Message-ID: <528CE611.8040903@linux.intel.com>
References: <20131120160450.072555619@infradead.org> <20131120162736.508462614@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:49160 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754260Ab3KTQkw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 20 Nov 2013 11:40:52 -0500
In-Reply-To: <20131120162736.508462614@infradead.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, lenb@kernel.org, rjw@rjwysocki.net, Eliezer Tamir <eliezer.tamir@linux.intel.com>, Chris Leech <christopher.leech@intel.com>, David Miller <davem@davemloft.net>, rui.zhang@intel.com, jacob.jun.pan@linux.intel.com, Mike Galbraith <bitbucket@online.de>, Ingo Molnar <mingo@kernel.org>, hpa@zytor.com, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On 11/20/2013 8:04 AM, Peter Zijlstra wrote:
> This does not fully preseve existing behaviour in that the generic
> idle cycle function calls into the normal cpuidle governed idle
> routines and should thus respect things like QoS parameters and the
> like.


NAK on the powerclamp side.

powerclamp MUST NOT do that....
it is needed to go to the deepest state no matter what
(this is for when your system is overheating. there is not a lot of choice
here... alternative is an emergency reset that the hardware does for safety)


