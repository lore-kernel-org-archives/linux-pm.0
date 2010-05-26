From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/8] PM: Opportunistic suspend support.
Date: Wed, 26 May 2010 10:43:07 +0200
Message-ID: <1274863387.5882.4855.camel__7139.31376017189$1274863729$gmane$org@twins>
References: <Pine.LNX.4.44L0.1005251359580.1634-100000@iolanthe.rowland.org>
	<201005252147.22358.rjw@sisk.pl>
	<20100525195300.GA4455@core.coreip.homeip.net>
	<201005252221.55888.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005252221.55888.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-doc@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2010-05-25 at 22:21 +0200, Rafael J. Wysocki wrote:
> 
> Now, we can reject their patches, but that's not going to cause any progress
> to happen, realistically.  Quite on the contrary, Android will continue to use
> wakelocks and Android driver writers will continue to ignore the mainline
> and the gap between the two kernel lines will only get wider and wider over
> time.
> 
> And what really is the drawback if we merge the patches?  Quite frankly,
> I don't see any. 

A funny userspace API of questionable use (esp. with the advent of
better hardware and better runtime PM support) which we will have to
support forever seems like a big enough downside.
