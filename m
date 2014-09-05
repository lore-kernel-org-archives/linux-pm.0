From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: [PATCH 3.10.y+] PM / sleep: Use valid_state() for platform-dependent
 sleep states only
Date: Fri, 05 Sep 2014 16:52:28 +0200
Message-ID: <5409CE2C.8000609@gmail.com>
References: <1849024.CHOUso6H2K@vostro.rjw.lan> <1409865665-5375-1-git-send-email-computersforpeace@gmail.com> <54095835.7000207@gmail.com> <20140905074512.GA12218@brian-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20140905074512.GA12218@brian-ubuntu>
Sender: stable-owner@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, linux-pm@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

On 09/05/2014 09:45 AM, Brian Norris wrote:
> On Fri, Sep 05, 2014 at 08:29:09AM +0200, Francis Moreau wrote:
>> On 09/04/2014 11:21 PM, Brian Norris wrote:
> [...]
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> Cc: <stable@vger.kernel.org> # 3.10+: 27ddcc6596e5: PM / sleep: Add state field to pm_states[] entries
>>> Cc: <stable@vger.kernel.org> # 3.10+
>>> ---
>>> This is a backport request for these two commits upstream:
>>>
>>>     27ddcc6596e5 PM / sleep: Add state field to pm_states[] entries
>>>     43e8317b0bba PM / sleep: Use valid_state() for platform-dependent sleep states only
>>>
>>
>> Wouldn't it be cleaner to have 2 separate backports then ?
> 
> The first is purely a dependency for the second. It has no value on its
> own. So I thought the above form made sense and followed the process
> mentioned in Documentation/stable_kernel_rules.txt.
> 
> Admittedly, it's a little asymmetric. But I really don't know what the
> "best" option is, since I'd prefer not having to send around any patch
> text at all, unless the backport is not trivial (these apply cleanly).

I don't know, I just find cleaner to cherry-pick upstream commits when
possible so I can retrieve them easily later when inspecting a stable
kernel.

My 2 cents.
