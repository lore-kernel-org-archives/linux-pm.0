From: Bart Van Assche <bvanassche@acm.org>
Subject: Re: regression -next -- scsi: sd: Rely on the driver core for
 asynchronous probing was Re: next-20190408..0418: Suspend/resume problems
 on Thinkpad X60
Date: Fri, 26 Apr 2019 07:58:49 -0700
Message-ID: <1556290729.161891.148.camel@acm.org>
References: <20190423102239.GA15531@amd>
         <41d56ba6-d0cb-5d5e-f5f4-9bca045440dd@kernel.dk>
         <20190424095431.GA32457@amd> <20190424104850.GC32457@amd>
         <20190424202119.GA26357@amd> <20190424204832.GA3111@amd>
         <20190424205150.GA4582@amd> <1556139361.161891.140.camel@acm.org>
         <20190425073343.GA19600@amd> <360f6936-ee21-a036-9bd4-93ecfee829e2@acm.org>
         <20190426103249.GA5001@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-7"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190426103249.GA5001@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@denx.de>
Cc: Jens Axboe <axboe@kernel.dk>, jejb@linux.ibm.com, martin.petersen@oracle.com, lduncan@suse.com, hare@suse.com, mcgrof@kernel.org, jthumshirn@suse.de, hch@lst.de, gregkh@linuxfoundation.org, dan.j.williams@intel.com, kernel list <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net, linux-pm@vger.kernel.org, sfr@canb.auug.org.au, linux-next@vger.kernel.org, hdegoede@redhat.com, linux-ide@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2019-04-26 at 12:32 +-0200, Pavel Machek wrote:
+AD4 +AFs-detached HEAD 916db0d+AF0 Revert +ACI-scsi: sd: Inline sd+AF8-probe+AF8-part2()+ACI
+AD4  1 file changed, 58 insertions(+-), 43 deletions(-)
+AD4  pavel+AEA-duo:/data/l/linux-next-32+ACQ git revert
+AD4  21e6ba3f0e0257cce1a226c1f15e0a8ba4338ca3
+AD4  Editing file: /data/fast/l/linux-next-32/.git/COMMIT+AF8-EDITMSG
+AD4  1163
+AD4  ?
+AD4  +AFs-detached HEAD ac8d625+AF0 Revert +ACI-scsi: sd: Rely on the driver core for
+AD4  asynchronous probing+ACI
+AD4   4 files changed, 47 insertions(+-), 5 deletions(-)
+AD4 
+AD4 
+AD4 And reverting those two indeed fixes it:
+AD4 
+AD4 Checking version...
+AD4 version is  Linux amd 5.1.0-rc1autobisect1556274387+- +ACM-261 SMP Fri Apr
+AD4 26 12:27:12 CEST 2019 i686 GNU/Linux
+AD4 Running test...
+AD4 Result is +AFs TEST SUCCESS +AF0
+AD4 Test said TEST SUCCESS

Can you share your config file? I hope that will allow me to reproduce this
issue.

Thanks,

Bart.
