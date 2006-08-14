From: Laurent Riffard <laurent.riffard@free.fr>
Subject: Re: BUG while suspending to swap on LVM
Date: Mon, 14 Aug 2006 19:48:52 +0200
Message-ID: <44E0B784.5010900@free.fr>
References: <44E0A995.50806@free.fr> <200608141930.04502.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200608141930.04502.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@osdl.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


Le 14.08.2006 19:30, Rafael J. Wysocki a =E9crit :
> Hi,
> =

> Thanks for the report.
> =

> On Monday 14 August 2006 18:49, Laurent Riffard wrote:
>> Hello, =

>>
>> I hit a BUG while I was trying to suspend to a swap device on LVM. =

>> The call trace looks like this (see attached picture for detailed =

>> stack trace):
>>
>> EIP is at _raw_spin_lock
>> Call Trace:
>>   die
>>   do_page_fault
>>   error_code
>>   _spin_lock_irq
>>   generic_unplug_device
>>   wait_on_bio_chain
>>   swap_write_image
> =

> This should be swap_write_page().

right.
 =

>>   swsusp_write
>>   pm_suspend_disk
>>   enter_state
>>   state_store
>>   susbsys_attr_store
>>   sysfs_write_file
>>   vfs_write
>>   sys_write
>>   sysenter_past_esp
>>
>> It was Linux 2.6.18-rc4-mm1 booted with:
>> root=3D/dev/vglinux1/lvroot video=3Dvesafb:mtrr splash=3Dsilent resume=
=3D/dev/mapper/vglinux1-lvswap init 1
> =

> Does the unpatched 2.6.18-rc4 work in this configuration?

Will try.

Thanksfor your response.
-- =

laurent
