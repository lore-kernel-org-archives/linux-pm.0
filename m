From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH] [v2] x86, suspend: Save/restore extra MSR registers for
 suspend
Date: Mon, 24 Aug 2015 03:24:47 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE6401CB01A15@SHSMSX101.ccr.corp.intel.com>
References: <1440158014-29610-1-git-send-email-yu.c.chen@intel.com>
 <20150822203028.GA28112@amd> <20150823062033.GB18134@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150823062033.GB18134@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Pavel Machek <pavel@ucw.cz>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "Zhang, Rui" <rui.zhang@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Ingo, thanks for your reply,
 
> So I like the general structure of the patch and I like the MSR saving
> mechanism it introduces, but it is full of typos and small stylistic
> uncleanlinesses which need to be fixed before this patch can be applied.
> Please don't ack incomplete patches.
> 
Sorry for my poor English, I'll check these typos.

Best Regards,
Yu

> Thanks,
> 
> 	Ingo
