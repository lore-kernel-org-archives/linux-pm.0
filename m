From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Suspend problems in 2.6.31-rc6
Date: Mon, 24 Aug 2009 20:59:45 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908242058050.17556-100000@netrider.rowland.org>
References: <20090824023423.GC4624@zhen-devel.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090824023423.GC4624@zhen-devel.sh.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Greg KH <greg@kroah.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Alek Du <alek.du@intel.com>, Dave Airlie <airlied@redhat.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Mon, 24 Aug 2009, Zhenyu Wang wrote:

> yeah, Alex's patch is ok in general, and Alan's problem seems specific on 845G.
> So the origin restore order issue for us seems gone with pci layer early resume,
> we could remove the restore in intel_agp and drm/i915, although Alex's patch makes
> them noop.
> 
> How about this one? Alan, could you help to test this with drm/i915 module loaded?

I can't test it right now.  I'll do it later in the week.

Alan Stern
