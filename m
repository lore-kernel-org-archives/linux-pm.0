From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC PATCH 0/4] save and restore ACPI NVS memory
	during hibernation
Date: Fri, 11 Jul 2008 22:59:55 +0200
Message-ID: <200807112259.56263.rjw__77.2595908076212$1215810097$gmane$org@sisk.pl>
References: <1215051868.5628.32.camel@rzhang-dt.sh.intel.com>
	<200807112118.35562.rjw@sisk.pl> <20080711205253.GI6843@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080711205253.GI6843@elf.ucw.cz>
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
To: Pavel Machek <pavel@suse.cz>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday, 11 of July 2008, Pavel Machek wrote:
> On Fri 2008-07-11 21:18:34, Rafael J. Wysocki wrote:
> > On Friday, 11 of July 2008, Pavel Machek wrote:
> > > On Wed 2008-07-09 21:37:18, Rafael J. Wysocki wrote:
> > > > On Tuesday, 8 of July 2008, Pavel Machek wrote:
> > > > > Hi!
> > > > > 
> > > > > > According to the ACPI spec, ACPI NVS memory region is required to
> > > > > > be saved/restored by OS during hibernation.
> > > > > > 
> > > > > > Section 15.3.2 ACPI Spec 3.0b,
> > > > > > "OSPM will call the _PTS control method some time before entering
> > > > > > a sleeping state, to allow the platform???s AML code to update
> > > > > > this memory image before entering the sleeping state.
> > > > > > After the system awakes from an S4 state, OSPM will restore this
> > > > > > memory area and call the _WAK control method to enable the BIOS
> > > > > > to reclaim its memory image."
> > > > > > 
> > > > > > This patch set add the mechanism to save/restore ACPI NVS memory
> > > > > > during hibernation.
> > > > > > 
> > > > > > Patch 01: call platform_begin before swsusp_shrink_memory.
> > > > > > 	So that we can allocate enough pages for ACPI NVS memory
> > > > > > 	before shrink the memory.
> > > > > 
> > > > > Why is it neccessary to allocate memory for a copy? We should be able
> > > > > to save ACPI NVS area same way we are saving kernel pages, no?
> > > > 
> > > > Because we want to restore it from the hibernated kernel (when it gets control
> > > > back again).
> > > 
> > > Why is that important? So we can run some ACPI methods from hibernated
> > > kernel before restoring it?
> > 
> > We're supposed to restore it right prior to executing _WAK, which is after
> > we've executed _BFS.  This is a bit theoretical, because no one seems to
> > actaully implement _BFS, but well.
> 
> Could we just call _BFS from the "loading" kernel, instead? That would
> save us that copying code...

I'd prefer not to, because that would require the boot kernel to support ACPI,
which need not (and in fact should not IMO) be the case at present.

Anyway, we'd have to either copy the NVS data into memory which is mapped and
can be saved, or to map the NVS area in order to save/restore it, which I
wouldn't like to do.

Thanks,
Rafael
