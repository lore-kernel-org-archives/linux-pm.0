From: Jeremy Maitin-Shepard <jbms@cmu.edu>
Subject: Re: Hibernating To Swap Considered Harmful
Date: Fri, 13 Jul 2007 10:35:22 -0400
Message-ID: <87odig1idx.fsf__19819.1425799907$1184337374$gmane$org@jbms.ath.cx>
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<200707121453.49616.rjw@sisk.pl>
	<Pine.LNX.4.64.0707121150460.25614@asgard.lang.hm>
	<200707122134.29991.rjw@sisk.pl>
	<Pine.LNX.4.64.0707121953440.25614@asgard.lang.hm>
	<20070713054244.GA20082@nineveh.local>
	<Pine.LNX.4.64.0707122250170.25614@asgard.lang.hm>
	<20070713062039.GA29055@nineveh.local>
	<Pine.LNX.4.64.0707122319270.25614@asgard.lang.hm>
	<20070713071512.GB29055@nineveh.local>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070713071512.GB29055@nineveh.local> (Joseph Fannin's message
	of "Fri\, 13 Jul 2007 03\:15\:12 -0400")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david@lang.hm
Cc: linux-kernel@vger.kernel.org, Joseph Fannin <jfannin@gmail.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

jfannin@gmail.com (Joseph Fannin) writes:

[snip]

> Intel Macs use GPT partition tables, which support a huge number
> of primary partitions, and so don't support secondary partitions.

> 32bit Windows does not support GPT, so PC-style MBR partition tables
> must also be used.  GPT was designed to coexist with MBR tools, so
> this mostly works, but you're limited to the union of supported
> features -- 4 primary partitions, no secondaries.

There is a very simple solution to this obscure problem: (if I
understand correctly, you want to dual boot Mac OS X and Linux (and
maybe also Windows?))

use LVM, thus allowing you to have as many volumes as you like in the
partition

-- 
Jeremy Maitin-Shepard
