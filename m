From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Wed, 13 May 2015 08:34:07 +1000
Message-ID: <20150512223407.GB4316@dastard>
References: <b1587e8b2c664632ecd0d9ad1a3e56733da76490.1431068823.git.len.brown@intel.com>
 <20150511014428.GB15721@dastard>
 <CAJvTdKk7tHoDC7N3=_7JB3KFSVrKyAhEEoS+RaM3bud=H4XXuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJvTdKk7tHoDC7N3=_7JB3KFSVrKyAhEEoS+RaM3bud=H4XXuw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Mon, May 11, 2015 at 04:22:26PM -0400, Len Brown wrote:
> On Sun, May 10, 2015 at 9:44 PM, Dave Chinner <david@fromorbit.com> wrote:
> 
> > ...Please explain what your use case is that makes this
> > so prohibitively expensive it needs to be removed.
> 
> wake on packet, process packet without turning on the display,
> immediately suspend.  Do this potentially several times per second.

The sync should almost always be a no-op because the filesystems
should be clean. In that case, where's the latency coming from?  If
filesystems were dirtied during the wake period, then we do care
that they get sync'd properly before suspend.

FWIW, I don't think that s2ram or s2d were designed for this
sort of abuse - they really were designed around laptop use cases,
which is what I mostly care about...

> >> The user-space utilities s2ram and s2disk choose to invoke sync() today.
> >> A user can invoke suspend directly via /sys/power/state to skip that cost.
> >
> > So, you want to have s2disk write all the dirty pages in memory to
> > the suspend image, rather than to the filesystem?
> 
> The s2disk utility is unchanged by this proposal, it already includes a sync().

Not everyone uses that utility.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
