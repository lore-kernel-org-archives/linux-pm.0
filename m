From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/8] PM: Opportunistic suspend support.
Date: Thu, 27 May 2010 00:10:41 +0200
Message-ID: <201005270010.41111.rjw__5449.0725313828$1274916760$gmane$org@sisk.pl>
References: <AANLkTil9ZtMFxTfE6ITiFNOl4S1k3Lvdp5BPgGX7LJhw@mail.gmail.com>
	<20100526172824.GA9069@elf.ucw.cz>
	<20100526211542.1bfa2564@schatten.dmk.lab>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100526211542.1bfa2564@schatten.dmk.lab>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Florian Mickler <florian@mickler.org>
Cc: Greg KH <gregkh@suse.de>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Andi Kleen <ak@linux.intel.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Len Brown <len.brown@intel.com>, James Bottomley <James.Bottomley@suse.de>, tytso@mit.edu, Pekka Enberg <penberg@cs.helsinki.fi>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday 26 May 2010, Florian Mickler wrote:
> On Wed, 26 May 2010 19:28:24 +0200
> Pavel Machek <pavel@ucw.cz> wrote:
> 
> 
> > Besides that it is not linux system at all?
> 
> I believe the kernel to be a layer between userspace and hardware. What
> business is it to the kernel if it runs whatever android
> uses as init process or /bin/bash, sys-v-init or systemd?
> 
> There is this thing called choice. 
> 
> > 
> > Yes, with custom userspace it works extremely nicely.
> > 
> > Had anyone even tried running oportunistic suspend on normal desktop?
> > 									Pavel
> 
> I don't think this is a valid concern. Just because current linux/gnu
> systems don't implement the userspace part of this interface doesn't
> mean it is useless or broken. 

Agreed.

BTW, this is a valid point.  We are used to think about Linux as the kernel
plus the GNU user space, but that's not how it has to be.

Thanks,
Rafael
