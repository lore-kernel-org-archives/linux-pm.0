From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Wed, 5 May 2010 14:31:31 +0100
Message-ID: <20100505133131.GA24477__5005.77027346498$1273066402$gmane$org@srcf.ucam.org>
References: <20100504160346.GA27938@linux.intel.com>
	<Pine.LNX.4.44L0.1005041252480.1729-100000@iolanthe.rowland.org>
	<20100505015050.GA30591@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100505015050.GA30591@linux.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: mark gross <mgross@linux.intel.com>
Cc: Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org, markgross@thegnar.org, Kernel development list <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, May 04, 2010 at 06:50:50PM -0700, mark gross wrote:

> In my sequence above I had the modem driver "magically" knowing to fail
> this suspend attempt.  (that "magic" wasn't fully thought out though.)

If the modem driver knows to "magically" fail a suspend attempt until it 
knows that userspace has consumed the event, you have something that 
looks awfully like suspend blockers.

> There *has* to be a better way.

But nobody has reasonably proposed one and demonstrated that it works. 
We've had over a year to do so and failed, and I think it's pretty 
unreasonable to ask Google to attempt to rearchitect based on a 
hypothetical.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
