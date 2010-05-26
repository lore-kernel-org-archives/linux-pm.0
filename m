From: Florian Mickler <florian@mickler.org>
Subject: Re: [PATCH 1/8] PM: Opportunistic suspend support.
Date: Wed, 26 May 2010 21:15:42 +0200
Message-ID: <20100526211542.1bfa2564__48421.4344680824$1274901400$gmane$org@schatten.dmk.lab>
References: <AANLkTil9ZtMFxTfE6ITiFNOl4S1k3Lvdp5BPgGX7LJhw@mail.gmail.com>
	<1274868384.5882.5169.camel@twins>
	<AANLkTimHGpRAZklIwXu6wEbA3coKXJvCVLxj2twerkCw@mail.gmail.com>
	<1274869262.5882.5222.camel@twins>
	<AANLkTik9LINPmabJfVi0jfVs5sjVS_1l00WpnVTFEuLV@mail.gmail.com>
	<1274890736.4467.574.camel@mulgrave.site>
	<1274891308.1674.1766.camel@laptop>
	<1274892847.4467.674.camel@mulgrave.site>
	<1274893228.1674.1772.camel@laptop>
	<1274894042.4467.727.camel@mulgrave.site>
	<20100526172824.GA9069@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100526172824.GA9069@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Greg KH <gregkh@suse.de>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Maxim@smtp1.linux-foundation.org, Matthew@smtp1.linux-foundation.org, Andi Kleen <ak@linux.intel.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Len Brown <len.brown@intel.com>, James Bottomley <James.Bottomley@suse.de>, Arve@smtp1.linux-foundation.org, Kernel@smtp1.linux-foundation.org, tytso@mit.edu, Dmitry Torokhov <dmitry.torokhov@gmail.com>, development list <linux-kernel@vger.kernel.org>, Pekka Enberg <penberg@cs.helsinki.fi>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 26 May 2010 19:28:24 +0200
Pavel Machek <pavel@ucw.cz> wrote:


> Besides that it is not linux system at all?

I believe the kernel to be a layer between userspace and hardware. What
business is it to the kernel if it runs whatever android
uses as init process or /bin/bash, sys-v-init or systemd?

There is this thing called choice. 

> 
> Yes, with custom userspace it works extremely nicely.
> 
> Had anyone even tried running oportunistic suspend on normal desktop?
> 									Pavel

I don't think this is a valid concern. Just because current linux/gnu
systems don't implement the userspace part of this interface doesn't
mean it is useless or broken. 

Cheers,
Flo

-- 
Just because I argue an issue, doesn't mean I agree with either side of
it.
