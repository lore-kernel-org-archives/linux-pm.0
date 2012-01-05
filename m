From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] PM: HIBERNATION: skip the swap size check
 if the snapshot image size is anticipative
Date: Thu, 5 Jan 2012 19:46:05 +0100
Message-ID: <20120105184604.GA11065__45434.8134612248$1325789731$gmane$org@atrey.karlin.mff.cuni.cz>
References: <1322208422-12346-1-git-send-email-Barry.Song@csr.com>
	<CAGsJ_4ziRj1oEhmMYjc6yJvS2FHYn+uRWmSaggnJQQjqi=B6gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAGsJ_4ziRj1oEhmMYjc6yJvS2FHYn+uRWmSaggnJQQjqi=B6gw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Barry Song <21cnbao@gmail.com>
Cc: Xiangzhen Ye <Xiangzhen.Ye@csr.com>, linux-kernel@vger.kernel.org, workgroup.linux@csr.com, linux-arm-kernel@lists.infradead.org, Barry Song <Baohua.Song@csr.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

Is the check even useful these days? Should we remove it altogether?

       	     	  	       	     	       Pavel


> Pavel ,Rafael, any feedback?
> -barry
> =

> 2011/11/25 Barry Song <Barry.Song@csr.com>:
> > From: Barry Song <baohua.song@csr.com>
> >
> > Current swsusp requires swap partitions even larger than real saved pag=
es
> > based on the worst compression ratio:
> > but for an embedded system, which has limited storage space, then it mi=
ght
> > can't give the large partition to save snapshot.
> > In the another way, some embedded systems can definitely know the most =
size
> > needed for snapshot since they run some specific application lists.
> > So this patch provides the possibility for users to tell kernel even
> > the system has a little snapshot partition, but it is still enough.
> > For example, if the system need to save 120MB memory, origin swsusp wil=
l require
> > a 130MB partition to save snapshot. but if users know 30MB is enough fo=
r them(
> > compressed image will be less than 30MB), they just make a 30MB partiti=
on by
> > echo 0 > /sys/power/check_swap_size
> >
> > Signed-off-by: Barry Song <Baohua.Song@csr.com>
> > Cc: Xiangzhen Ye <Xiangzhen.Ye@csr.com>
> > ---
> > =A0-v2:drop swap_enough bootargs and use /sys/power/check_swap_size node
> >
> > =A0Documentation/power/interface.txt | =A0 =A05 +++++
> > =A0kernel/power/hibernate.c =A0 =A0 =A0 =A0 =A0| =A0 22 +++++++++++++++=
+++++++
> > =A0kernel/power/power.h =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 ++
> > =A0kernel/power/swap.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A09 +++++++++
> > =A04 files changed, 38 insertions(+), 0 deletions(-)
> >
> > diff --git a/Documentation/power/interface.txt b/Documentation/power/in=
terface.txt
> > index c537834..5e205f0 100644
> > --- a/Documentation/power/interface.txt
> > +++ b/Documentation/power/interface.txt
> > @@ -47,6 +47,11 @@ Writing to this file will accept one of
> > =A0 =A0 =A0 =A0'testproc'
> > =A0 =A0 =A0 =A0'test'
> >
> > +/sys/power/check_swap_size controls whether we can skip checking the s=
wap
> > +partition size by worst compression ratio. If users know the swap part=
ition
> > +is enough for compressed snapshot, write 0 to /sys/power/check_swap_si=
ze.
> > +It is useful for an embedded system with known running softwares.
> > +
> > =A0/sys/power/image_size controls the size of the image created by
> > =A0the suspend-to-disk mechanism. =A0It can be written a string
> > =A0representing a non-negative integer that will be used as an upper
> > diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> > index 1c53f7f..5552473 100644
> > --- a/kernel/power/hibernate.c
> > +++ b/kernel/power/hibernate.c
> > @@ -1024,11 +1024,33 @@ static ssize_t reserved_size_store(struct kobje=
ct *kobj,
> >
> > =A0power_attr(reserved_size);
> >
> > +static ssize_t check_swap_size_show(struct kobject *kobj, struct kobj_=
attribute *attr,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0char *buf)
> > +{
> > + =A0 =A0 =A0 return sprintf(buf, "%d\n", check_swap_size);
> > +}
> > +
> > +static ssize_t check_swap_size_store(struct kobject *kobj, struct kobj=
_attribute *attr,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const cha=
r *buf, size_t n)
> > +{
> > + =A0 =A0 =A0 int check_size;
> > +
> > + =A0 =A0 =A0 if (sscanf(buf, "%d", &check_size) =3D=3D 1) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 check_swap_size =3D check_size;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return n;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 return -EINVAL;
> > +}
> > +
> > +power_attr(check_swap_size);
> > +
> > =A0static struct attribute * g[] =3D {
> > =A0 =A0 =A0 =A0&disk_attr.attr,
> > =A0 =A0 =A0 =A0&resume_attr.attr,
> > =A0 =A0 =A0 =A0&image_size_attr.attr,
> > =A0 =A0 =A0 =A0&reserved_size_attr.attr,
> > + =A0 =A0 =A0 &check_swap_size_attr.attr,
> > =A0 =A0 =A0 =A0NULL,
> > =A0};
> >
> > diff --git a/kernel/power/power.h b/kernel/power/power.h
> > index 23a2db1..4f0fa78 100644
> > --- a/kernel/power/power.h
> > +++ b/kernel/power/power.h
> > @@ -74,6 +74,8 @@ static struct kobj_attribute _name##_attr =3D { \
> >
> > =A0/* Preferred image size in bytes (default 500 MB) */
> > =A0extern unsigned long image_size;
> > +/* If 0, skip checking whether the swap size is enough for compressed =
snapshot */
> > +extern int check_swap_size;
> > =A0/* Size of memory reserved for drivers (default SPARE_PAGES x PAGE_S=
IZE) */
> > =A0extern unsigned long reserved_size;
> > =A0extern int in_suspend;
> > diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> > index 11a594c..db90195 100644
> > --- a/kernel/power/swap.c
> > +++ b/kernel/power/swap.c
> > @@ -37,6 +37,12 @@
> > =A0#define HIBERNATE_SIG =A0"S1SUSPEND"
> >
> > =A0/*
> > + * if users know swap partitions are enough for compressed snapshots,
> > + * echo 0 > /sys/power/check_swap_size
> > + */
> > +int check_swap_size =3D 1;
> > +
> > +/*
> > =A0* =A0 =A0 The swap map is a data structure used for keeping track of=
 each page
> > =A0* =A0 =A0 written to a swap partition. =A0It consists of many swap_m=
ap_page
> > =A0* =A0 =A0 structures that contain each an array of MAP_PAGE_ENTRIES =
swap entries.
> > @@ -772,6 +778,9 @@ static int enough_swap(unsigned int nr_pages, unsig=
ned int flags)
> > =A0 =A0 =A0 =A0unsigned int free_swap =3D count_swap_pages(root_swap, 1=
);
> > =A0 =A0 =A0 =A0unsigned int required;
> >
> > + =A0 =A0 =A0 if (!check_swap_size)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> > +
> > =A0 =A0 =A0 =A0pr_debug("PM: Free swap pages: %u\n", free_swap);
> >
> > =A0 =A0 =A0 =A0required =3D PAGES_FOR_IO + ((flags & SF_NOCOMPRESS_MODE=
) ?
> > --
> > 1.7.1

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
