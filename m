From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: What to do?
Date: Mon, 07 Sep 2009 12:06:58 +0200
Message-ID: <4AA4DB42.1000800__6359.98769798807$1252318106$gmane$org@gmail.com>
References: <4A8CCF95.9030401@crca.org.au> <200908240004.16769.rjw@sisk.pl>
	<4A91CBB9.1080702@crca.org.au> <200908240120.30776.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908240120.30776.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <ncunningham@crca.org.au>, TuxOnIce-devel <tuxonice-devel@lists.tuxonice.net>, linux-pm <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi again.

On 08/24/2009 01:20 AM, Rafael J. Wysocki wrote:
> On Monday 24 August 2009, Nigel Cunningham wrote:
>> We should start by asking where you're at as far as knowledge of swsusp
>> and TuxOnIce goes. 

Well, I know swsups a bit and don't know about toi much. Still I think
it's not a problem at all. I learn quickly ;).

>> I know you've been around the TuxOnIce lists a bit,
>> but don't know how much you know about C programming or the inards of
>> the kernel, swsusp or TuxOnIce (ie how much help do you need to get up
>> to speed?).

I think C is no problem at all, so the kernel. The two I mentioned
above. I think I'll need no or low help from your side regarding the
code site. From what I've read already I would say it's well documented.

> Well, if you start from something that people don't like, it may be difficult
> to push the rest.
> 
> Still, I think Jiri is more than capable of handling that, so more or less
> everything that is a clear improvement and doesn't introduce regressions of any
> kind will probably work for me.

Thank you guys. I needed to cope with other things (a suspend
regression, writable /proc/<pid>/limits etc.) which took me a long time,
sorry.

Then I also went through the last "discussion" around the last merge try
mainly to see what others think about kernel-side implementation of
compression etc.

I hope I'll come up with something early.

Thanks.
