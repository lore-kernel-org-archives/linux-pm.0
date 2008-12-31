From: "Sriram V" <vshrirama@gmail.com>
Subject: Re: PM with rootfs on mmc?
Date: Wed, 31 Dec 2008 21:02:06 +0530
Message-ID: <8bf247760812310732x6772b32fjf0ce5fdc25dea9bc@mail.gmail.com>
References: <8bf247760812302147i53ece31dx24a402cdeb6e28bd@mail.gmail.com>
	<alpine.LFD.2.00.0812310121520.17126@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0812310121520.17126@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,
   Now, i am able to bring linux out of suspend. The problem was to do
with the mmc card detection. With out card detection, The kernel used
to hang when i tried to
bring linux out of suspend.

The below works, if i boot out of NFS and mount sdmmc and do a

$ echo -n mem > /sys/power/state

However, If i boot out of SDMMC (rootfs on sdmmc). I am not able to
bring it out of suspend.
The kernel hangs.

I get the message:
# echo -n mem > /sys/power/state
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.00 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
mmc0: card e624 removed
--- kernel hangs---

Regards,
sriram






On Wed, Dec 31, 2008 at 11:53 AM, Len Brown <lenb@kernel.org> wrote:
>
>
>
>
> On Wed, 31 Dec 2008, Sriram V wrote:
>
>> Hi,
>>   I am trying to test pm on my platform/board.
>>   I am using the latest linux kernel - 2.6.28-rc6
>>   PM Support exists in my mmc driver and suspend and resume work fine.
>>
>>   With rootfs mounted via NFS. I am able to do
>>    $ echo -n mem > /sys/power/state
>>
>>   The above works. It successfully calls suspend and resume of sdmmc driver.
>>
>>   However, the same does not work if i have mounted the SDMMC card
>> with rootfs on NFS.
>>
>>   The kernel hangs, when i try to do
>>      $ echo -n mem > /sys/power/state
>>
>>  In this case suspend and resume functions of the driver are not called
>>  at all. (I gave a couple of debug prints at the beginning of suspend and resume
>>  and they didnot get print)
>>
>>  Same behaviour is observed when i boot out of SDMMC card. Suspend/Resume
>>  dont work. The kernel hangs.
>>
>> I get the messages in both case when i suspend-to-ram.
>>
>> PM: Syncing filesystems ... done.
>> Freezing user space processes ... (elapsed 0.00 seconds) done.
>> Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
>> Suspending console(s) (use no_console_suspend to debug)
>>
>>
>> I am not sure if this has to do with SD/MMC driver or something else.
>
> What do you seen when you boot with "no_console_suspend"
>
> You may also want to check out
> Documentation/power/basic-pm-debugging.txt"
>
> cheers,
> -- Len Brown, Intel Open Source Technology Center
>
>
>
