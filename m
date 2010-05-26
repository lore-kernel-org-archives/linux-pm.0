From: Florian Mickler <florian@mickler.org>
Subject: Re: [PATCH 2/8] PM: suspend_block: Add driver to access
 suspend blockers from user-space
Date: Wed, 26 May 2010 12:51:36 +0200
Message-ID: <20100526125136.53f2dc82__10905.6478635923$1274871350$gmane$org@schatten.dmk.lab>
References: <1274482015-30899-1-git-send-email-arve@android.com>
	<1274482015-30899-2-git-send-email-arve@android.com>
	<1274482015-30899-3-git-send-email-arve@android.com>
	<1274863428.5882.4860.camel@twins>
	<AANLkTimTnzK1ByG2bE2gGjINxD_Pbvez7PFHo7Kzo9yk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTimTnzK1ByG2bE2gGjINxD_Pbvez7PFHo7Kzo9yk@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?ISO-8859-15?B?SGr4bm5lduVn?= <arve@android.com>
Cc: Len Brown <len.brown@intel.com>, Jim Collar <jim.collar@eqware.net>, Peter Zijlstra <peterz@infradead.org>, Nigel@smtp1.linux-foundation.org, Kroah-Hartman <gregkh@suse.de>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew@smtp1.linux-foundation.org, Greg@smtp1.linux-foundation.org, Avi Kivity <avi@redhat.com>, Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>, Magnus Damm <damm@igel.co.jp>, linux-pm@lists.linux-foundation.org, Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 26 May 2010 03:47:27 -0700
Arve Hj=F8nnev=E5g <arve@android.com> wrote:

> 2010/5/26 Peter Zijlstra <peterz@infradead.org>:
> > On Fri, 2010-05-21 at 15:46 -0700, Arve Hj=F8nnev=E5g wrote:
> >> +To create a suspend blocker from user space, open the suspend_blocker
> >> special
> >> +device file:
> >> +
> >> + =A0 =A0fd =3D open("/dev/suspend_blocker", O_RDWR | O_CLOEXEC);
> >> +
> >> +then optionally call:
> >> +
> >> + =A0 =A0ioctl(fd, SUSPEND_BLOCKER_IOCTL_SET_NAME(strlen(name)), name);
> >> +
> >> +To activate the suspend blocker call:
> >> +
> >> + =A0 =A0ioctl(fd, SUSPEND_BLOCKER_IOCTL_BLOCK);
> >> +
> >> +To deactivate it call:
> >> +
> >> + =A0 =A0ioctl(fd, SUSPEND_BLOCKER_IOCTL_UNBLOCK);
> >> +
> >> +To destroy the suspend blocker, close the device:
> >> +
> >> + =A0 =A0close(fd);
> >
> > Urgh, please let the open() be BLOCK, the close() be UNBLOCK, and keep
> > the SET_NAME thing if you really care.
> >
> =

> That would be very inefficient.
> =


Also I think it is intended to enforce named suspend blockers. (For
debugging/accounting purposes).

Cheers,
Flo
