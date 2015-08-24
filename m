From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH] [v2] x86, suspend: Save/restore extra MSR registers for
 suspend
Date: Mon, 24 Aug 2015 03:28:07 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE6401CB01A35@SHSMSX101.ccr.corp.intel.com>
References: <1440158014-29610-1-git-send-email-yu.c.chen@intel.com>
 <20150822203028.GA28112@amd> <20150823062033.GB18134@gmail.com>
 <20150823084338.GA11065@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150823084338.GA11065@amd>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@kernel.org>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "Zhang, Rui" <rui.zhang@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi, Pavel,
> Plus, I acked V2 when V3 was available.
> 
V3 is to only save/restore THERM_CONTRO msr,  
so I think I'll do some check based on V2, It is more extensible.
Thanks,
Best Regards,
Yu
