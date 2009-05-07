From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/9] PM: suspend_block: Add driver to access
	suspend	blockers from user-space
Date: Thu, 7 May 2009 12:43:25 +0200
Message-ID: <20090507104325.GC6132@elf.ucw.cz>
References: <1241583529-5092-1-git-send-email-arve@android.com>
	<1241583529-5092-2-git-send-email-arve@android.com>
	<1241583529-5092-3-git-send-email-arve@android.com>
	<20090505201624.GH1379@ucw.cz>
	<d6200be20905061831o43df8558pdbc0b5284f8a8f20@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d6200be20905061831o43df8558pdbc0b5284f8a8f20@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve Hj?nnev?g <arve@android.com>
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed 2009-05-06 18:31:36, Arve Hj?nnev?g wrote:
> On Tue, May 5, 2009 at 1:16 PM, Pavel Machek <pavel@ucw.cz> wrote:
> > On Tue 2009-05-05 21:18:42, Arve Hj??nnev??g wrote:
> >> Add a misc device, "suspend_blocker", that allows user-space processes
> >> to block auto suspend. The device has ioctls to create a suspend_block=
er,
> >> and to block and unblock suspend. To delete the suspend_blocker, close
> >> the device.
> >>
> >
> >> +static int create_user_suspend_blocker(struct file *file, void __user=
 *name,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0size_t na=
me_len)
> >> +{
> >> + =A0 =A0 struct user_suspend_blocker *bl;
> >> + =A0 =A0 if (file->private_data)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> >> + =A0 =A0 bl =3D kzalloc(sizeof(*bl) + name_len + 1, GFP_KERNEL);
> > ...
> >> +static long user_suspend_blocker_ioctl(struct file *file, unsigned in=
t cmd,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned lon=
g _arg)
> >> +{
> >> + =A0 =A0 void __user *arg =3D (void __user *)_arg;
> >> + =A0 =A0 struct user_suspend_blocker *bl;
> >> + =A0 =A0 long ret;
> >> +
> >> + =A0 =A0 mutex_lock(&ioctl_lock);
> >> + =A0 =A0 if ((cmd & ~IOCSIZE_MASK) =3D=3D SUSPEND_BLOCKER_IOCTL_INIT(=
0)) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D create_user_suspend_blocker(file, ar=
g, _IOC_SIZE(cmd));
> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto done;
> >> + =A0 =A0 }
> >
> > Wait a moment, wtf is this? Not one ioctl but one ioctl per length of
> > string?!
> =

> This is not uncommon. _IOC encodes the size of the argument, and if
> this is not a fixed size, then the raw ioctl number change based on
> the size passed in. Look at input.h is you want other examples of
> this.

Ok, I found few examples in code:

pavel@amd:/data/l/linux$ grep -ri IOCSIZE_MASK .
./arch/alpha/include/asm/ioctl.h:#define IOCSIZE_MASK	(_IOC_SIZEMASK
<< _IOC_SIZESHIFT)
./arch/mips/include/asm/ioctl.h:#define IOCSIZE_MASK	(_IOC_SIZEMASK
<< _IOC_SIZESHIFT)
./arch/sparc/include/asm/ioctl.h:#define IOCSIZE_MASK
(_IOC_XSIZEMASK << _IOC_SIZESHIFT)
./drivers/input/joydev.c:		if ((cmd & ~IOCSIZE_MASK) =3D=3D
JSIOCGNAME(0)) {
./drivers/message/fusion/mptctl.c:	if ((cmd & ~IOCSIZE_MASK) =3D=3D
(MPTIOCINFO & ~IOCSIZE_MASK)) {
./drivers/message/fusion/mptctl.c:	else if ((cmd & ~IOCSIZE_MASK)
=3D=3D (HP_GETHOSTINFO & ~IOCSIZE_MASK))
./drivers/mtd/mtdchar.c:	size =3D (cmd & IOCSIZE_MASK) >>
IOCSIZE_SHIFT;
./drivers/pcmcia/pcmcia_ioctl.c:    size =3D (cmd & IOCSIZE_MASK) >>
IOCSIZE_SHIFT;
./include/asm-generic/ioctl.h:#define IOCSIZE_MASK	(_IOC_SIZEMASK
<< _IOC_SIZESHIFT)

I still do not like introducing 16000 ioctls, and I'm not sure how our
ioctl compatibility layer playes with this.
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
