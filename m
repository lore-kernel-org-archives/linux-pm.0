From: Andy Lutomirski <luto@kernel.org>
Subject: Re: RFC: WMI Enhancements
Date: Fri, 5 May 2017 18:25:08 -0700
Message-ID: <CALCETrUgPgk7uVdYx4zJzXQHpk5zALmzSp3Zcz9+FPAe6bA5LQ@mail.gmail.com>
References: <20170412230854.GA11963@fury> <20170419075248.GD18887@pali>
 <f3684c95b91349d3b4e512370ac1faf4@ausx13mpc120.AMER.DELL.COM>
 <201704191854.51783@pali> <4e3e507b116443298427002c5aafed7f@ausx13mpc120.AMER.DELL.COM>
 <20170420131431.GM18887@pali> <20170420204436.GC3209@fury>
 <775ffd8f3327497cabd15ee7826cedaf@ausx13mpc120.AMER.DELL.COM>
 <20170505234436.GB25865@fury> <beb9a835eaf243fab151627e919eccf3@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <beb9a835eaf243fab151627e919eccf3@ausx13mpc120.AMER.DELL.COM>
Sender: linux-kernel-owner@vger.kernel.org
To: Mario.Limonciello@dell.com
Cc: Darren Hart <dvhart@infradead.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Corentin Chary <corentin.chary@gmail.com>, Andrew Lutomirski <luto@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, May 5, 2017 at 5:51 PM,  <Mario.Limonciello@dell.com> wrote:
>> -----Original Message-----
>> From: Darren Hart [mailto:dvhart@infradead.org]
>> Sent: Friday, May 5, 2017 6:45 PM
>> To: Limonciello, Mario <Mario_Limonciello@Dell.com>
>> Cc: pali.rohar@gmail.com; rjw@rjwysocki.net; luto@amacapital.net;
>> len.brown@intel.com; corentin.chary@gmail.com; luto@kernel.org;
>> andriy.shevchenko@linux.intel.com; linux-kernel@vger.kernel.org; platform-
>> driver-x86@vger.kernel.org; linux-pm@vger.kernel.org
>> Subject: Re: RFC: WMI Enhancements


> I meant that to say that at least for now Andy's wmi-mof driver should still be merged.
> If something is going to build on top of this to do WBEM tools, they'll need that MOF
> data once someone figures out how to nicely deconstruct it.
>

The thing I don't like about my own driver is that, as a WMI device
driver, it can be loaded before the rest of the bus finishes probing.
So user programs that are notified asynchronously that the wmi-mof
driver is loaded and try to use future functionality (ioctl to issue a
MOF-based method call?) might end up doing so before the rest of the
bus is probed.

This could be addressed by always exposing the wmi-mof device last
(sort of -- it can be a module) or perhaps by moving MOF functionality
to the core driver.  Or maybe it's not really a problem.

Also, isn't there a way to ask Microsoft to document this?  Are you
supposed to "ask a question" on this forum, perhaps:

https://msdn.microsoft.com/en-us/library/gg134029.aspx

I'm guessing the Samba team knows how to do this, too.
