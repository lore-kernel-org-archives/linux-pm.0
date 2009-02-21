From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 0/9] PM: Fixes related to suspend and
	hibernation for	2.6.29
Date: Sat, 21 Feb 2009 11:48:07 -0800
Message-ID: <20090221194807.GA13114__28565.1342630901$1235245897$gmane$org@suse.de>
References: <200902140157.40869.rjw@sisk.pl>
	<alpine.LFD.2.00.0902202337040.19156@localhost.localdomain>
	<200902211038.42169.rjw@sisk.pl> <20090221182902.GB12472@suse.de>
	<49A056D5.5090909@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <49A056D5.5090909@linux.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, Masami Hiramatsu <mhiramat@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Sat, Feb 21, 2009 at 11:32:37AM -0800, Arjan van de Ven wrote:
> Greg KH wrote:
>> I was not planning to send them for .29, sorry I got confused.  I'll
>> drop them from my tree and Len can send them all to Linus now.
>
> they really really need to go into .29, they are a fix for a regression.
>
> This patch exists for 6 weeks now as a fix for the regression.. why is it 
> so hard to get it sent to Linus???

I think it's because both of us (Len and I) think the other is doing it
:(

Ok, so, Len, are you willing to send these to Linus this week?

thanks,

greg k-h
