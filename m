From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC] Deferred disk spinup during system resume
Date: Fri, 31 Dec 2010 12:27:32 +0100
Message-ID: <20101231112732.GG18831__48230.5904188708$1293795044$gmane$org@htj.dyndns.org>
References: <AANLkTinOqLOJ7JCpHeQNYUEirqAvkSce+eFDCGkWn3jE@mail.gmail.com>
	<201012302346.07275.rjw@sisk.pl>
	<AANLkTikLn7VyB+TJMz=GGTHKSHg+9feQ9bje+KS3pD3k@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikLn7VyB+TJMz=GGTHKSHg+9feQ9bje+KS3pD3k@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Maksim Rayskiy <maksim.rayskiy@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, linux-scsi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Dec 30, 2010 at 04:49:29PM -0800, Maksim Rayskiy wrote:
> >> When resuming from system suspend, scsi disks are being spun up which
> >> takes quite a lot of time (5+ seconds in my case). The spinup is done
> >> synchronously, so this time adds up to overall system resume time.
> >> Ours is an embedded platform and we are using flash-based rootfs, so
> >> there is no immediate need in harddrive after resume. What is much
> >> more important for us is to minimize time-to-full-power. To speed up
> >> resume, we would like to have an option to defer the spinup or run it
> >> in parallel with system resume. I could not find any existing
> >> mechanism to do the trick, but I might have missed something.
> >>
> >> Can anybody comment on this?
> >
> > Do you use asynchronous suspend/resume?
> >
> 
> Yes, asynchronous suspend/resume is enabled - it saves about 0.5
> second in my case. But resume blocks anyway because disk driver is
> waiting on sd_resume() to complete.
> 
> I am wondering if we could let the resume proceed while spinup is
> going on, just mark the scsi device as quiescent to block any data
> transfers.

Yeah, it was asynchronous for a while when suspend/resume were
implemented in libata proper.  It's a bit trickier to do that with sd
doing the higher level part.  Hmmm... most SATA disks spin up
automatically anyway so disabling START_STOP from sd should do the
trick.  Does the following achieve async resume?

 echo 0 > /sys/block/sdX/device/scsi_disk/h:c:i:l/manage_start_stop

The problem is that the above would also prevent the kernel from
issuing STANDBY_NOW on suspend or power down.  Maybe we should just
make start_stop_xlat schedule async EH action instead.

Thanks.

-- 
tejun
