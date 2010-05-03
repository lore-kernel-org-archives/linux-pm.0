From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH]PM QOS refresh against next-20100430
Date: Mon, 03 May 2010 09:40:11 -0700
Message-ID: <87y6g1547o.fsf__20179.914791561$1272904868$gmane$org@deeprootsystems.com>
References: <20100430212043.GA30315@linux.intel.com>
	<20100503103300.6330e522@bike.lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100503103300.6330e522@bike.lwn.net> (Jonathan Corbet's message
	of "Mon\, 3 May 2010 10\:33\:00 -0600")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: davidb@quicinc.com, dwalker@codeaurora.org, tiwai@suse.de, bruce.w.allan@intel.com, lkml <linux-kernel@vger.kernel.org>, mcgrof@gmail.com, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Jonathan Corbet <corbet@lwn.net> writes:

> On Fri, 30 Apr 2010 14:20:43 -0700
> mark gross <mgross@linux.intel.com> wrote:
>
>> This patch changes the string based list management to a handle base
>> implementation to help with the hot path use of pm-qos
>
> Having taken a quick look, I think the API change makes a lot of
> sense.  Hot paths are one thing; avoidance of accidental conflicts
> would be another.
>
> One question, though...  one clear use of this API is for drivers to
> say "don't go into C3 or deeper because things go wrong"; I'm about to
> add another one of those.  It works, but the use of a
> PM_QOS_CPU_DMA_LATENCY requirement with a hard-coded number that one
> hopes is small enough seems a bit...indirect.  I wonder if it would be
> clearer and more robust to add a new requirement^Wrequest type saying
> "the quality of service I need is shallow sleeps only"?

The problem with that is portability.

What does "shallow" mean?  

Even between different SoCs in the same family, shallow might have
different meaning, but across architectures, this certainly would not
be portable.

Kevin
