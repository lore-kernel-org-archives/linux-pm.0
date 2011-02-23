From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: does hibernate to disk try hard enough to free
	memory?
Date: Wed, 23 Feb 2011 21:06:51 +0100
Message-ID: <201102232106.51980.rjw__35821.2076630027$1298491663$gmane$org@sisk.pl>
References: <201102222159.58546.Martin@lichtvoll.de>
	<201102222332.43864.rjw@sisk.pl>
	<201102231511.15683.Martin@lichtvoll.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201102231511.15683.Martin@lichtvoll.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Martin Steigerwald <Martin@lichtvoll.de>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, February 23, 2011, Martin Steigerwald wrote:
> Am Tuesday 22 February 2011 schrieb Rafael J. Wysocki:
> > On Tuesday, February 22, 2011, Martin Steigerwald wrote:
> > > Am Tuesday 22 February 2011 schrieb Rafael J. Wysocki:
> > > > On Tuesday, February 22, 2011, Martin Steigerwald wrote:
> > > > > Hi!
> > > > > 
> > > > > Since Radeon KMS I often have it that my ThinkPad T42 with 2 MiB
> > > > > of RAM is not able to allocate memory for the hibernation image.
> > > > > Before KMS hibernation only very rarely failed for that reason.
> > > > > 
> > > > > Often I run without compositing at all as I believe this might
> > > > > spare some pages as well. But this doesn't always help.
> > > > > 
> > > > > It complains that to less pages could be freed. For example with
> > > > > kernel 2.6.37:
> > > > > 
> > > > > Feb 16 00:15:00 shambhala kernel: PM: Creating hibernation image:
> > > > > Feb 16 00:15:00 shambhala kernel: PM: Need to copy 186577 pages
> > > > > Feb 16 00:15:00 shambhala kernel: PM: Normal pages needed: 114411
> > > > > + 1024, available pages: 112767
> > > > > Feb 16 00:15:00 shambhala kernel: PM: Not enough free memory
> > > > > Feb 16 00:15:00 shambhala kernel: PM: Error -12 creating
> > > > > hibernation image Feb 16 00:15:00 shambhala kernel: Extended
> > > > > CMOS year: 2000 Feb 16 00:15:00 shambhala kernel: ACPI: Waking
> > > > > up from system sleep state S4
> > > > > Feb 16 00:15:00 shambhala kernel: PM: early recover of devices
> > > > > complete after 0.376 msecs
> > > > 
> > > > What's the value in /sys/power/image_size?
> > > 
> > > shambhala:~> cat /sys/power/image_size
> > > 844206080
> > > 
> > > Should I try with less?
> > 
> > Yes, please.  Try with 700000000 for example.
> 
> I replaced dropping by settings image_size to this valua and the ThinkPad 
> hibernated with KMail open. Thus seems to work, but I will test a bit 
> further.
> 
> Where does the higher value previously set come from? Autotuning?

Likely.  The number seems to match at least.

> Is there anything that can be improved with autotuning?

We can lower the ratio of the image size to the total RAM.
Alternatively, we can increase SPARE_PAGES.

> If yes, I can file a bug report.

Yes, please.

> Otherwise I just try to find a good value for image size and be 
> done with it.

It would be helpful if you could determine the greatest image size working
for you.

Thanks,
Rafael
