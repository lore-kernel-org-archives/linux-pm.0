From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Freezing filesystems (Was Re: What's in store for 2008
	for TuxOnIce?)
Date: Wed, 02 Jan 2008 10:54:18 +1100
Message-ID: <477AD2AA.4070707__38546.8613509603$1199231843$gmane$org@nigel.suspend2.net>
References: <477AC060.5040004@nigel.suspend2.net>
	<200801020021.37259.rjw@sisk.pl>
Reply-To: nigel@nigel.suspend2.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801020021.37259.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, The place to get help! <suspend2-users@lists.tuxonice.net>, suspend2-devel@lists.tuxonice.net, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi.

Rafael J. Wysocki wrote:
> On Tuesday, 1 of January 2008, Nigel Cunningham wrote:
>> Hi all.
> 
> Hi Nigel,

Gidday :)

>> With the start of a new year, I suppose it's a good time to think about
>> what I'd like to do with TuxOnIce this year and see what feedback I get.
>>
>> First up, I'm thinking about closing the mailing lists and asking people
>> to use LKML instead for reporting issues and so on. I'm thinking about
>> this because it will help with allowing people who work on mainline to
>> see how stable (or otherwise!) TuxOnIce is now. It should also help when
>> (as often happens) bug reports aren't actually issues with the patch,
>> but with vanilla (ie drivers).
> 
> I would also like the TuxOnIce issues related to drivers, ACPI, etc. to go to
> one of the kernel-related lists, but I think linux-pm may be better for that
> due to the much lower traffic.

I guess that makes sense. I guess people can always be referred to LKML
for the issues where the appropriate person isn't on linux-pm.

>> Perhaps it will also help with whatever effort I find time to make towards
>> convincing Andrew that it really does have significant advantages over
>> [u]swsusp and kexec based hibernation. 
>>
>> Secondly, I'm planning on moving the website soonish. It's taken longer
>> than I planned because it will be sharing with another server I'm
>> maintaining, and it has taken longer than expected to find good hosting
>> for the other server (which was done first). Now that I'm happy with the
>> other server's state, I'm hoping to start shifting
>> suspend2.net/tuxonice.net soon.
>>
>> For those who might be looking for hosting themselves, I'm using
>> slicehost. I initially tried GoDaddy, but had terrible service, problems
>> with draconian limits on the volume of outgoing email (1000/day by
>> default - useless if you're doing mailing lists) and unexpected,
>> unexplained delays in mail delivery through the SMTP delay they force
>> you to use. Slicehost, on the other hand, are terrific to deal with in
>> everyway. If you sign up with them because of this email, please
>> consider putting my email (nigel at suspend2.net) as the referrer - I
>> then get a discount on the cost of the hosting.
>>
>> Third, regarding the patch itself, I'm taking my time in working towards
>> the 3.0 release. We don't have any major bugs with 3.0-rc3 reported, but
>> I have some things I want to complete before the final release:
>> * see it well tested;
>> * get a finished initial version of the cluster support;
>> * finish completing support for the new resume-from-other kernels
>> functionality that Rafael has added in 2.6.24. (We can resume from the
>> same kernel at the moment, but I need to convince myself that nosave
>> data is properly handled).
> 
> Have you finished the support for freezing filesystems before freezing tasks
> that we talked about some time ago?

Hmm. I've had too many things going through my little brain since then.
What I currently have is support for freezing fuse filesystems
separately. It looks like:

int freeze_processes(void)
{
        int error;

        printk("Stopping fuse filesystems.\n");
        freeze_filesystems(FS_FREEZER_FUSE);
        freezer_state = FREEZER_FILESYSTEMS_FROZEN;
        printk("Freezing user space processes ... ");
        error = try_to_freeze_tasks(FREEZER_USER_SPACE);
        if (error)
                goto Exit;
        printk("done.\n");

        sys_sync();
        printk("Stopping normal filesystems.\n");
        freeze_filesystems(FS_FREEZER_NORMAL);
        freezer_state = FREEZER_USERSPACE_FROZEN;
        printk("Freezing remaining freezable tasks ... ");
        error = try_to_freeze_tasks(FREEZER_KERNEL_THREADS);
        if (error)
                goto Exit;
        printk("done.");
        freezer_state = FREEZER_FULLY_ON;
 Exit:
        BUG_ON(in_atomic());
        printk("\n");
        return error;
}

(I'm not yet worrying about ext3 on fuse or such like, but it shouldn't
be hard to extend the model to do that).

Nigel
