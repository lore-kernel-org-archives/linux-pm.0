From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: + rework-pm_ops-pm_disk_mode-kill-misuse.patch added
 to -mm tree
Date: Thu, 22 Mar 2007 01:56:14 -0800
Message-ID: <20070322015614.dafa1ed7.akpm@linux-foundation.org>
References: <200703212334.l2LNYDjj007030@shell0.pdx.osdl.net>
	<20070322094825.GA29627@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070322094825.GA29627@flint.arm.linux.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: pavel@ucw.cz, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 22 Mar 2007 09:48:26 +0000 Russell King <rmk@arm.linux.org.uk> wrot=
e:

> On Wed, Mar 21, 2007 at 04:34:13PM -0700, akpm@linux-foundation.org wrote:
> > It also removes all the arm and sh users that think they can veto suspe=
nd to
> > disk via pm_ops; not so since the user can always do echo shutdown >
> > /sys/power/disk, they need to find a better way involving Kconfig or su=
ch.
> =

> NAK.  There are ARM platforms where suspend to disk doesn't make any
> sense what so ever.

So they shouldn't offer it in Kconfig?
