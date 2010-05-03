From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH]PM QOS refresh against next-20100430
Date: Mon, 3 May 2010 10:33:00 -0600
Message-ID: <20100503103300.6330e522__6422.50187597728$1272904435$gmane$org@bike.lwn.net>
References: <20100430212043.GA30315@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100430212043.GA30315@linux.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: mgross@linux.intel.com
Cc: davidb@quicinc.com, dwalker@codeaurora.org, bruce.w.allan@intel.com, lkml <linux-kernel@vger.kernel.org>, tiwai@suse.de, mcgrof@gmail.com, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 30 Apr 2010 14:20:43 -0700
mark gross <mgross@linux.intel.com> wrote:

> This patch changes the string based list management to a handle base
> implementation to help with the hot path use of pm-qos

Having taken a quick look, I think the API change makes a lot of
sense.  Hot paths are one thing; avoidance of accidental conflicts
would be another.

One question, though...  one clear use of this API is for drivers to
say "don't go into C3 or deeper because things go wrong"; I'm about to
add another one of those.  It works, but the use of a
PM_QOS_CPU_DMA_LATENCY requirement with a hard-coded number that one
hopes is small enough seems a bit...indirect.  I wonder if it would be
clearer and more robust to add a new requirement^Wrequest type saying
"the quality of service I need is shallow sleeps only"?

jon
