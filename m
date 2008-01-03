From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: Re: [patch] hibernation: utilize ACPI hardware
	signature
Date: Thu, 03 Jan 2008 19:26:56 +1100
Message-ID: <477C9C50.4060907__33725.4450227649$1199349013$gmane$org@nigel.suspend2.net>
References: <1199257162.14632.4.camel@sli10-desk.sh.intel.com>
	<200801021512.54140.rjw@sisk.pl>
	<477C0155.70902@nigel.suspend2.net>
	<200801022318.59392.rjw@sisk.pl>
Reply-To: nigel@nigel.suspend2.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801022318.59392.rjw@sisk.pl>
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
Cc: linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, =?ISO-8859-15?Q?Erik_Andr=E9n?= <erik.andren@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi.

Rafael J. Wysocki wrote:
>>>> Is there another mechanism preventing this?
>>> Not at the kernel level, but you can prevent this from happening by running
>>> mkswap on all swap spaces that refuse to come up after a fresh boot.
>> We really should do something about this. It should be possible to
>> handle this properly if something along the following lines was implemented:
>>
>> 1) Each filesystem implements a function taking a pointer to a struct
>> block_device and returns a mount count for that filesystem without
>> making any modifications to the filesystem.
>> 2) Hibernation implementations store the major & minor numbers and mount
>> counts for each mounted filesystem in the image header when hibernating,
>> and recheck those values at resume time. If the mount count on any
>> filesystem has changes, we warn the user, invalidate the image and boot
>> normally.
> 
> That may quickly become complicated.
> 
> For example, boot kernel need not contain all drivers used by the hibernated
> ones, so some filesystems may be physically inaccessible to them.

Mmmm. That's true, and I'd never heard that point raised before or
thought of it myself. Thanks!

Nigel
