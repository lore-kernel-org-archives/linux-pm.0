From: Milton Miller <miltonm@bga.com>
Subject: Re: Re: Hibernation considerations
Date: Fri, 20 Jul 2007 14:09:00 -0500
Message-ID: <f56664625c843ac71672d2818c4df69f@bga.com>
References: <f29402c6050f9c3ff5d83a59cea2de58%40bga.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jeremy Maitin-Shepard <jbms@cmu.edu>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri Jul 20 10:31:41 PDT 2007, Jeremy Maitin-Shepard wrote:
> Milton Miller <miltonm at bga.com> writes:
>>>>> (7) how to avoid corrupting filesystems mounted by the hibernated 
>>>>> kernel
>>>>
>>>> I didn't realize this was a discussion item. I thought the options 
>>>> were
>>>> clear, for some filesystem types you can mount them read-only, but 
>>>> for
>>>> ext3 (and possilby other less common ones) you just plain cannot 
>>>> touch
>>>> them.
>>>
>>> That's correct.  And since you cannot thouch ext3, you need either 
>>> to assume
>>> that you won't touch filesystems at all, or to have a code to 
>>> recognize the
>>> filesystem you're dealing with.
>>
>> Or add a small bit of infrastructure that errors writes at 
>> make_request if you
>> don't have a magic "i am a direct block device write from userspace" 
>> flag on the
>> bio.
>
> I still don't understand why there is this fixation on accessing dirty
> filesystems in use by the hibernated system.  Even if you avoid
> corrupting the filesystem by avoiding writing to the block device, 
> there
> isn't any real guarantee about the state of the data, except for a
> filesystem that specifically makes guarantees about such data (and I
> don't believe any of the existing ones do).
>
> It isn't necessary to be able to access such filesystems: everything 
> can
> be done from an initramfs/initrd.

There is a requirement to hibernate without dedicating a partition to 
save the data.  Two reasons given have been upgrading ram in a machine 
should not require a repartition of the hard drive, and the intel macs 
can only have 4 partitions total and people want to dual boot.

Not having a separate partition means the userspace in the initramfs 
needs to obtain a list of blocks upon which to write the data.  My 
first proposal was to do it all from userspace of the new kernel by 
calling bmap on the filesystem mounted read only.   My later proposal 
is to allocate the blocks in the suspending kernel and pass the block 
list to userspace.

There is still the question of how does the restore kernel find the 
block list to restore from.  It does help the first kernel invalidating 
the image in the suspend-to-both resume-from-ram case.

milton

PS: I'm not subscribed to the list, and only saw your reply on the 
archives ... which give me my message id as the message to reply to.   
I'd appreciate being cc'd in the future.  Thanks.
