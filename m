From: Woody Suwalski <terraluna977@gmail.com>
Subject: Re: linux-next on x60: network manager often complains "network is
 disabled" after resume
Date: Tue, 20 Mar 2018 21:11:54 -0400
Message-ID: <c7d96582-e2e6-d9c8-1140-3f1dab836132@gmail.com>
References: <20180318104023.GA10392@amd>
 <70721f83-344a-0f23-223b-9c81f6e9e32a@gmail.com> <20180319092106.GA5683@amd>
 <6e43123a-5227-96c4-a1f5-4416bdb5b0db@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6e43123a-5227-96c4-a1f5-4416bdb5b0db@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>, Netdev list <netdev@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Woody Suwalski wrote:
> Pavel Machek wrote:
>> On Mon 2018-03-19 05:17:45, Woody Suwalski wrote:
>>> Pavel Machek wrote:
>>>> Hi!
>>>>
>>>> With recent linux-next, after resume networkmanager often claims that
>>>> "network is disabled". Sometimes suspend/resume clears that.
>>>>
>>>> Any ideas? Does it work for you?
>>>>                                     Pavel
>>> Tried the 4.16-rc6 with nm 1.4.4 - I do not see the issue.
>> Thanks for testing... but yes, 4.16 should be ok. If not fixed,
>> problem will appear in 4.17-rc1.
>>
> Works here OK. Tried ~10 suspends, all restarted OK.
> kernel next-20180320
> nmcli shows that Wifi always connects OK
>
> Woody
>
Contrary, it just happened to me on a 64-bit build 4.16-rc5 on T440.
I think that Dan's suspicion is correct - it is a snafu in the PM: 
trying to hibernate results in a message:
Failed to hibernate system via logind: There's already a shutdown or 
sleep operation in progress.

And ps shows "Ds /lib/systemd/systemd-sleep suspend"...

Woody
