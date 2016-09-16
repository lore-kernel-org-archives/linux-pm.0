From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [RFC/RFT][PATCH v3 0/5] Functional dependencies between devices
Date: Fri, 16 Sep 2016 09:25:45 +0200
Message-ID: <37bd85ce-95c9-4614-e1fa-2b189ff90d43@samsung.com>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan>
 <CGME20160915220215eucas1p2e246545de6ecaf16fe82a25ed7bc64b2@eucas1p2.samsung.com>
 <5257325.y9rG1UM74b@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:35056 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752045AbcIPHZx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Sep 2016 03:25:53 -0400
In-reply-to: <5257325.y9rG1UM74b@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Lukas Wunner <lukas@wunner.de>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>

Hi Rafael,


On 2016-09-16 00:03, Rafael J. Wysocki wrote:
> Hi Everyone,
>
> On Thursday, September 08, 2016 11:25:44 PM Rafael J. Wysocki wrote:
>> Hi Everyone,
>>
>> This is a refresh of the functional dependencies series that I posted last
>> year and which has picked up by Marek quite recently.  For reference, appended
>> is my introductory message sent previously (which may be slightly outdated now).
>>
>> As last time, the first patch rearranges the code around __device_release_driver()
>> a bit to prepare it for the next one (it actually hasn't changed AFAICS).
>>
>> The second patch introduces the actual device links mechanics, but without
>> system suspend/resume and runtime PM support which are added by the subsequent
>> patches.
>>
>> Some bugs found by Marek during his work on these patches should be fixed
>> here.  In particular, the endless recursion in device_reorder_to_tail()
>> which simply was broken before.
>>
>> There are two additional patches to address the issue with runtime PM support
>> that occured when runtime PM was disabled for some suppliers due to a PM
>> sleep transition in progress.  Those patches simply make runtime PM helpers
>> return 0 in that case which may be controversial, so please let me know if
>> there are concerns about those.
>>
>> The way device_link_add() works is a bit different, as it takes an additional
>> status argument now.  That makes it possible to create a link in any state,
>> with extra care of course, and should address the problem pointed to by Lukas
>> during the previous discussion.
>>
>> Also some comments from Tomeu have been addressed.
> An update here.
>
> The first patch hasn't changed, so I'm resending it.
>
> The majority of changes in the other patches are in order to address Lukas'
> comments.
>
> First off, I added a DEVICE_LINK_STATELESS flag that will prevent the driver
> core from trying to maintain device links having it set.
>
> Also, the DEVICE_LINK_PERSISTENT flag was dropped (as link "persistence" is the
> default behavior now) and there's a new one, DEVICE_LINK_AUTOREMOVE, that will
> cause the driver core to remove the link on the consumer driver unbind.
>
> Moreover, the code checks attempts to create a link between a parent and a child
> device now and actively prevents that from happening.
>
> The changelog of the second patch has been updated as requested by Ulf.
>
> The third patch was updated to fix a bug related to the (previously missing)
> clearing of power.direct_complete for supplier devices having consumers that
> don't use direct_complete.
>
> The next two (runtime PM) patches turned out to be unnecessary, so I've dropped
> them.
>
> The runtime PM patch [4/5] was reorganized somewhat to reduce the indentation
> level in there, but the code flow introduced by it is essentially the same
> and the last patch was simply rebased on top of the new series.
>
> If this version still works for Marek, I'll probably drop the RFC tag from it
> in the next iteration.

Sadly, this version doesn't work. I get following kernel bug:

[    2.357622] BUG: spinlock bad magic on CPU#0, swapper/0/1
[    2.362361]  lock: 0xeea2e294, .magic: ffffffff, .owner: /0, 
.owner_cpu: -1
[    2.369389] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 
4.8.0-rc6-00019-gd66d0028dd3c-dirty #651
[    2.377954] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[    2.384053] [<c010d7f0>] (unwind_backtrace) from [<c010a4b4>] 
(show_stack+0x10/0x14)
[    2.391766] [<c010a4b4>] (show_stack) from [<c032220c>] 
(dump_stack+0x74/0x94)
[    2.398970] [<c032220c>] (dump_stack) from [<c0158e8c>] 
(do_raw_spin_lock+0x160/0x1a8)
[    2.406870] [<c0158e8c>] (do_raw_spin_lock) from [<c03e8d84>] 
(device_links_no_driver+0x64/0x98)
[    2.415634] [<c03e8d84>] (device_links_no_driver) from [<c03ec32c>] 
(driver_probe_device+0xa0/0x2bc)
[    2.424744] [<c03ec32c>] (driver_probe_device) from [<c03ec5f4>] 
(__driver_attach+0xac/0xb0)
[    2.433165] [<c03ec5f4>] (__driver_attach) from [<c03eaa90>] 
(bus_for_each_dev+0x54/0x88)
[    2.441323] [<c03eaa90>] (bus_for_each_dev) from [<c03eba6c>] 
(bus_add_driver+0xe8/0x1f4)
[    2.449481] [<c03eba6c>] (bus_add_driver) from [<c03ece54>] 
(driver_register+0x78/0xf4)
[    2.457469] [<c03ece54>] (driver_register) from [<c010178c>] 
(do_one_initcall+0x3c/0x16c)
[    2.465632] [<c010178c>] (do_one_initcall) from [<c0b00d84>] 
(kernel_init_freeable+0x120/0x1ec)
[    2.474313] [<c0b00d84>] (kernel_init_freeable) from [<c0704194>] 
(kernel_init+0x8/0x118)
[    2.482470] [<c0704194>] (kernel_init) from [<c01079b8>] 
(ret_from_fork+0x14/0x3c)

I'm checking what's wrong there.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

