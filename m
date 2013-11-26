From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 0/8] Cure faux idle wreckage
Date: Tue, 26 Nov 2013 15:23:32 -0800
Message-ID: <20131126152332.1b0dbbdb@ultegra>
References: <20131126155743.116756708@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131126155743.116756708@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>, lenb@kernel.org, rjw@rjwysocki.net, Eliezer Tamir <eliezer.tamir@linux.intel.com>, David Miller <davem@davemloft.net>, rui.zhang@intel.com, Mike Galbraith <bitbucket@online.de>, Ingo Molnar <mingo@kernel.org>, hpa@zytor.com, paulmck@linux.vnet.ibm.com, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 26 Nov 2013 16:57:43 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> Respin of the earlier series that tries to cure the 2 idle injection
> drivers and cleans up some of the preempt_enable_no_resched() mess.
> 
> The intel_powerclamp driver is tested by Jacob Pan and needs one more
> patch to cpuidle to work as before. I'll let him provide this patch;
> since he actually has it and tested it.
> 
> Jacob also said he'll try and work with the QoS people to sort out
> the conflict of interest between the idle injectors and the QoS
> framework.
[Jacob Pan] I have sent out a patch to hook up powerclamp with qos.
Please review. Ideally, this should be in one patchset to avoid
performance regression in powerclamp. If the qos hook is acceptable, it
can be easily used by ACPI PAD, I think.

Jacob
