From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/9] PM: Fixes related to suspend and
 hibernation for 2.6.29
Date: Sat, 21 Feb 2009 14:18:23 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0902211417401.3111@localhost.localdomain>
References: <200902140157.40869.rjw@sisk.pl>
	<alpine.LFD.2.00.0902202337040.19156@localhost.localdomain>
	<200902211038.42169.rjw@sisk.pl> <20090221182902.GB12472@suse.de>
	<49A056D5.5090909@linux.intel.com> <20090221194807.GA13114@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090221194807.GA13114@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <gregkh@suse.de>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, Masami Hiramatsu <mhiramat@redhat.com>, Arjan van de Ven <arjan@linux.intel.com>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org



On Sat, 21 Feb 2009, Greg KH wrote:
> 
> Ok, so, Len, are you willing to send these to Linus this week?

I took them all, and added both of you to the cc, so if/when things break 
and get bisected to this series, both of you should be cc'd on the 
discussion.

		Linus
