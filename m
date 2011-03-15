From: Shriram Rajagopalan <rshriram@cs.ubc.ca>
Subject: Re: [PATCH v3 4/5] PM: Add visible HIBERNATION_INTERFACE
	and hide HIBERNATION
Date: Tue, 15 Mar 2011 14:25:47 -0700
Message-ID: <AANLkTi=a3Pk-L3J0_i9eh=WDLWZKKOF4WnvaK16DzGz-__23806.4062236392$1300224582$gmane$org@mail.gmail.com>
References: <1299906471-31011-1-git-send-email-rshriram@cs.ubc.ca>
Reply-To: rshriram@cs.ubc.ca
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1299906471-31011-1-git-send-email-rshriram@cs.ubc.ca>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: rjw@sisk.pl
Cc: Shriram Rajagopalan <rshriram@cs.ubc.ca>, linux-pm@lists.linux-foundation.org, xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 11, 2011 at 9:07 PM, Shriram Rajagopalan <rshriram@cs.ubc.ca> w=
rote:
> HIBERNATION covers the main hibernation control code and freeze-thaw
> pm events, that xen's save/restore also uses. Explicitly enabling
> an independant hibernation functionality to enable xen's save/restore
> is a bit ugly. Define a new user visible symbol HIBERNATION_INTERFACE
> that "selects" HIBERNATION and covers the main hibernation control code
> instead of HIBERNATION. This way, we can also make XEN_SAVE_RESTORE
> "select" HIBERNATION, enabling only the freeze-thaw code.
>
> Signed-off-by: Shriram Rajagopalan <rshriram@cs.ubc.ca>
> ---
> =A0kernel/power/Kconfig =A0 =A0 | =A0 =A09 +++++++--
> =A0kernel/power/hibernate.c | =A0 =A04 ++++
> =A0kernel/power/main.c =A0 =A0 =A0| =A0 =A02 +-
> =A0kernel/power/user.c =A0 =A0 =A0| =A0 =A02 ++
> =A04 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 4603f08..493c678 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -19,10 +19,15 @@ config SUSPEND_FREEZER
> =A0 =A0 =A0 =A0 =A0Turning OFF this setting is NOT recommended! If in dou=
bt, say Y.
>
> =A0config HIBERNATION
> - =A0 =A0 =A0 bool "Hibernation (aka 'suspend to disk')"
> - =A0 =A0 =A0 depends on SWAP && ARCH_HIBERNATION_POSSIBLE
> + =A0 =A0 =A0 def_bool n
> + =A0 =A0 =A0 depends on ARCH_HIBERNATION_POSSIBLE
> =A0 =A0 =A0 =A0select LZO_COMPRESS
> =A0 =A0 =A0 =A0select LZO_DECOMPRESS
> +
> +config HIBERNATION_INTERFACE
> + =A0 =A0 =A0 bool "Hibernation (aka 'suspend to disk')"
> + =A0 =A0 =A0 depends on SWAP
> + =A0 =A0 =A0 select HIBERNATION
> =A0 =A0 =A0 =A0---help---
> =A0 =A0 =A0 =A0 =A0Enable the suspend to disk (STD) functionality, which =
is usually
> =A0 =A0 =A0 =A0 =A0called "hibernation" in user interfaces. =A0STD checkp=
oints the
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 1832bd2..13bcf69 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -592,6 +592,7 @@ static int prepare_processes(void)
> =A0* =A0 =A0 hibernate - The granpappy of the built-in hibernation manage=
ment
> =A0*/
>
> +#ifdef CONFIG_HIBERNATION_INTERFACE
> =A0int hibernate(void)
> =A0{
> =A0 =A0 =A0 =A0int error;
> @@ -667,6 +668,8 @@ int hibernate(void)
> =A0 =A0 =A0 =A0return error;
> =A0}
>
> +#else /* !CONFIG_HIBERNATION_INTERFACE */
> +int hibernate(void) { return -ENOSYS; }
>
> =A0/**
> =A0* =A0 =A0 software_resume - Resume from a saved image.
> @@ -1029,3 +1032,4 @@ __setup("noresume", noresume_setup);
> =A0__setup("resume_offset=3D", resume_offset_setup);
> =A0__setup("resume=3D", resume_setup);
> =A0__setup("hibernate=3D", hibernate_setup);
> +#endif /* !CONFIG_HIBERNATION_INTERFACE */
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 8eaba5f..686a130 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -156,7 +156,7 @@ static ssize_t state_show(struct kobject *kobj, struc=
t kobj_attribute *attr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s +=3D sprintf(s,"%s ", pm=
_states[i]);
> =A0 =A0 =A0 =A0}
> =A0#endif
> -#ifdef CONFIG_HIBERNATION
> +#ifdef CONFIG_HIBERNATION_INTERFACE
> =A0 =A0 =A0 =A0s +=3D sprintf(s, "%s\n", "disk");
> =A0#else
> =A0 =A0 =A0 =A0if (s !=3D buf)
> diff --git a/kernel/power/user.c b/kernel/power/user.c
> index c36c3b9..5f36ee7 100644
> --- a/kernel/power/user.c
> +++ b/kernel/power/user.c
> @@ -458,6 +458,7 @@ static long snapshot_ioctl(struct file *filp, unsigne=
d int cmd,
> =A0 =A0 =A0 =A0return error;
> =A0}
>
> +#ifdef CONFIG_HIBERNATION_INTERFACE
> =A0static const struct file_operations snapshot_fops =3D {
> =A0 =A0 =A0 =A0.open =3D snapshot_open,
> =A0 =A0 =A0 =A0.release =3D snapshot_release,
> @@ -479,3 +480,4 @@ static int __init snapshot_device_init(void)
> =A0};
>
> =A0device_initcall(snapshot_device_init);
> +#endif /* CONFIG_HIBERNATION_INTERFACE */
> --
> 1.7.0.4
>
>

Rafael, do you have any objections to this patch?

As discussed earlier
http://lists.xensource.com/archives/html/xen-devel/2011-03/msg00267.html
these patches are against a merged tree (your linux-next and stefano's
linux-next).
Konrad would pull this tree into his branch and push it in the end
(after your & stefano's trees
have gone in).

Alternatively, if you would like to carry patches 3/5 and 4/5 directly
in your tree, then the other
patches could go into the xen tree.

shriram
