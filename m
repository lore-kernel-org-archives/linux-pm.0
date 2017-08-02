From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH 3/3] platform/wmi: Expose the raw WDG data in sysfs
Date: Tue, 1 Aug 2017 19:22:32 -0700
Message-ID: <20170802022232.GA21551@fury>
References: <cover.1501601667.git.luto@kernel.org>
 <e6df9d038af0a0ce4d4119395aaea58366ade26d.1501601667.git.luto@kernel.org>
 <20170801200313.GC3110@fury>
 <CALCETrX0zqq3xQgNBx41R9ZCT3_bB4EoXGrY3jWLK0e0Koo=EQ@mail.gmail.com>
 <20170801204040.GH25574@pali>
 <20170801211702.GF3110@fury>
 <20170801213112.GK25574@pali>
 <20170801223947.GH3110@fury>
 <CALCETrXFySnB3jq_EAn+NDTb6jsp__4Dc=0ipdFqCbaZEPSOfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:49403 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751571AbdHBCWg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Aug 2017 22:22:36 -0400
Content-Disposition: inline
In-Reply-To: <CALCETrXFySnB3jq_EAn+NDTb6jsp__4Dc=0ipdFqCbaZEPSOfg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, platform-driver-x86@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>

On Tue, Aug 01, 2017 at 04:51:40PM -0700, Andy Lutomirski wrote:
> On Tue, Aug 1, 2017 at 3:39 PM, Darren Hart <dvhart@infradead.org> wrote:
> > On Tue, Aug 01, 2017 at 11:31:12PM +0200, Pali Rohár wrote:
> >> On Tuesday 01 August 2017 14:17:02 Darren Hart wrote:
> > ...
> >> > My understanding of the BMOF data is that it provided us "with a description of
> >> > all data blocks, WMI methods, and events for the device" [1].
> >> >
> >> > If that's accurate, why do we need the _WDG? This just seems contrary to what
> >> > the BMOF data is supposed to be for.
> >>
> >> BMOF provides mapping from human class and method names to WMI GUID. WDG
> >> then provides mapping from WMI GUID to ACPI function names.
> >>
> >> Therefore if you upper layer in MOF world say that it want to call
> >> method M of class C and you want to know which ACPI function is called,
> >> you need to parse both BMOF and WDG to get mapping from MOF to ACPI.
> >> Same for WMI events.
> >>
> >> > > Ideally ability to create dump of BMOF and WDG on one computer and then
> >> > > parse those data on another.
> >> > >
> >> > > Having original BMOF and WDG structures is a good for debugging and
> >> > > development purpose.
> >
> > OK, I went and reviewed the MOF docs, our previous discussions, and your bmf2moc
> > code (awesome by the way). So, agreed - we need easy access to _WDG and BMOF for
> > development purposes.
> >
> > Having the kernel expose a guid/class/method interface should provide the
> > abstraction Rafael called for.
> >
> > The question then, is should these two things be in sysfs, where they become
> > more or less permanent, or are they better off in debugfs, where they can be
> > used by developers as needed, but are not present on production systems, and
> > we are not bound to the representation we use from now until forever.
> >
> > Seems to me:
> >
> > /debug/wmi/<GUID>/bmof
> 
> I can imagine a real production userspace app that parses BMOF data.
> Imagine you write a thingy that calls some laptop method foo(1) where
> foo is defined in the MOF.  You could hardcode the mapping to the
> GUID, but you could also parse the BMOF.
> 
> > /debug/wmi/<GUID>/_wdg
> 
> More like /debug/wmi/<bus name>/_wdg, but yes.  I wish there was a
> standard way to make a debugfs directory corresponding to a sysfs
> path.  Maybe this exists -- I'll look.
> 
> FWIW, almost all the _WDG data is already there in sysfs in Linus'
> tree.  See, for example, cat
> /sys/devices/platform/PNP0C14:01/wmi_bus/wmi_bus-PNP0C14:01/05901221-D566-11D1-B2F0-00A0C9062910/object_id

Yeah, true - I probably should have prodded on that more at the time.

In general, I'm much more comfortable presenting parsed and formatted data
through sysfs than I am dumping ACPI buffer objects out there wholesale.

So we have:
  guid
  instance_count
  expensive
  notify_id
  object_id
  setable

Hrm. Is there something more we need that isn't already present here?

Need to look more closely if all the values for the Flags are covered, but
otherwise we seem to have already parsed and presented all the relevant content
in the wdg.

Pali, how does the "magic number identifier" in the BMOF map to the object_id?
Have we retained that information in what we export today?

-- 
Darren Hart
VMware Open Source Technology Center
