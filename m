From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/8] PM: suspend_block: Add driver to access
	suspend blockers from user-space
Date: Thu, 29 Apr 2010 23:11:27 +0200
Message-ID: <201004292311.27400.rjw@sisk.pl>
References: <1272429119-12103-1-git-send-email-arve@android.com>
	<201004290105.15707.rjw@sisk.pl>
	<h2jd6200be21004281638y6b751abesfcf6416707e6fee4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <h2jd6200be21004281638y6b751abesfcf6416707e6fee4@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: Len Brown <len.brown@intel.com>, Jim Collar <jim.collar@eqware.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Avi Kivity <avi@redhat.com>, Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>, Tejun Heo <tj@kernel.org>, Magnus Damm <damm@igel.co.jp>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 29 April 2010, Arve Hj=F8nnev=E5g wrote:
> 2010/4/28 Rafael J. Wysocki <rjw@sisk.pl>:
> > On Thursday 29 April 2010, Arve Hj=F8nnev=E5g wrote:
> >> 2010/4/28 Rafael J. Wysocki <rjw@sisk.pl>:
> >> > On Wednesday 28 April 2010, Arve Hj=F8nnev=E5g wrote:
> >> >> Add a misc device, "suspend_blocker", that allows user-space proces=
ses
> >> >> to block auto suspend. The device has ioctls to create a suspend_bl=
ocker,
> >> >> and to block and unblock suspend. To delete the suspend_blocker, cl=
ose
> >> >> the device.
> >> >>
> >> >> Signed-off-by: Arve Hj=F8nnev=E5g <arve@android.com>
> >> > ...
> >> >> +
> >> >> +#include <linux/fs.h>
> >> >> +#include <linux/miscdevice.h>
> >> >> +#include <linux/module.h>
> >> >> +#include <linux/uaccess.h>
> >> >> +#include <linux/slab.h>
> >> >> +#include <linux/suspend_blocker.h>
> >> >> +#include <linux/suspend_block_dev.h>
> >> >> +
> >> >> +enum {
> >> >> +     DEBUG_FAILURE   =3D BIT(0),
> >> >> +};
> >> >> +static int debug_mask =3D DEBUG_FAILURE;
> >> >
> >> > What's the exact purpose of this?
> >>
> >> To show errors returned to user space. I can turn it off by default if=
 you want.
> >
> > Not necessarily, but why is it a mask?  It looks like a 0/1 thing would=
 be
> > sufficient.
> =

> I may want to add a bit to print all user-space block and unblock calls.

Alternatively, you can add a new parameter for that, which I think I would =
prefer.

Rafael
