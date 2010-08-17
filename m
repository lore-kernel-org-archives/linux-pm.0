From: Stephan Diestelhorst <stephan.diestelhorst@amd.com>
Subject: Re: [PATCH] SATA / AHCI: Do not play with the link PM during suspend to RAM
Date: Tue, 17 Aug 2010 09:51:25 +0200
Message-ID: <201008170951.26073.stephan.diestelhorst@amd.com>
References: <201007091750.05020.stephan.diestelhorst@amd.com> <4C52DF50.80009@kernel.org> <4C5AE1E2.6070601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4C5AE1E2.6070601@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-pm@lists.osdl.org" <linux-pm@lists.osdl.org>, Stephan Diestelhorst <stephan.diestelhorst@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Tejun,

On Thursday 05 August 2010 18:08:02 Tejun Heo wrote:
> Can you please try the following patch and see whether the problem
> goes away?

I've finally managed to get this to compile and test. (Hit a bug with
Debian's make-kpkg and other nuisances...)

The problem is still there. On some resumes I get the dreadful dead
disk again:

end_request: I/O error , dev sda sector ...
sd 0:0:0:0: [sda] Unhandled error code
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
sd 0:0:0:0: [sda] CDB: Read(10): 28 00 0e a4 77 a8 0 00 08 00
(many of those)

Can't access /var/log/messages right now, due to broken I/O. Will try
to trigger it again and check for the qc timeout messages..

Stephan

-- 
Stephan Diestelhorst, AMD Operating System Research Center
stephan.diestelhorst@amd.com, Tel. +49 (0)351 448 356 719

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
