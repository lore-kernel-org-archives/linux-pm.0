From: Bart Van Assche <bvanassche@acm.org>
Subject: Re: regression -next -- scsi: sd: Rely on the driver core for
 asynchronous probing was Re: next-20190408..0418: Suspend/resume problems on
 Thinkpad X60
Date: Thu, 25 Apr 2019 06:35:58 -0700
Message-ID: <360f6936-ee21-a036-9bd4-93ecfee829e2@acm.org>
References: <20190408173928.GB13260@amd> <20190412102812.GA24977@amd>
 <20190423102239.GA15531@amd> <41d56ba6-d0cb-5d5e-f5f4-9bca045440dd@kernel.dk>
 <20190424095431.GA32457@amd> <20190424104850.GC32457@amd>
 <20190424202119.GA26357@amd> <20190424204832.GA3111@amd>
 <20190424205150.GA4582@amd> <1556139361.161891.140.camel@acm.org>
 <20190425073343.GA19600@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190425073343.GA19600@amd>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@denx.de>
Cc: Jens Axboe <axboe@kernel.dk>, jejb@linux.ibm.com, martin.petersen@oracle.com, lduncan@suse.com, hare@suse.com, mcgrof@kernel.org, jthumshirn@suse.de, hch@lst.de, gregkh@linuxfoundation.org, dan.j.williams@intel.com, kernel list <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net, linux-pm@vger.kernel.org, sfr@canb.auug.org.au, linux-next@vger.kernel.org, hdegoede@redhat.com, linux-ide@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 4/25/19 12:33 AM, Pavel Machek wrote:
> On Wed 2019-04-24 13:56:01, Bart Van Assche wrote:
>> On Wed, 2019-04-24 at 22:51 +0200, Pavel Machek wrote:
>>> Unfortunately, that one does not revert cleanly on top of -next.
>>
>> Can you try the following:
>>
>> git revert d16ece577bf2cee7f94bab75a0d967bcb89dd2a7 &&
>>   git revert 21e6ba3f0e0257cce1a226c1f15e0a8ba4338ca3
>>
>> I will see whether I can come up with a better way to analyze what is
>> going on. I had not expected that these patches would cause any suspend/
>> resume problems.
> 
> Not even d16ece reverts:
> 
> pavel@duo:/data/l/linux-next-32$ git show  | head -3
> commit 76c938fcaa4b4a5d8f05fa907925d5043834964e
> Author: Stephen Rothwell <sfr@canb.auug.org.au>
> Date:   Tue Apr 23 20:24:59 2019 +1000
> pavel@duo:/data/l/linux-next-32$ git revert
> d16ece577bf2cee7f94bab75a0d967bcb89dd2a7
> error: could not revert d16ece5... scsi: sd: Inline sd_probe_part2()
> hint: after resolving the conflicts, mark the corrected paths
> hint: with 'git add <paths>' or 'git rm <paths>'
> hint: and commit the result with 'git commit'

There has been a non-trivial merge between the block and scsi trees in
linux-next. That's probably what prevents these patches to revert
cleanly. How about performing the following tests:
* Build, boot and test Martin's latest for-5.2 branch
(git://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git; branch
5.2/scsi-queue).
* If suspend/resume does not work reliably with that branch, revert the
two patches above, rebuild, reboot and retest.

Thanks,

Bart.
