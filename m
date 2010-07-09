From: Stephan Diestelhorst <stephan.diestelhorst@gmail.com>
Subject: Re: HDD not suspending properly / dead on resume
Date: Fri, 9 Jul 2010 23:47:28 +0200
Message-ID: <201007092347.29244.stephan.diestelhorst@gmail.com>
References: <201007091750.05020.stephan.diestelhorst@amd.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_wj5NMmLhbH06zII"
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <201007091750.05020.stephan.diestelhorst@amd.com>
Sender: linux-ide-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--Boundary-00=_wj5NMmLhbH06zII
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit

I wrote:
>   I have an issue with suspend to RAM and I/O load on a disk. Symptoms
> are that the disk does not respond to requests when woken up, producing
> only I/O errors on all tested kernels (newest 2.6.35-rc4 (Ubuntu
> mainline PPA build)):
> 
<snip>
 
> This can be triggered most reliably with multiple "direct" writes to
> disk, I create the load with the attached script. If the issue is
> triggered, suspend (through pm-suspend) takes very long.

Attached now...

> IMHO the interesting log output during suspend is:
> [ 1674.700125] ata1.00: qc timeout (cmd 0xec)

Almighty google suggested to try "pci=nomsi", which seems to have
cured the issue for me for now. Is that plausible? I'll keep this
under observation.

Thanks,
  Stephan

--Boundary-00=_wj5NMmLhbH06zII
Content-Type: application/x-shellscript;
  name="io_load.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="io_load.sh"

#!/bin/bash
CONC=10
BS=4096
COUNT=1024
while true; do
	for i in $(seq 1 ${CONC}); do
		dd if=/dev/zero of=zeroes_${i} oflag=direct bs=${BS} count=${COUNT} &
	done
	wait
done


--Boundary-00=_wj5NMmLhbH06zII--
