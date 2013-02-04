From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH V4] suspend: enable freeze timeout configuration through sys
Date: Mon, 04 Feb 2013 13:22:42 +0100
Message-ID: <2394748.6YpH0CJTqu@vostro.rjw.lan>
References: <BEC9F67575FA1E429CA7CF5AE9BE36343F154E@SHSMSX102.ccr.corp.intel.com> <Pine.LNX.4.44L0.1302032213410.28934-100000@netrider.rowland.org> <27240C0AC20F114CBF8149A2696CBE4A222AEB@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <27240C0AC20F114CBF8149A2696CBE4A222AEB@SHSMSX101.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Liu, Chuansheng" <chuansheng.liu@intel.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Li, Fei" <fei.li@intel.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, February 04, 2013 04:32:11 AM Liu, Chuansheng wrote:
> 
> > -----Original Message-----
> > From: Alan Stern [mailto:stern@rowland.harvard.edu]
> > Sent: Monday, February 04, 2013 11:16 AM
> > To: Li, Fei
> > Cc: Rafael J. Wysocki; akpm@linux-foundation.org;
> > linux-kernel@vger.kernel.org; linux-pm@vger.kernel.org; Liu, Chuansheng
> > Subject: RE: [PATCH V4] suspend: enable freeze timeout configuration through
> > sys
> > 
> > On Mon, 4 Feb 2013, Li, Fei wrote:
> > 
> > > > -> the situation described above shouldn't happen and if it does, then there
> > > > is a bug that needs to be fixed.
> > >
> > > Yes, we agree with that it's a bug that needs to be fixed, and we are already
> > done
> > > for some cases.
> > > During the process, we realize that tuning the timeout value to smaller value
> > will help
> > > to expose freezing failure for some cases.
> > 
> > Besides, the underlying bug is well known (fuse filesystems hanging
> > because the fuse daemon gets frozen before the process doing file I/O,
> > or something like that) and so far nobody has a good idea of how to
> > fix it.
> Indeed, we have some well-known deadlock issues existed there.
> And once there is deadlock case, this patch is helpful to the user experience,
> because 20s is pointless for those deadlock case.
> 
> Also even adjusting the 20s to 2s, we still can get to know the process stack who rejecting the freezing,
> so this freezing configuration is really helpful to avoid 20s waiting for that deadlock case.
> Alan and Rafael, could you consider this patch? Thanks.

OK, I'll take it.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
