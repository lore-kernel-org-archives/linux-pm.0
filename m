From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] PM: Compress hibernation image with LZO
Date: Sun, 22 Aug 2010 21:29:14 +0200
Message-ID: <201008222129.14250.rjw@sisk.pl>
References: <1281407348.2618.52.camel@shrek.rexursive.com>
	<1282306269.3120.9.camel@shrek.rexursive.com>
	<201008210136.27065.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201008210136.27065.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Bojan Smojver <bojan@rexursive.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Saturday, August 21, 2010, Rafael J. Wysocki wrote:
> On Friday, August 20, 2010, Bojan Smojver wrote:
> > On Thu, 2010-08-19 at 19:49 +1000, Bojan Smojver wrote:
> > > Not tested, but here it is
> > 
> > This one is tested with both nocompress option passed to the kernel and
> > without. Only one minor change compared to the previous patch -
> > calculation in enough_swap() also takes into account the compress v.
> > nocompress.
> 
> OK, it generally looks good.

One more remark, though.

Since LZO compression is hardcoded into your code, perhaps you can rename
save_image_cmp() to save_image_lzo() (and analogously in the other places)?

Thanks,
Rafael
