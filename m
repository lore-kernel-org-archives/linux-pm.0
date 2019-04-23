From: Jens Axboe <axboe@kernel.dk>
Subject: Re: next-20190408..0418: Suspend/resume problems on Thinkpad X60
Date: Tue, 23 Apr 2019 07:55:05 -0600
Message-ID: <41d56ba6-d0cb-5d5e-f5f4-9bca045440dd@kernel.dk>
References: <20190408173928.GB13260@amd> <20190412102812.GA24977@amd>
 <20190423102239.GA15531@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423102239.GA15531@amd>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net, linux-pm@vger.kernel.org, sfr@canb.auug.org.au, linux-next@vger.kernel.org, hdegoede@redhat.com, linux-ide@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 4/23/19 4:22 AM, Pavel Machek wrote:
> Hi!
> 
>>> It boots ok (unlike mainline -- I'm debugging that), and I can suspend
>>> and resume... but then cursor in X is moving and I can talk to
>>> applications cached in memory, but any access to disk hangs.
>>
>> Mainline problem was identified.
>>
>> But resume is still broken. I took advantage of fact that I can still
>> do cached commands, and got complete dmesg. I'm attaching it.
> 
> Still broken in 0418. Ideas would be welcome at this point.

Bisect it?

-- 
Jens Axboe
