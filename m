From: Mark Lord <lkml@rtr.ca>
Subject: Re: [BUG] Strange 1-second pauses during Resume-from-RAM
Date: Fri, 16 Nov 2007 13:35:28 -0500
Message-ID: <473DE2F0.2060808@rtr.ca>
References: <32209efe0711122242m3a5f081asf1c11a38b24db10c@mail.gmail.com>
	<20071113031553.3c7b5c16.akpm@linux-foundation.org>
	<4739ADA2.4060604@rtr.ca>
	<alpine.LFD.0.9999.0711131521590.3265@localhost.localdomain>
	<4739E347.30406@rtr.ca> <473C7495.40805@rtr.ca>
	<20071115181418.GA6603@ucw.cz> <473C825E.3030307@rtr.ca>
	<20071115193424.GA31691@elte.hu> <20071115193612.GA751@elte.hu>
	<473CC6D4.2010909@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org, Mark Lord <liml@rtr.ca>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Mark Lord wrote:
> Ingo Molnar wrote:
>> * Ingo Molnar <mingo@elte.hu> wrote:
>>
>>> pick up the latest latency tracer patch from:
>>
>> sorry, wrong URLs, the correct links are:
>>
>>   =20
>> http://redhat.com/~mingo/latency-tracing-patches/latency-tracer-v2.6.2=
4-rc2-git5-combo.patch=20
>>
>>    http://redhat.com/~mingo/latency-tracing-patches/trace-cmd.c
..

make trace-cmd
cc -Wall -O2 -s    trace-cmd.c   -o trace-cmd
trace-cmd.c: In function =91main=92:
trace-cmd.c:65: warning: label =91usage=92 defined but not used
