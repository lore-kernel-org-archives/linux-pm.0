From: Daniel Walker <dwalker@fifo99.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 13 May 2010 14:33:29 -0700
Message-ID: <1273786409.19100.104.camel__27604.3746308007$1273786667$gmane$org@c-dwalke-linux.qualcomm.com>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<201005132311.26293.rjw@sisk.pl>
	<1273785399.19100.98.camel@c-dwalke-linux.qualcomm.com>
	<201005132327.16163.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005132327.16163.rjw@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Liam Girdwood <lrg@slimlogic.co.uk>, Matthew Garrett <mjg@redhat.com>, Oleg Nesterov <oleg@redhat.com>, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>, Theodore Ts'o <tytso@mit.edu>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Geoff Smith <geoffx.smith@intel.com>, Tejun Heo <tj@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 2010-05-13 at 23:27 +0200, Rafael J. Wysocki wrote:

> Because someone would have to remove suspend blockers (or rather wakelocks)
> from the drivers, test that they work correctly without suspend blockers and
> submit the modified versions.  Going forward, every party responsible for such
> a driver would have to maintain an out-of-tree version with suspend blockers
> (or wakelocks) anyway, so the incentive to do that is zero.

They should work without wakelock since wakelock are optional .. I mean
there's nothing in suspend blockers I've seen that indicates it's
required for some drivers to work. So it's just a matter of patching out
the wakelocks, with no need to re-test anything.

You get the driver mainlined, then maintain a small patch to add
wakelocks. Not hard at all , with lots of incentive to do so since you
don't have to maintain such a large block of code out of tree.

> Practically, as long as the opportunistic suspend is out of tree, there will be
> a _growing_ number of out-of-tree drivers out there, which is not acceptable
> in the long run.

I don't see why your saying that. These driver should work with out all
of this, which means they can get mainlined right now.

Daniel
