From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: Hibernation considerations
Date: Fri, 20 Jul 2007 23:30:30 +0200
Message-ID: <200707202330.31644.rjw__38487.0795337067$1184966588$gmane$org@sisk.pl>
References: <Pine.LNX.4.64.0707171319140.2467@asgard.lang.hm>
	<f29402c6050f9c3ff5d83a59cea2de58@bga.com>
	<87myxroubm.fsf@jbms.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87myxroubm.fsf@jbms.ath.cx>
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
To: Jeremy Maitin-Shepard <jbms@cmu.edu>
Cc: David Lang <david@lang.hm>, LKML <linux-kernel@vger.kernel.org>, Milton Miller <miltonm@bga.com>, Ying Huang <ying.huang@intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday, 20 July 2007 19:31, Jeremy Maitin-Shepard wrote:
> Milton Miller <miltonm@bga.com> writes:
> 
> [snip]
> 
> >>>> (7) how to avoid corrupting filesystems mounted by the hibernated kernel
> >>> 
> >>> I didn't realize this was a discussion item. I thought the options were
> >>> clear, for some filesystem types you can mount them read-only, but for
> >>> ext3 (and possilby other less common ones) you just plain cannot touch
> >>> them.
> >> 
> >> That's correct.  And since you cannot thouch ext3, you need either to assume
> >> that you won't touch filesystems at all, or to have a code to recognize the
> >> filesystem you're dealing with.
> 
> > Or add a small bit of infrastructure that errors writes at make_request if you
> > don't have a magic "i am a direct block device write from userspace" flag on the
> > bio.
> 
> I still don't understand why there is this fixation on accessing dirty
> filesystems in use by the hibernated system.  Even if you avoid
> corrupting the filesystem by avoiding writing to the block device, there
> isn't any real guarantee about the state of the data, except for a
> filesystem that specifically makes guarantees about such data (and I
> don't believe any of the existing ones do).
> 
> It isn't necessary to be able to access such filesystems: everything can
> be done from an initramfs/initrd.

That's correct, but you need an additional ramdisk for that (yet another
complication).

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
