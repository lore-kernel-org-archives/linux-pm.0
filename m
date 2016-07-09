From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] intel_pstate: Fix MSR_CONFIG_TDP_x addressing in core_get_max_pstate
Date: Sat, 09 Jul 2016 02:45:20 +0200
Message-ID: <1741569.1V1Ap4DoMu@vostro.rjw.lan>
References: <577FF3FC.6030004@siemens.com> <1468006747.13617.117.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1468006747.13617.117.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday, July 08, 2016 12:39:07 PM Srinivas Pandruvada wrote:
> On Fri, 2016-07-08 at 20:42 +0200, Jan Kiszka wrote:
> > If MSR_CONFIG_TDP_CONTROL is locked, we currently try to address some
> > MSR 0x80000648 or so. Mask out the relevant level bits 0 and 1.
> > 
> > Found while running over the Jailhouse hypervisor which became upset
> > about this strange MSR index.
> > 
> > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

OK

Should this go into stable?  Which series if so?

Thanks,
Rafael
