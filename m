From: Mark Lord <lkml@rtr.ca>
Subject: Re: [BUG] Strange 1-second pauses during Resume-from-RAM
Date: Fri, 30 Nov 2007 15:12:10 -0500
Message-ID: <47506E9A.7080500__29279.5928697617$1196453694$gmane$org@rtr.ca>
References: <32209efe0711122242m3a5f081asf1c11a38b24db10c@mail.gmail.com>
	<20071113031553.3c7b5c16.akpm@linux-foundation.org>
	<4739ADA2.4060604@rtr.ca>
	<alpine.LFD.0.9999.0711131521590.3265@localhost.localdomain>
	<4739E347.30406@rtr.ca> <473C7495.40805@rtr.ca>
	<20071115181418.GA6603@ucw.cz> <473C825E.3030307@rtr.ca>
	<20071115193424.GA31691@elte.hu> <20071115193612.GA751@elte.hu>
	<473CC6D4.2010909@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <473CC6D4.2010909@rtr.ca>
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
Cc: len.brown@intel.com, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Mark Lord wrote:
> Ingo Molnar wrote:
>> * Ingo Molnar <mingo@elte.hu> wrote:
>>
>>> pick up the latest latency tracer patch from:
>>
>> sorry, wrong URLs, the correct links are:
>>
>>    
>> http://redhat.com/~mingo/latency-tracing-patches/latency-tracer-v2.6.24-rc2-git5-combo.patch 
>>
>>    http://redhat.com/~mingo/latency-tracing-patches/trace-cmd.c
> ..
> 
> Is there a version of these that works with 2.6.23.1 ?
> 
> I'm not using 2.6.24-* on this machine because:
>  (a) behaviour may be different, and
>  (b) something broke VMware compatibility again.
..

An update:

Ingo's 2.6.23 version of the latency-tracing-patches only lock-up on resume here.

But now that I've hacked vmware to work on 2.6.24,
my notebook is now running the newer kernels.

So now to see if the "strange 1-second pauses" ever happen here,
and if they do I'll patch in Ingo's stuff to try and find out why.
