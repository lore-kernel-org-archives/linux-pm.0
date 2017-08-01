From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 3/3] platform/wmi: Expose the raw WDG data in sysfs
Date: Tue, 1 Aug 2017 23:31:12 +0200
Message-ID: <20170801213112.GK25574@pali>
References: <cover.1501601667.git.luto@kernel.org>
 <e6df9d038af0a0ce4d4119395aaea58366ade26d.1501601667.git.luto@kernel.org>
 <20170801200313.GC3110@fury>
 <CALCETrX0zqq3xQgNBx41R9ZCT3_bB4EoXGrY3jWLK0e0Koo=EQ@mail.gmail.com>
 <20170801204040.GH25574@pali>
 <20170801211702.GF3110@fury>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170801211702.GF3110@fury>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On Tuesday 01 August 2017 14:17:02 Darren Hart wrote:
> On Tue, Aug 01, 2017 at 10:40:40PM +0200, Pali Rohár wrote:
> > On Tuesday 01 August 2017 13:19:16 Andy Lutomirski wrote:
> > > On Tue, Aug 1, 2017 at 1:03 PM, Darren Hart <dvhart@infradead.org> wrote:
> > > > On Tue, Aug 01, 2017 at 08:37:28AM -0700, Andy Lutomirski wrote:
> > > >> This adds a sysfs binary attribute 'wdg' on the bus device
> > > >> (i.e. /sys/class/wmi_bus/wmi_bus-*/wdg) that contains the raw _WDG
> > > >> data from ACPI.  This can be used along with the wmi-bmof driver to
> > > >> decode the raw interface data from ACPI.
> > > >
> > > > I don't recall seeing mention of this is the documentation I read as a
> > > > requirement to decoding the interface with the bmof. Do Windows systems export
> > > > _WDG to userspace?
> > > >
> > > > Why do we need to export _WDG?
> > > 
> > > This was a feature that Pali asked for.  Pali, since you seem to be
> > > working on userspace tooling, can you explain exactly what you'd use
> > > it for?
> > 
> > Take raw BMOF and WDG buffers from ACPI and parse them in userspace.
> > Then provide needed information like mapping from MOF event name to ACPI
> > event name based on info from WDG buffer.
> > 
> 
> So first, I'm not opposed to adding it if that's what needed. However, I don't
> want to start pushing ACPI objects to sysfs without:
> 
> 1) Confirming it's necessary
> 2) Getting Rafael's take on this practice, as if this is to become something we
> do, some kind of ACPI_OBJECT_SYSFS_EXPORT macro provided by ACPI would probably
> be the right way to do it.
> 
> My understanding of the BMOF data is that it provided us "with a description of
> all data blocks, WMI methods, and events for the device" [1].
> 
> If that's accurate, why do we need the _WDG? This just seems contrary to what
> the BMOF data is supposed to be for.

BMOF provides mapping from human class and method names to WMI GUID. WDG
then provides mapping from WMI GUID to ACPI function names.

Therefore if you upper layer in MOF world say that it want to call
method M of class C and you want to know which ACPI function is called,
you need to parse both BMOF and WDG to get mapping from MOF to ACPI.
Same for WMI events.

> > Ideally ability to create dump of BMOF and WDG on one computer and then
> > parse those data on another.
> > 
> > Having original BMOF and WDG structures is a good for debugging and
> > development purpose.
> 
> For debugging purposes, the fwts and acpidump tools will provide this.
> 
> > > On my laptop, at the very least, it would allow user code to determine
> > > that there's a WMI GUID that doesn't show up in sysfs.  It doesn't
> > > show up in sysfs because the ACPI methods are completely missing, but
> > > it's still there in WDG.  This prints a warning when wmi.ko is loaded,
> > > but maybe the userspace tooling would care, for debugging if nothing
> > > else.
> 
> In this case, I'd argue userspace should only be aware of what the kernel
> decides to expose, based on, at the very least, compliance with the WMI
> documentation.
> 
> 1. https://wiki.ubuntu.com/Kernel/Reference/WMI

When you want to write a new WMI kernel driver you definitely need to
see parsed WDG buffer.

When you take ACPI dump and then decompile it (via iasl -d) as written
in #1 you can then find particular WDG and BMOF buffers in that
decompiled ASL file. But parsing such source file correctly is not easy
and I do not know automated tool for it. Also #1 say to look at file and
find some pattern...

-- 
Pali Rohár
pali.rohar@gmail.com
