From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/3] PM, vfs: use filesystem freezing instead of kthread freezer
Date: Tue, 3 Nov 2015 22:33:21 +0100
Message-ID: <CAJZ5v0iamJrZ5FtX8PuiAhH9yLdGapmYq40HBHtQ7QGRUEPooA@mail.gmail.com>
References: <Pine.LNX.4.44L0.1510301637310.1659-100000@iolanthe.rowland.org>
	<6015070.Gclh0s3EvS@vostro.rjw.lan>
	<alpine.LNX.2.00.1510310844360.17538@pobox.suse.cz>
	<2258525.D9qdTJBeTN@vostro.rjw.lan>
	<20151103001053.GL10656@dastard>
	<20151103093133.GB4063@quack.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36174 "EHLO
	mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbbKCVdW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Nov 2015 16:33:22 -0500
In-Reply-To: <20151103093133.GB4063@quack.suse.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jan Kara <jack@suse.cz>
Cc: Dave Chinner <david@fromorbit.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jiri Kosina <jikos@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi,

On Tue, Nov 3, 2015 at 10:31 AM, Jan Kara <jack@suse.cz> wrote:
> On Tue 03-11-15 11:10:53, Dave Chinner wrote:
>> On Mon, Nov 02, 2015 at 03:43:07AM +0100, Rafael J. Wysocki wrote:
>> > I guess it may also helps to address the case when a device is removed from a
>> > suspended system, written to on another system in the meantime and inserted
>> > back into the (still suspended) original system which then is resumed.  Today
>> > this is an almost guaranteed data corruption scenario, but if the filesystem in
>> > question is properly frozen during suspend, the driver should be able to detect
>> > superblock changes during unfreeze.
>>
>> Never going to work. There is no guarantee that a write to a
>> filesystem by a third party device is going to change the superblock
>> (or any metadata in the rest of the filesystem) in any detectable
>> way.  Hence freezing filesystems will not prevent Bad Things
>> Happening if you do this while your system is suspended.
>
> Agreed, we should never advertise something like this works. OTOH the truth
> is that e.g. in ext4 case a simple check in ext4_unfreeze() could catch 90%
> of cases where user shot himself in the foot like this (i.e., ext4 driver
> will update write time in superblock if it gets mounted somewhere else and
> we can check whether that didn't change in ext4_unfreeze()) and refuse to
> touch the filesystem... It is not 100% reliable since user could have used
> e.g. debuge2fs to arbitrarily modify the filesystem but in such cases they
> have to know what they are doing anyway.

Well, my idea was to use this for sanity checking.  I guess that
sanity checks here don't really hurt, do they?  And if they fail,
perhaps we can just avoid touching the fs again for safety reasons?

Thanks,
Rafael
