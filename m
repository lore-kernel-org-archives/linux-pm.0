From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: HDD not suspending properly / dead on resume
Date: Sat, 10 Jul 2010 02:06:13 +0200
Message-ID: <201007100206.13401.rjw@sisk.pl>
References: <201007091750.05020.stephan.diestelhorst@amd.com> <201007092353.25731.rjw@sisk.pl> <201007100104.38693.stephan.diestelhorst@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <201007100104.38693.stephan.diestelhorst@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
To: Stephan Diestelhorst <stephan.diestelhorst@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-pm@lists.osdl.org, Stephan Diestelhorst <stephan.diestelhorst@amd.com>
List-Id: linux-pm@vger.kernel.org

On Saturday, July 10, 2010, Stephan Diestelhorst wrote:
> Rafael J. Wysocki wrote:
> > On Friday, July 09, 2010, Stephan Diestelhorst wrote:
> > > I wrote:
> > > >   I have an issue with suspend to RAM and I/O load on a disk. Symptoms
> > > > are that the disk does not respond to requests when woken up, producing
> > > > only I/O errors on all tested kernels (newest 2.6.35-rc4 (Ubuntu
> > > > mainline PPA build)):
> > > > 
> > > <snip>
> > >  
> > > > This can be triggered most reliably with multiple "direct" writes to
> > > > disk, I create the load with the attached script. If the issue is
> > > > triggered, suspend (through pm-suspend) takes very long.
> > > 
> > > > IMHO the interesting log output during suspend is:
> > > > [ 1674.700125] ata1.00: qc timeout (cmd 0xec)
> > > 
> > > Almighty google suggested to try "pci=nomsi", which seems to have
> > > cured the issue for me for now. Is that plausible? I'll keep this
> > > under observation.
> > 
> > Hmm.  How does your /proc/interrupts look like?
> 
> This has been yet another red herring. After trying out the kernel
> option three times with two different kernels, it failed yet again
> with the same symptoms. 

I thought it would be like that.

> I have attached /proc/interrupts for 2.6.35-rc4, once with pci=nomsi
> and once without, but again, I do not think this makes a difference :-/
> 
> > Also, do you have a link to this "Google suggestion"?
> 
> It was some german forum, a guy with completely different HW, but the
> same symptom. I thought trying out the option wouldn't hurt.
> 
> Maybe it came for example from http://lkml.org/lkml/2008/12/20/3
> originally.

I have a box where this problem is kind of reproducible, but it happens _very_
rarely.  Also I can't reproduce it on demand running suspend-resume in a tight
loop.  Are you able to reproduce it more regurarly?

Also, what kind of disk do you use?

Rafael
