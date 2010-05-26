From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: [PATCH 1/8] PM: Opportunistic suspend support.
Date: Wed, 26 May 2010 15:06:11 -0500
Message-ID: <1274904371.4467.1145.camel__33477.6236712516$1274916109$gmane$org@mulgrave.site>
References: <1274863342.5882.4850.camel@twins>
	<20100526112303.3fef15a4@schatten.dmk.lab>
	<1274866402.5882.5051.camel@twins>
	<AANLkTil9ZtMFxTfE6ITiFNOl4S1k3Lvdp5BPgGX7LJhw@mail.gmail.com>
	<1274868384.5882.5169.camel@twins>
	<AANLkTimHGpRAZklIwXu6wEbA3coKXJvCVLxj2twerkCw@mail.gmail.com>
	<1274869262.5882.5222.camel@twins>
	<AANLkTik9LINPmabJfVi0jfVs5sjVS_1l00WpnVTFEuLV@mail.gmail.com>
	<1274890736.4467.574.camel@mulgrave.site>
	<1274891308.1674.1766.camel@laptop> <20100526165919.GB2089@elf.ucw.cz>
	<1274893309.1674.1773.camel@laptop>
	<1274894685.4467.758.camel@mulgrave.site>
	<alpine.LFD.2.00.1005261948290.2995@localhost.localdomain>
	<1274898180.4467.925.camel@mulgrave.site> <15650.1274899857@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <15650.1274899857@localhost>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Valdis.Kletnieks@vt.edu
Cc: linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Andi Kleen <ak@linux.intel.com>, Florian Mickler <florian@mickler.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Len Brown <len.brown@intel.com>, Greg KH <gregkh@suse.de>, Pekka Enberg <penberg@cs.helsinki.fi>, Thomas Gleixner <tglx@linutronix.de>, tytso@mit.edu, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 2010-05-26 at 14:50 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Wed, 26 May 2010 13:23:00 CDT, James Bottomley said:
> > On Wed, 2010-05-26 at 19:51 +0200, Thomas Gleixner wrote:
> > > Darn, _we_ have to deal with that forever as it sets a crappy user
> > > space ABI in stone.
> > 
> > I really don't see how it is ... the ABI comes with a switch that allows
> > it to be disabled, so only platforms wishing to use it have to support
> > it.  Even on those platforms that do support it, we can translate most
> > of it into pm QoS stuff and if one day someone solves the rogue app
> > problem, we can migrate over.
> 
> And yet, the OSS drivers are *still* in-tree, even though similar arguments
> apply to an OSS->ALSA migration.  And there's a bunch of other stuff in
> Documentation/feature-removal-schedule.txt in a similar situation.

On the other hand APM, which is what all laptops used to use to suspend
is gone from the x86 kernel today ... replaced by ACPI or other platform
mechanisms, so it is at least possible.

James
