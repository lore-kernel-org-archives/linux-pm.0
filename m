From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: No freezing of kernel threads (was: Re: [GIT PULL] libata fixes for v3.13-rc5)
Date: Fri, 27 Dec 2013 00:23:10 +0100
Message-ID: <2054754.LytUAbbREV@vostro.rjw.lan>
References: <20131226160517.GB16483@htj.dyndns.org> <Pine.LNX.4.44L0.1312261326540.24521-100000@netrider.rowland.org> <20131226190120.GC16483@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <20131226190120.GC16483@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Linux-pm mailing list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, December 26, 2013 02:01:20 PM Tejun Heo wrote:
> Hey,
> 
> On Thu, Dec 26, 2013 at 01:42:29PM -0500, Alan Stern wrote:
> > In the case of hibernation, it's not so simple.  We do need to perform 
> > I/O, in order to save the memory image.  But we also need to avoid 
> > unnecessary I/O, in order to keep the on-disk data consistent with the 
> > data in the memory image.  You probably can't accomplish this at the 
> > device driver or subsystem level.
> 
> That was what I assumed too but Rafael tells me it has nothing to do
> with hibernation.

It doesn't prevent on-disk data corruption from happening in case of a failing
hibernation.  In case of a successful hibernation it is key to keep on-disk
data in sync with the contents of the image, but relying on the freezing
for that is rather not a winning strategy, so to speak.  It would be better
to freeze filesystems instead (which has been discussed in another thread
recently).

Thanks,
Rafael

