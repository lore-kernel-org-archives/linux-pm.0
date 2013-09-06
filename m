From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] virtio_pci: pm: Use CONFIG_PM_SLEEP instead of CONFIG_PM
Date: Fri, 06 Sep 2013 15:41:36 +0800
Message-ID: <52298730.7020003@intel.com>
References: <52293DD4.6050403@intel.com> <20130906072046.GB29367@grmbl.mre>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:20256 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750721Ab3IFHlY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 6 Sep 2013 03:41:24 -0400
In-Reply-To: <20130906072046.GB29367@grmbl.mre>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Amit Shah <amit.shah@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, "Rafael J. Wysocki" <rjw@sisk.pl>, virtualization@lists.linux-foundation.org, Linux-pm mailing list <linux-pm@vger.kernel.org>

On 09/06/2013 03:20 PM, Amit Shah wrote:
> On (Fri) 06 Sep 2013 [10:28:36], Aaron Lu wrote:
>>
>> The virtio_pci_freeze/restore are defined under CONFIG_PM but is use=
d
>> by SET_SYSTEM_SLEEP_PM_OPS macro, which is defined under
>> CONFIG_PM_SLEEP. So if CONFIG_PM_SLEEP is not cofigured but
>> CONFIG_PM_RUNTIME is, the following warning message appeared:
>>
>> drivers/virtio/virtio_pci.c:770:12: warning: =E2=80=98virtio_pci_fre=
eze=E2=80=99 defined but not used [-Wunused-function]
>>  static int virtio_pci_freeze(struct device *dev)
>>             ^
>> drivers/virtio/virtio_pci.c:790:12: warning: =E2=80=98virtio_pci_res=
tore=E2=80=99 defined but not used [-Wunused-function]
>>  static int virtio_pci_restore(struct device *dev)
>>             ^
>> Fix it by changing CONFIG_PM to CONFIG_PM_SLEEP.
>>
>> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
>> ---
>>  drivers/virtio/virtio_pci.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> While you're at it, can you update the virtio drivers as well?

No problem, I think I'll send a separate patch for them on top of this
one, since they do not cause compile warnings.

Thanks,
Aaron

>=20
> drivers/block/virtio_blk.c
> drivers/char/hw_random/virtio_rng.c
> drivers/char/virtio_console.c
> drivers/net/virtio_net.c
> drivers/scsi/virtio_scsi.c
> drivers/virtio/virtio_balloon.c
>=20
> Thanks,
>=20
> 		Amit
>=20

