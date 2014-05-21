From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 3/7] driver/core: cpu: initialize opp table
Date: Wed, 21 May 2014 20:29:18 +0530
Message-ID: <CAKohpo=tQeCkc9AzyCPbuDnkB-+YgStechwaCg6R0-zEVgF3Rg@mail.gmail.com>
References: <cover.1400670427.git.viresh.kumar@linaro.org>
	<b59df199b373191791afcccd627d900ce07afa71.1400670427.git.viresh.kumar@linaro.org>
	<537CADFB.1090305@arm.com>
	<CAKohpo=-kmfH9Z+m8E9HQXs4AvRoUCDzcrns6-HHLH=AqeJ-DQ@mail.gmail.com>
	<537CBB4C.7000006@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <537CBB4C.7000006@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arvind Chauhan <Arvind.Chauhan@arm.com>, "inderpal.s@samsung.com" <inderpal.s@samsung.com>, "nm@ti.com" <nm@ti.com>, "chander.kashyap@linaro.org" <chander.kashyap@linaro.org>, "pavel@ucw.cz" <pavel@ucw.cz>, "len.brown@intel.com" <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 21 May 2014 20:12, Sudeep Holla <sudeep.holla@arm.com> wrote:
> Hmm agreed, but there are SoCs that support per CPU DVFS ;)

Lets see what's Nishanth/Rafael's view on this. I am more or less in
favor of it. But isn't a big thing. Can convert it to dbg if it annoys you :)

>> Probably we will call of_init_opp_table() directly for other devices, as
>> this
>> function doesn't do anything else, apart from some prints.. So, probably
>> leave is as is for now, unless a real need arises ?

> I don't see anything cpu specific there, but that's just my opinion.

I never said that it has anything cpu specific.. What I said was that this
routine wouldn't have existed if Rafael wouldn't have asked for it. It is
just a wrapper over of_init_opp_table, which also has a dummy
implementation when its not supported.

So, it might not be worth enough for any other code to use it. :)
But in case it is, we can add it later.
