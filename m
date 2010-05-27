From: Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Subject: Re: [PATCH 1/8] PM: Opportunistic suspend support.
Date: Thu, 27 May 2010 10:17:14 +0200
Message-ID: <1274948234.14002.27.camel__26011.9083025076$1274974050$gmane$org@thorin>
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
	<1274898180.4467.925.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1274898180.4467.925.camel@mulgrave.site>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Andi Kleen <ak@linux.intel.com>, Florian Mickler <florian@mickler.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Len Brown <len.brown@intel.com>, Greg KH <gregkh@suse.de>, Pekka Enberg <penberg@cs.helsinki.fi>, Thomas Gleixner <tglx@linutronix.de>, tytso@mit.edu, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>
List-Id: linux-pm@vger.kernel.org

On Mit, 2010-05-26 at 13:23 -0500, James Bottomley wrote:
> On Wed, 2010-05-26 at 19:51 +0200, Thomas Gleixner wrote:
[...]
> > Darn, _we_ have to deal with that forever as it sets a crappy user
> > space ABI in stone.
> 
> I really don't see how it is ... the ABI comes with a switch that allows
> it to be disabled, so only platforms wishing to use it have to support
> it.  Even on those platforms that do support it, we can translate most

You completely missed the point: The crappy user interface - and
interferences with pother subsystems - must be maintained for ages - and
that is independent if one uses it or not. Even worse if it's not widely
used.

> of it into pm QoS stuff and if one day someone solves the rogue app
> problem, we can migrate over.

If it's so important for Android and no one else, Android can carry it
out of tree.

	Bernd
-- 
Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
                     LUGA : http://www.luga.at
