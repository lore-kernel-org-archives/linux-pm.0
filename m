From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM/ runtime: fix resume from suspend on newer hp zbook/elitebook
Date: Fri, 18 May 2018 12:26:39 +0200
Message-ID: <CAJZ5v0jmqez5MJYRJr7SE6UseAf=eaduhv54BaGgyeC8PdoCgw@mail.gmail.com>
References: <20180515133508.2913-1-kugel@rockbox.org> <CAJZ5v0ipJgkwmv6n5b8Z+=V0k_7d+iXdLycsF9Tsq01MWy_Jqg@mail.gmail.com>
 <061fae0d-f358-ef6a-9c4a-a40a33d8b900@rockbox.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <061fae0d-f358-ef6a-9c4a-a40a33d8b900@rockbox.org>
Sender: stable-owner@vger.kernel.org
To: Thomas Martitz <kugel@rockbox.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Stable <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, May 15, 2018 at 9:39 PM, Thomas Martitz <kugel@rockbox.org> wrote:
> Am 15.05.2018 um 17:10 schrieb Rafael J. Wysocki:
>
>> Before applying anything like this I need to understand the failure in
>> the first place.
>>
>> Since direct_complete is optional anyway and it should be safe to call
>> pm_runtime_suspended() at any time, I'm suspecting a bug in a driver
>> that is exposed by the commit turned up by bisection.
>>
>> Where's the code I need to look at?
>>
>
> Hello,
>
> thanks for looking into this. To answer the question I need your expertise.
> I couldn't find out which device causes it. Since the freeze only happens of
> amdgpu is loaded I naturally thought the problematic device(s) would be
> bound to amdgpu. So I assumed the amdgpu-bound devices would be affected by
> your change, i.e. not have direct_complete set anymore. But I could not
> confirm this evidence during testing (I basically restricted my patch to
> devices which pass !strcmp(dev->driver->name, "amdgpu", and the system was
> still frozen upon resume).
>
> Then I printed a list which pass "dev->direct_complete &&
> !pm_runtime_suspended(dev)" (with this patch applied), and the list was
> *very* long (maybe 100+). I can perform this again if you find the list
> useful.
>
> The sheer number of devices which pass  "dev->direct_complete &&
> !pm_runtime_suspended(dev)" made me think that your change should be
> re-considered, hence my patch.
>
> So, please give me advice on how I can point you to the code that you'd like
> to look at. I assume key information which device(s) pass
> "dev->direct_complete && !pm_runtime_suspended(dev)" AND cause the freeze on
> !dev->direct_complete? I'm afraid that will take a very long time to find
> out.

Let's continue this in the Bugzilla entry at

https://bugzilla.kernel.org/show_bug.cgi?id=199693

Thanks,
Rafael
