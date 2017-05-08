From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: RFC: WMI Enhancements
Date: Mon, 8 May 2017 19:04:56 +0300
Message-ID: <CAHp75VdZrdBMGLcXoZhsjd14jbDaYMikThon6hC-s3fWsGb0ug@mail.gmail.com>
References: <201704191854.51783@pali> <4e3e507b116443298427002c5aafed7f@ausx13mpc120.AMER.DELL.COM>
 <20170420131431.GM18887@pali> <20170420204436.GC3209@fury>
 <775ffd8f3327497cabd15ee7826cedaf@ausx13mpc120.AMER.DELL.COM>
 <20170505234436.GB25865@fury> <beb9a835eaf243fab151627e919eccf3@ausx13mpc120.AMER.DELL.COM>
 <CALCETrUgPgk7uVdYx4zJzXQHpk5zALmzSp3Zcz9+FPAe6bA5LQ@mail.gmail.com>
 <20170508152907.GA17700@fury> <f8a3fa82d06142838ea39d8b1db7c25b@ausx13mpc120.AMER.DELL.COM>
 <20170508154725.GD17700@fury>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20170508154725.GD17700@fury>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, "Bokovoy, Alexander" <a.bokovoy@gmail.com>
Cc: Mario Limonciello <Mario.Limonciello@dell.com>, Andy Lutomirski <luto@kernel.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Corentin Chary <corentin.chary@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

+Cc: Alexander (related to Samba team I suppose, I'm sorry if I'm wrong)

On Mon, May 8, 2017 at 6:47 PM, Darren Hart <dvhart@infradead.org> wrote:
> On Mon, May 08, 2017 at 03:36:31PM +0000, Mario.Limonciello@dell.com wrote:

>> > > > I meant that to say that at least for now Andy's wmi-mof driver should still be
>> > merged.
>> > > > If something is going to build on top of this to do WBEM tools, they'll need that
>> > MOF
>> > > > data once someone figures out how to nicely deconstruct it.
>> > > >
>> > >
>> > > The thing I don't like about my own driver is that, as a WMI device
>> > > driver, it can be loaded before the rest of the bus finishes probing.
>> > > So user programs that are notified asynchronously that the wmi-mof
>> > > driver is loaded and try to use future functionality (ioctl to issue a
>> > > MOF-based method call?) might end up doing so before the rest of the
>> > > bus is probed.
>> > >
>> > > This could be addressed by always exposing the wmi-mof device last
>> > > (sort of -- it can be a module) or perhaps by moving MOF functionality
>> > > to the core driver.  Or maybe it's not really a problem.
>> >
>> > Thanks Andy, I'll keep that in mind and see if I can come up with something to
>> > address it while working on WMI this week.
>> >
>> > The other problem with wmi-mof is that there will be no immediate open source
>> > consumers of the interface, and none on the horizon. We can't even test it to
>> > any meaningful degree on Linux. I suspect this will be met with stiff
>> > resistance.
>>
>> Well FWIW I did a quick PoC check with the binary that I got out of it to make
>> sure it matched what was supposed to be.  I brought it over to a Win10 box and
>> decompiled using the mofcmp tool and those crazy arguments I mentioned and
>> it was correct.
>>
>> I'd argue that even if there is no open source tools available today, not making
>> the data available to userspace makes it difficult to even attempt to start
>> to reverse engineer.
>>
>> Kernel config with default of "N" perhaps for wmi-mof?
>
> All true. There is a precedent we're working against on this. I'll include it in
> my leveling-up thread today or tomorrow.
>
>> >
>> > >
>> > > Also, isn't there a way to ask Microsoft to document this?  Are you
>> > > supposed to "ask a question" on this forum, perhaps:
>> > >
>> > > https://msdn.microsoft.com/en-us/library/gg134029.aspx
>> > >
>> > > I'm guessing the Samba team knows how to do this, too.
>> > >
>>
>> Microsoft treats this as an "intermediary" format.  I'm not convinced
>> that anyone other than MS knows anything about it today.

Alexander, perhaps you would know someone who may help here?

>>
>> I agree asking them to document it is probably the right way to go.
>>
>
> Mario, you are most likely in a better position to do that than I am. Would you
> take that on?


-- 
With Best Regards,
Andy Shevchenko
