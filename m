From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: RFC: WMI Enhancements
Date: Tue, 18 Apr 2017 10:36:59 +0300
Message-ID: <1492501019.24567.45.camel@linux.intel.com>
References: <20170412230854.GA11963@fury>
         <20170413073228.GB1462@ozzy.nask.waw.pl>
         <3370431810bd4bc09fd9eb16eb9abea5@ausx13mpc120.AMER.DELL.COM>
         <20170413135102.GL3090@pali>
         <faffff39232f4734859a360cb666856f@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <faffff39232f4734859a360cb666856f@ausx13mpc120.AMER.DELL.COM>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Mario.Limonciello@dell.com, pali.rohar@gmail.com, hdegoede@redhat.com
Cc: kernel@kempniu.pl, dvhart@infradead.org, rjw@rjwysocki.net, len.brown@intel.com, corentin.chary@gmail.com, luto@kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, 2017-04-13 at 15:40 +0000, Mario.Limonciello@dell.com wrote:
> > libsmbios would benefit.
> > 
> > Really libsmbios matters here? Hans (added to thread) wrote that
> > libsmbios is
> > a relic, something of ages long gone by and a normal user should
> > never use it.
> > 	
> 
> A normal user shouldn't be using it directly, but libsmbios is used by
> a few open 
> source tools as a dependency.  It's also used in many Dell
> manageability tools.
> 

Shouldn't tools evolve to use newer interfaces (while keeping
compatibility with old kernels)?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
