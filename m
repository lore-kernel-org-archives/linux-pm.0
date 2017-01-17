From: Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: Regression on Dell XPS13
Date: Tue, 17 Jan 2017 18:29:34 +0100
Message-ID: <b9610f92-d0d8-604b-2882-69c6d22dfcdc@leemhuis.info>
References: <20170110224956.GA2897@x61s.reliablesolutions.de>
 <5B8DA87D05A7694D9FA63FD143655C1B5437A09D@hasmsx108.ger.corp.intel.com>
 <aac5b255-e817-f92d-2f37-2ca7b52cd957@molgen.mpg.de>
 <5B8DA87D05A7694D9FA63FD143655C1B5437A315@hasmsx108.ger.corp.intel.com>
 <b1ecfd53-e856-ce10-d56e-4fea27095a8f@molgen.mpg.de>
 <20170113130018.GA896@kroah.com>
 <5549d8c0527412390d71236d80dff419@molgen.mpg.de>
 <20170114193959.GA30750@kroah.com>
 <5B8DA87D05A7694D9FA63FD143655C1B5437C2D3@hasmsx108.ger.corp.intel.com>
 <20170115105830.GD26374@kroah.com> <20170116110539.GA1307@kroah.com>
 <1b1feb50-2b22-b7e7-0fb8-2011340f5c47@leemhuis.info>
 <55b349b2-2999-94d5-9f68-b1944df1d374@molgen.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55b349b2-2999-94d5-9f68-b1944df1d374@molgen.mpg.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Menzel <pmenzel@molgen.mpg.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mario Limonciello <mario.limonciello@dell.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomas Winkler <tomas.winkler@intel.com>, Jan Niehusmann <jan@gondor.com>, "Usyskin, Alexander" <alexander.usyskin@intel.com>, linux-kernel@vger.kernel.org, "Chen, Yu C" <yu.c.chen@intel.com>, "Sarvela, Tomi P" <tomi.p.sarvela@intel.com>, Daniel Blueman <daniel@quora.org>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Lo! On 17.01.2017 15:34, Paul Menzel wrote:
> […]
>>> Paul, are you still having this issue?
>> Don't know about Paul, but I did a quick test with rc4 on my machine and
>> the issue is still there :-/
> I didn’t test Linux 4.10-rc4 yet, but I completed the bisection.
> 
> ```
> 406e79385f3223d82272cf2be86bc95cd000a258 is the first bad commit
> commit 406e79385f3223d82272cf2be86bc95cd000a258
> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Date:   Mon Nov 21 22:45:40 2016 +0100
> 
>      PM / sleep: System sleep state selection interface rework
> 

@Paul: Many thx for tracking this down. I didn't try to revert the
patch, but my XPS 13 (9360) enters and resumes properly from
suspend-to-ram after running "echo deep | sudo tee /sys/power/mem_sleep"
(#sigh, I should have thought of this myself earlier, as I had seen that
commit :-/ )

@Mario: many thx for the detailed mail you just send to explain things.
Looking forward to give supend-to-idle (which Windows uses on this
laptop) a try. If you need help with testing anything let me know, if I
can spare a minute I'll try to help.

Ciao, Thorsten
