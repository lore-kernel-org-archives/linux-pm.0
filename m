From: David Chinner <dgc@sgi.com>
Subject: Re: 2.6.22-rc3 hibernate(?) fails totally - regression (xfs on raid6)
Date: Thu, 14 Jun 2007 10:28:23 +1000
Message-ID: <20070614002823.GY85884050@sgi.com>
References: <46667160.80905@gmail.com> <46668EE0.2030509@dgreaves.com> <46679D56.7040001@gmail.com> <4667DE2D.6050903@dgreaves.com> <20070607110708.GS86004887@sgi.com> <46680F5E.6070806@dgreaves.com> <20070607222813.GG85884050@sgi.com> <4669A965.20403@dgreaves.com> <alpine.LFD.0.98.0706121123550.14121@woody.linux-foundation.org> <466FD214.9070603@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756765AbXFNA3M@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <466FD214.9070603@dgreaves.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Greaves <david@dgreaves.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Chinner <dgc@sgi.com>, Tejun Heo <htejun@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, xfs@oss.sgi.com, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.osdl.org>, Neil Brown <neilb@suse.de>, Jeff Garzik <jgarzik@pobox.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 13, 2007 at 12:16:36PM +0100, David Greaves wrote:
> Linus Torvalds wrote:
> >
> >On Fri, 8 Jun 2007, David Greaves wrote:
> >>positive: I can now get sysrq-t :)
> >
> >Ok, so color me confused,
> So what do you think that makes me <grin>
> 
> >and maybe I have missed some of the emails or 
> >skimmed over them too fast (there's been too many of them ;),
> 
> You may have missed these 'tests' with rc4+Tejun's fix:
> * clean boot, unmounting the xfs fs : normal hibernate/resume
> * clean boot, remount ro xfs fs : normal hibernate/resume
> * clean boot, touch; sync; echo 1 > /proc/sys/vm/drop_caches: normal 
> hibernate/resume
> * clean boot, touch; sync; echo 2 > /proc/sys/vm/drop_caches: hang 
> hibernating
> * clean boot, touch; sync; echo 3 > /proc/sys/vm/drop_caches: hang 
> hibernating
> 
> Dave asked me to do them but hasn't responded yet.

Sorry 'bout that. Bit busy ATM.

What I was effectively looking for was whether it was data or metadata
that was causing the problems. From the above, it would appear that
dropping the page cache (echo 1 > drop caches) allows a successful
hibernate/resume. Next step would have been to isolate which cache
being dropped made the difference (e.g. a file or a bdev cache?).

However, it is clear from the back traces that there is something
unwell with md/sata code, so I don't think this needs to be tracked
any further from the filesystem perspective.

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
