From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [PATCH 0/2] Kexec jump: The first step to kexec
	base hibernation
Date: Fri, 13 Jul 2007 10:37:38 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707131035150.4865-100000__5403.03511447764$1184337503$gmane$org@iolanthe.rowland.org>
References: <200707131359.53309.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707131359.53309.rjw@sisk.pl>
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
Cc: david@lang.hm, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Fri, 13 Jul 2007, Rafael J. Wysocki wrote:

> > I missed this discussion. is this idea to suspend, write to disk, but 
> > leave things in ram so that if you wakeup soon enough you have everything 
> > for ram, but if you don't and the battery dies you can restore from disk?
> > 
> > if so I think it's a mistake to mix the two. it would be better to just 
> > suspend to ram, and wake up once in a while to check the battery state and 
> > when the battery gets low enough do the suspend to disk.
> > 
> > otherwise you end up mixing the requirements of the two types of suspend, 
> > which is how things got so ugly in the first place.
> 
> Not necessarily.  If we don't put devices into low power states before creating
> the image, that should work just fine (quiesce devices, create the image or
> kexec the new kernel, reprobe devices, save the image, suspend to RAM,
> resume from RAM, continue - or restore from the image if power failed in the
> meantime).  Still, for this purpose, both kernels need to be able to handle the
> same set of devices.

Why?

Suppose the kexec kernel can't handle some device.  The normal kernel 
has already quiesced the device, so it will remain quiescent while the 
kexec kernel runs and throughout the suspend.  When the regular kernel 
regains control the device will be ready for use.  I don't see any 
problem.

Alan Stern
