From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] driver core: Ensure proper suspend/resume ordering
Date: Thu, 17 Sep 2015 20:15:49 +0200
Message-ID: <CAJZ5v0gEMhJaJa6m7Sq41oottuJW+0XJRpxsWHNdUsbVmNHeDw@mail.gmail.com>
References: <Pine.LNX.4.44L0.1509161503470.1993-100000@iolanthe.rowland.org>
	<1564644.fC4l842KYa@vostro.rjw.lan>
	<CAAObsKA8Ps_q4ZpsCVawKyrTCbySNC=1EQ=O=hdR7s_QiPdf-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAObsKA8Ps_q4ZpsCVawKyrTCbySNC=1EQ=O=hdR7s_QiPdf-w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alan Stern <stern@rowland.harvard.edu>, Thierry Reding <thierry.reding@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Grygorii Strashko <grygorii.strashko@ti.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Thu, Sep 17, 2015 at 7:40 AM, Tomeu Vizoso
<tomeu.vizoso@collabora.com> wrote:
> On 17 September 2015 at 02:27, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Wednesday, September 16, 2015 03:22:37 PM Alan Stern wrote:
>>>
>>> It would also help if your patch checked to see if the device has any
>>> children, and avoided moving it to the end of the list if it does.  In
>>> fact, that might be sufficient to avoid almost all problems.
>>
>> I agree.
>>
>> In any case if a device that already has children is about to be probed,
>> this is sort of a corner case anyway and should be handled as such.
>
> Just wanted to mention that it's very common in platforms that make
> use of DT to have some devices registered before their parents have probed.
> If I grep for DTS with simple-bus and simple-mfd I get 802 matches.


This is good to know, thanks!

Rafael
