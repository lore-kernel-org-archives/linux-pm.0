From: Bart Van Assche <bvanassche@acm.org>
Subject: Re: regression -next -- scsi: sd: Rely on the driver core for
 asynchronous probing was Re: next-20190408..0418: Suspend/resume problems
 on Thinkpad X60
Date: Wed, 24 Apr 2019 13:56:01 -0700
Message-ID: <1556139361.161891.140.camel@acm.org>
References: <20190408173928.GB13260@amd> <20190412102812.GA24977@amd>
         <20190423102239.GA15531@amd>
         <41d56ba6-d0cb-5d5e-f5f4-9bca045440dd@kernel.dk>
         <20190424095431.GA32457@amd> <20190424104850.GC32457@amd>
         <20190424202119.GA26357@amd> <20190424204832.GA3111@amd>
         <20190424205150.GA4582@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-7"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190424205150.GA4582@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@denx.de>, Jens Axboe <axboe@kernel.dk>, jejb@linux.ibm.com, martin.petersen@oracle.com, lduncan@suse.com, hare@suse.com, mcgrof@kernel.org, jthumshirn@suse.de, hch@lst.de, gregkh@linuxfoundation.org, dan.j.williams@intel.com
Cc: kernel list <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net, linux-pm@vger.kernel.org, sfr@canb.auug.org.au, linux-next@vger.kernel.org, hdegoede@redhat.com, linux-ide@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2019-04-24 at 22:51 +-0200, Pavel Machek wrote:
+AD4 Unfortunately, that one does not revert cleanly on top of -next.

Can you try the following:

git revert d16ece577bf2cee7f94bab75a0d967bcb89dd2a7 +ACYAJg
  git revert 21e6ba3f0e0257cce1a226c1f15e0a8ba4338ca3

I will see whether I can come up with a better way to analyze what is
going on. I had not expected that these patches would cause any suspend/
resume problems.

Bart.
