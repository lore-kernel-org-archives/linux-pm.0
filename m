From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Wed, 5 May 2010 21:21:07 +0100
Message-ID: <20100505202107.GA6655__2973.26877848736$1273094723$gmane$org@srcf.ucam.org>
References: <20100504160346.GA27938@linux.intel.com>
	<Pine.LNX.4.44L0.1005041252480.1729-100000@iolanthe.rowland.org>
	<20100505015050.GA30591@linux.intel.com>
	<20100505133131.GA24477@srcf.ucam.org>
	<20100505200906.GA7450@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100505200906.GA7450@linux.intel.com>
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

On Wed, May 05, 2010 at 01:09:06PM -0700, mark gross wrote:
> On Wed, May 05, 2010 at 02:31:31PM +0100, Matthew Garrett wrote:
> > But nobody has reasonably proposed one and demonstrated that it works. 
> > We've had over a year to do so and failed, and I think it's pretty 
> > unreasonable to ask Google to attempt to rearchitect based on a 
> > hypothetical.
> >
> 
> These are not new issues being raised. They've had over a year to
> address them, and all thats really happened was some sed script changes
> from wake_lock to suspend_blocker.  Nothing is really different
> here.

Our issues haven't been addressed because we've given no indication as 
to how they can be addressed. For better or worse, our runtime 
powermanagement story isn't sufficient to satisfy Google's usecases. 
That would be fine, if we could tell them what changes needed to be made 
to satisfy their usecases. The Android people have said that they don't 
see a cleaner way of doing this. Are we seriously saying that they 
should prove themselves wrong, and if they can't they don't get their 
code in the kernel? This seems... problematic.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
