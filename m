From: Mark Lord <lkml@rtr.ca>
Subject: Re: [BUG] Strange 1-second pauses during Resume-from-RAM
Date: Sun, 18 Nov 2007 12:37:14 -0500
Message-ID: <4740784A.7090405__29097.9013815106$1195407503$gmane$org@rtr.ca>
References: <32209efe0711122242m3a5f081asf1c11a38b24db10c@mail.gmail.com>
	<20071113031553.3c7b5c16.akpm@linux-foundation.org>
	<4739ADA2.4060604@rtr.ca>
	<alpine.LFD.0.9999.0711131521590.3265@localhost.localdomain>
	<4739E347.30406@rtr.ca> <473C7495.40805@rtr.ca>
	<47406400.5070804@rtr.ca> <20071118162126.GA29080@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071118162126.GA29080@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: len.brown@intel.com, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Mark Lord <liml@rtr.ca>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Ingo Molnar wrote:
> * Mark Lord <lkml@rtr.ca> wrote:
> 
>> Since Ingo's latency trace patches lock up the machine on resume, the 
>> next thing I'll try instead is to re-enable CONFIG_IRQBALANCE=y.
> 
> hm, which patch did you try? Could you check whether all chunks from the 
> patch below are applied? (these are the fixed i did when i was doing 
> cross-suspend traces - this is not something i've done before, so the 
> tracer had to be adjusted)
..

Hi Ingo!

I was using your 2.6.23.1 version of the patches, plus the fix you posted.

The new patch you gave just now is for 2.6.24, which won't apply to
the older kernel.  I'm not switching kernels yet, as doing so might mask
the problem without actually resolving it for good.

Cheers
