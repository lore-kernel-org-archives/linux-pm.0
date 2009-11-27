From: 640E9920 <640e9920@gmail.com>
Subject: Re: adding handles to pm_qos?
Date: Fri, 27 Nov 2009 09:23:59 -0800
Message-ID: <20091127172359.GA27524@mgross-laptop>
References: <000001ca4cf3$2a2da9c0$7e88fd40$@org>
	<20091023225304.GA32562@linux.intel.com>
	<000301ca5766$e671f870$b355e950$@org>
	<20091030145609.GA21256@linux.intel.com>
	<000001ca59cc$fc6999e0$f53ccda0$@org>
	<20091103202954.GA25275@linux.intel.com>
	<000001ca67eb$6cfee4e0$46fcaea0$@org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6658195501795430030=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <000001ca67eb$6cfee4e0$46fcaea0$@org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ai Li <aili@codeaurora.org>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


--===============6658195501795430030==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2009 at 06:06:56PM -0700, Ai Li wrote:
> Date: Tue, 17 Nov 2009 18:06:56 -0700
> From: Ai Li <aili@codeaurora.org>
> To: mgross@linux.intel.com
> Cc: linux-pm@lists.linux-foundation.org
> Subject: Re: [linux-pm] adding handles to pm_qos?
>=20
> > Thanks, I'll look at it over the next few days.
> >=20
> > --mgross
> >=20
> > > Here is the patch that I use with the test code.  There are
> > three new
> > > functions:
> > >
> > > void *pm_qos_get(int qos, char *name);
> > > int pm_qos_put(void *handle);
> > > int pm_qos_update_requirement_direct(void *handle, s32
> > new_value);
> > >
> > > In the test, I wanted to keep the existing interface intact so
> > I
> > > could compare them at the same time.  For the formal code
> > submission,
> > > a different approach may work better.
>=20
>=20
> Here is an alternate way of adding handles to pm_qos_params that I
> was alluding to.  This approach may be more preferable because it
> does not bloat the API and the handles become an integral part of
> pm_qos_params.  In my previous patch, handles are kind of bolted onto
> pm_qos_params and it needs separate calls (pm_qos_get, pm_qos_put) to
> acquire and release the handle.  In this patch,
> pm_qos_add_requirement and pm_qos_remove_requirement automatically
> take care of the handles.
>=20
>=20
> --- include/linux/pm_qos_params.h.orig
> +++ include/linux/pm_qos_params.h
> @@ -14,9 +14,11 @@
>  #define PM_QOS_NUM_CLASSES 4
>  #define PM_QOS_DEFAULT_VALUE -1
> =20
> -int pm_qos_add_requirement(int qos, char *name, s32 value);
> -int pm_qos_update_requirement(int qos, char *name, s32 new_value);
> -void pm_qos_remove_requirement(int qos, char *name);
> +struct requirement_list;
> +
> +struct requirement_list *pm_qos_add_requirement(int qos, char *name,
> s32 value);
> +int pm_qos_update_requirement(struct requirement_list *qos, s32
> new_value);
> +void pm_qos_remove_requirement(struct requirement_list *qos);
> =20
>  int pm_qos_requirement(int qos);
> =20
> --- kernel/pm_qos_params.c.orig
> +++ kernel/pm_qos_params.c
> @@ -49,6 +49,7 @@
>   */
>  struct requirement_list {
>  	struct list_head list;
> +	int pm_qos_class;
>  	union {
>  		s32 value;
>  		s32 usec;
> @@ -207,13 +208,16 @@ EXPORT_SYMBOL_GPL(pm_qos_requirement);
>   * performance characteristics.  It recomputes the aggregate QoS
> expectations
>   * for the pm_qos_class of parameters.
>   */
> -int pm_qos_add_requirement(int pm_qos_class, char *name, s32 value)
> +struct requirement_list *pm_qos_add_requirement(int pm_qos_class,
> char *name,

looks like your email client buggered the your patch.

mgross@mgross-laptop:~/marks/Linux/linux-2.6$ patch -p0 < /home/mgross/pm_q=
os_handle.patch
patching file include/linux/pm_qos_params.h
patch: **** malformed patch at line 43: s32 value);

Please resend=20

--mgross



> +		s32 value)
>  {
>  	struct requirement_list *dep;
>  	unsigned long flags;
> =20
>  	dep =3D kzalloc(sizeof(struct requirement_list), GFP_KERNEL);
>  	if (dep) {
> +		dep->pm_qos_class =3D pm_qos_class;
> +
>  		if (value =3D=3D PM_QOS_DEFAULT_VALUE)
>  			dep->value =3D
> pm_qos_array[pm_qos_class]->default_value;
>  		else
> @@ -228,48 +232,37 @@ int pm_qos_add_requirement(int pm_qos_class,
> char *name, s32 value)
>  		spin_unlock_irqrestore(&pm_qos_lock, flags);
>  		update_target(pm_qos_class);
> =20
> -		return 0;
> +		return dep;
>  	}
> =20
>  cleanup:
>  	kfree(dep);
> -	return -ENOMEM;
> +	return ERR_PTR(-ENOMEM);
>  }
>  EXPORT_SYMBOL_GPL(pm_qos_add_requirement);
> =20
>  /**
>   * pm_qos_update_requirement - modifies an existing qos request
> - * @pm_qos_class: identifies which list of qos request to us
> - * @name: identifies the request
> + * @qos: identifies the qos request to us
>   * @value: defines the qos request
>   *
> - * Updates an existing qos requirement for the pm_qos_class of
> parameters along
> + * Updates an existing qos requirement along
>   * with updating the target pm_qos_class value.
> - *
> - * If the named request isn't in the list then no change is made.
>   */
> -int pm_qos_update_requirement(int pm_qos_class, char *name, s32
> new_value)
> +int pm_qos_update_requirement(struct requirement_list *qos, s32
> new_value)
>  {
>  	unsigned long flags;
> -	struct requirement_list *node;
>  	int pending_update =3D 0;
> =20
>  	spin_lock_irqsave(&pm_qos_lock, flags);
> -	list_for_each_entry(node,
> -		&pm_qos_array[pm_qos_class]->requirements.list, list)
> {
> -		if (strcmp(node->name, name) =3D=3D 0) {
> -			if (new_value =3D=3D PM_QOS_DEFAULT_VALUE)
> -				node->value =3D
> -
> pm_qos_array[pm_qos_class]->default_value;
> -			else
> -				node->value =3D new_value;
> -			pending_update =3D 1;
> -			break;
> -		}
> -	}
> +	if (new_value =3D=3D PM_QOS_DEFAULT_VALUE)
> +		qos->value =3D
> pm_qos_array[qos->pm_qos_class]->default_value;
> +	else
> +		qos->value =3D new_value;
> +	pending_update =3D 1;
>  	spin_unlock_irqrestore(&pm_qos_lock, flags);
>  	if (pending_update)
> -		update_target(pm_qos_class);
> +		update_target(qos->pm_qos_class);
> =20
>  	return 0;
>  }
> @@ -277,32 +270,26 @@ EXPORT_SYMBOL_GPL(pm_qos_update_requirement);
> =20
>  /**
>   * pm_qos_remove_requirement - modifies an existing qos request
> - * @pm_qos_class: identifies which list of qos request to us
> + * @qos: identifies the qos request to us
>   * @name: identifies the request
>   *
> - * Will remove named qos request from pm_qos_class list of
> parameters and
> + * Will remove qos request from pm_qos_class list and
>   * recompute the current target value for the pm_qos_class.
>   */
> -void pm_qos_remove_requirement(int pm_qos_class, char *name)
> +void pm_qos_remove_requirement(struct requirement_list *qos)
>  {
>  	unsigned long flags;
> -	struct requirement_list *node;
>  	int pending_update =3D 0;
> =20
>  	spin_lock_irqsave(&pm_qos_lock, flags);
> -	list_for_each_entry(node,
> -		&pm_qos_array[pm_qos_class]->requirements.list, list)
> {
> -		if (strcmp(node->name, name) =3D=3D 0) {
> -			kfree(node->name);
> -			list_del(&node->list);
> -			kfree(node);
> -			pending_update =3D 1;
> -			break;
> -		}
> -	}
> +	list_del(&qos->list);
> +	pending_update =3D 1;
>  	spin_unlock_irqrestore(&pm_qos_lock, flags);
>  	if (pending_update)
> -		update_target(pm_qos_class);
> +		update_target(qos->pm_qos_class);
> +
> +	kfree(qos->name);
> +	kfree(qos);
>  }
>  EXPORT_SYMBOL_GPL(pm_qos_remove_requirement);
> =20
> @@ -345,37 +332,42 @@ int pm_qos_remove_notifier(int pm_qos_class,
> struct notifier_block *notifier)
>  EXPORT_SYMBOL_GPL(pm_qos_remove_notifier);
> =20
>  #define PID_NAME_LEN sizeof("process_1234567890")
> -static char name[PID_NAME_LEN];
> =20
>  static int pm_qos_power_open(struct inode *inode, struct file *filp)
>  {
>  	int ret;
>  	long pm_qos_class;
> +	char name[PID_NAME_LEN];
> +	struct requirement_list *qos;
> =20
>  	lock_kernel();
>  	pm_qos_class =3D find_pm_qos_object_by_minor(iminor(inode));
> -	if (pm_qos_class >=3D 0) {
> -		filp->private_data =3D (void *)pm_qos_class;
> -		sprintf(name, "process_%d", current->pid);
> -		ret =3D pm_qos_add_requirement(pm_qos_class, name,
> -					PM_QOS_DEFAULT_VALUE);
> -		if (ret >=3D 0) {
> -			unlock_kernel();
> -			return 0;
> -		}
> +	if (pm_qos_class < 0) {
> +		ret =3D -EPERM;
> +		goto power_open_exit;
>  	}
> -	unlock_kernel();
> =20
> -	return -EPERM;
> +	sprintf(name, "process_%d", current->pid);
> +	qos =3D pm_qos_add_requirement(pm_qos_class, name,
> PM_QOS_DEFAULT_VALUE);
> +	if (IS_ERR(qos)) {
> +		ret =3D PTR_ERR(qos);
> +		goto power_open_exit;
> +	}
> +
> +	filp->private_data =3D qos;
> +	ret =3D 0;
> +
> +power_open_exit:
> +	unlock_kernel();
> +	return ret;
>  }
> =20
>  static int pm_qos_power_release(struct inode *inode, struct file
> *filp)
>  {
> -	int pm_qos_class;
> +	struct requirement_list *qos;
> =20
> -	pm_qos_class =3D (long)filp->private_data;
> -	sprintf(name, "process_%d", current->pid);
> -	pm_qos_remove_requirement(pm_qos_class, name);
> +	qos =3D (struct requirement_list *)filp->private_data;
> +	pm_qos_remove_requirement(qos);
> =20
>  	return 0;
>  }
> @@ -384,15 +376,15 @@ static ssize_t pm_qos_power_write(struct file
> *filp, const char __user *buf,
>  		size_t count, loff_t *f_pos)
>  {
>  	s32 value;
> -	int pm_qos_class;
> +	struct requirement_list *qos;
> =20
> -	pm_qos_class =3D (long)filp->private_data;
>  	if (count !=3D sizeof(s32))
>  		return -EINVAL;
>  	if (copy_from_user(&value, buf, sizeof(s32)))
>  		return -EFAULT;
> -	sprintf(name, "process_%d", current->pid);
> -	pm_qos_update_requirement(pm_qos_class, name, value);
> +
> +	qos =3D (struct requirement_list *)filp->private_data;
> +	pm_qos_update_requirement(qos, value);
> =20
>  	return  sizeof(s32);
>  }
>=20
>=20
> ~Ai
>=20
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAksQCy8ACgkQhK5OsmQOmSAckACfeiwAN3ZhQtMaMHlhThU+KP65
cDwAn0lRUWp7DT1KbHb1OiB/gY0UfuUJ
=ULwf
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--

--===============6658195501795430030==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6658195501795430030==--
