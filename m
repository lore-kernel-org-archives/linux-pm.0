From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH] [v4] PM / hibernate: Fix hibernation panic caused by
 inconsistent e820 map
Date: Thu, 17 Sep 2015 18:21:00 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE64026584C96@SHSMSX101.ccr.corp.intel.com>
References: <1442425343-8339-1-git-send-email-yu.c.chen@intel.com>
 <20150917060735.GF6665@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150917060735.GF6665@amd>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "jlee@suse.com" <jlee@suse.com>, "joeyli.kernel@gmail.com" <joeyli.kernel@gmail.com>, "yinghai@kernel.org" <yinghai@kernel.org>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi ,Pavel
> -----Original Message-----
> From: Pavel Machek [mailto:pavel@ucw.cz]
> Sent: Thursday, September 17, 2015 2:08 PM
> To: Chen, Yu C
> Cc: rjw@rjwysocki.net; Brown, Len; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org; Zhang, Rui; jlee@suse.com;
> joeyli.kernel@gmail.com; yinghai@kernel.org
> Subject: Re: [PATCH] [v4] PM / hibernate: Fix hibernation panic caused by
> inconsistent e820 map
> 
> >    With v3 patch applied, I did 30 cycles on my problematic platform,
> >    no panic triggered anymore(50% reproducible before patched, by
> >    plugging/unplugging memory peripheral during hibernation), and it
> >    just warns of invalid pages.
> 
> NAK. Turning panic into data corruption is a bad idea.
> 
Once an invalid page is found , the whole restoring process would be terminated
(before restoring the data pages)
I 'm not sure what does "data corruption" mean here?  
Thanks.

Best Regards,
Yu
