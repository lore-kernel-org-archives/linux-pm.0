From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] thermal: rcar_thermal: use pm_runtime_put_sync()
Date: Fri, 13 Nov 2015 16:06:17 +0100
Message-ID: <CAPDyKFrB5uK5U9DH3tc_ZDPhJT4eyhhaZ1+WhjvFprHauKWkSw@mail.gmail.com>
References: <87h9kulkfg.wl%kuninori.morimoto.gx@renesas.com>
	<2060819.A5Wq9BbBOH@vostro.rjw.lan>
	<CAPDyKFpzHjHfJjxupaSDabmSQzCD8M9enAFQDe0NnMn6-9g0pg@mail.gmail.com>
	<1611120.Ji2Kgxk0bH@vostro.rjw.lan>
	<CAPDyKFqK0qSVvY7UJM5VYmjfMkEwWw9JG74t_uMcem09g+uHAw@mail.gmail.com>
	<20151112184325.GB5289@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151112184325.GB5289@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Zhang Rui <rui.zhang@intel.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Cao Minh Hiep <cm-hiep@jinso.co.jp>, =?UTF-8?B?RHVuZ++8muS6uuOCvQ==?= <nv-dung@jinso.co.jp>, Alan Stern <stern@rowland.harvard.edu>
List-Id: linux-pm@vger.kernel.org

On 12 November 2015 at 19:43, Eduardo Valentin <edubezval@gmail.com> wrote:
> Hello,
>
> On Thu, Nov 12, 2015 at 09:04:09AM +0100, Ulf Hansson wrote:
>> >
>> > OK
>> >
>> > If we did that, all devices that had just been unbound from their drivers
>> > and had runtime PM disabled after that would be set to "suspended" by the
>> > core, right?
>>
>> Yes, that's the idea. I will send a patch we can test.
>>
>> >
>> > If that helps, I don't really have objections.
>
> Given this discussion,
>
> Is this series of two patches on this thermal driver still applicable?

I think patch1 is different, it's a cleanup patch (I just replied to
it separately).

As for subject patch, I think we agreed upon that it's a workaround
but I don't have strong opinion if you want to pick it up anyway.

On the other hand the change won't be needed *if* we solve problem via
driver core. I intend to send a patch for this on Monday, keep you on
cc.

Kind regards
Uffe
