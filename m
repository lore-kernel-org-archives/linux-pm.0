From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Tue, 4 May 2010 22:37:56 +0200
Message-ID: <201005042237.56844.rjw__5513.00202864713$1273005550$gmane$org@sisk.pl>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<87r5lrh780.fsf@deeprootsystems.com>
	<20100504190656.GA4611@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100504190656.GA4611@opensource.wolfsonmicro.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Paul Walmsley <paul@pwsan.com>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, Arve@smtp1.linux-foundation.org, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 04 May 2010, Mark Brown wrote:
> On Tue, May 04, 2010 at 11:06:39AM -0700, Kevin Hilman wrote:
> 
> > With opportunistic suspend, all of this flexibility is gone, and the
> > device/subsystem is told to go into the lowest power, highest latency
> > state, period.
> 
> Well, half the problem I have is that unfortunately it's not a case of
> doing that period.  The prime example I'm familiar with is that for
> understandable reasons users become irate when you power down the audio
> CODEC while they're in the middle of a call so if opportunistic PM is in
> use then the audio subsystem needs some additional help interpreting a
> suspend request so that it can figure out how to handle it.  Similar
> issues apply to PMICs, though less pressingly for various reasons.
> 
> Just to be clear, I do understand and mostly agree with the idea that
> opportunistic suspend presents a reasonable workaround for our current
> inability to deliver good power savings with runtime PM methods on many
> important platforms but I do think that if we're going to make this
> standard Linux PM functionality then we need to be clearer about how
> everything is intended to hang together.

At the moment the rule of thumb is: if you don't need the opportunistic
suspend, don't use it.  It is not going to be enabled by default on anything
other than Android right now.

However, since Android is a legitimate user of the Linux kernel, I see no
reason to reject this feature right away.  There are many kernel features
that aren't used by all platforms.

Rafael
