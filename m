From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Regression in 3.10] Garbage displayed after resume on Acer
	Aspire S5
Date: Sun, 07 Jul 2013 01:36:15 +0200
Message-ID: <14306109.Kf2NcaamIl@vostro.rjw.lan>
References: <1511667.B4N0cEgdH9@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <1511667.B4N0cEgdH9@vostro.rjw.lan>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
Errors-To: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
To: intel-gfx@lists.freedesktop.org, Chris Wilson <chris@chris-wilson.co.uk>
Cc: =?ISO-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>, LKML <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, July 06, 2013 03:59:49 PM Rafael J. Wysocki wrote:
> Hi,
> 
> I've just started to play with a new Acer Aspire S5 test box and noticed that
> garbage is displayed after resume from suspend to RAM with the 3.10 kernel
> (under KDE 4.10.3 on openSUSE 12.3).  The display corruption goes away after
> killing X and restarting it.
> 
> The CPU is a Core i5-3317U (Ivy Bridge), i915 graphics.
> 
> That doesn't happen with 3.9 (same config otherwise).  It also doesn't happen
> with my older Sandy Bridge-based box (with 3.10), so I suspect Ivy Bridge
> specifics.
> 
> Is this known?  Do you want me to bisect?

Most likely, this has been introduced by this commit:

commit 19b2dbde5732170a03bd82cc8bd442cf88d856f7
Author: Chris Wilson <chris@chris-wilson.co.uk>
Date:   Wed Jun 12 10:15:12 2013 +0100

    drm/i915: Restore fences after resume and GPU resets

At least I'm not able to reproduce it with that commit reverted.  With that
commit in I was able to reproduce it quite readily on machines with Ivy Bridge
and Sandy Bridge processors.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
