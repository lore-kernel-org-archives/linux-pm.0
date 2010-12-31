From: Maksim Rayskiy <maksim.rayskiy@gmail.com>
Subject: Re: [RFC] Deferred disk spinup during system resume
Date: Thu, 30 Dec 2010 16:49:29 -0800
Message-ID: <AANLkTikLn7VyB+TJMz=GGTHKSHg+9feQ9bje+KS3pD3k__697.565594646399$1293756652$gmane$org@mail.gmail.com>
References: <AANLkTinOqLOJ7JCpHeQNYUEirqAvkSce+eFDCGkWn3jE@mail.gmail.com>
	<201012302346.07275.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012302346.07275.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, linux-scsi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

>> When resuming from system suspend, scsi disks are being spun up which
>> takes quite a lot of time (5+ seconds in my case). The spinup is done
>> synchronously, so this time adds up to overall system resume time.
>> Ours is an embedded platform and we are using flash-based rootfs, so
>> there is no immediate need in harddrive after resume. What is much
>> more important for us is to minimize time-to-full-power. To speed up
>> resume, we would like to have an option to defer the spinup or run it
>> in parallel with system resume. I could not find any existing
>> mechanism to do the trick, but I might have missed something.
>>
>> Can anybody comment on this?
>
> Do you use asynchronous suspend/resume?
>

Yes, asynchronous suspend/resume is enabled - it saves about 0.5
second in my case. But resume blocks anyway because disk driver is
waiting on sd_resume() to complete.

I am wondering if we could let the resume proceed while spinup is
going on, just mark the scsi device as quiescent to block any data
transfers.

Maksim.

> Rafael
> --
