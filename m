From: Thomas Renninger <trenn@suse.de>
Subject: Re: PATCH [0/4] perf: clean-up of power events API
Date: Wed, 6 Oct 2010 23:34:45 +0200
Message-ID: <201010062334.46971.trenn__37207.6177889996$1286401002$gmane$org@suse.de>
References: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org, Frank Eigler <fche@redhat.com>, mathieu.desnoyers@efficios.com, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, arjan@linux.intel.com, mingo@elte.hu
List-Id: linux-pm@vger.kernel.org

Hi,

On Monday 04 October 2010 17:20:57 Jean Pihet wrote:
> Here is a re-spin of the patches after discussion.

what is going to happen here now?

Is this supposed to go through Ingo's tree?

Ingo: do you mind commenting on this.

I see 3 possibilities:
  1) Power (or all) perf events are never going to change.
  
  If they are going to change, then now is the right time and
  2) Backward compatibility is provided in some way for some time.

  3) The power events get cleaned up without compatibility to
     former kernels versions.

There are patches for 2. and 3., for 1. there obviously are no
needed.
For 2., the patches (mine or Jeans), need some polishing. IMO
these double events inside of general code aren't that bad.
I trust Jean, that it's not that easy with all the include magic
and macros, partly realized that myself already and it's not worth
it to dig further for a temporary solution.

Votes so far:
1. Arjan
2. Myself, Jean
3. Peter Zijlstra and Mathieu Desnoyers

Jean's work got successfully blocked for weeks now.
If there would be a final decision by a maintainer who is going to
merge Jean's work, that would be great and it would finally be worth
to send updated patches again which hopefully some day find their way into
a linux-next kernel...

Thanks,

      Thomas
