From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] PowerOP, PowerOP Core, 1/3
Date: Thu, 24 Aug 2006 22:56:43 -0700
Message-ID: <20060825055643.GA24226@kroah.com>
References: <44ECFC97.5060609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <44ECFC97.5060609@gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Cc: pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 24, 2006 at 05:10:47AM +0400, Eugeny S. Mints wrote:
> +#include <linux/config.h>

Not needed anymore.

> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/errno.h>
> +#include <linux/powerop.h>
> +
> +#define POWEROP_MAX_OPT_NAME_LENGTH 32
> +
> +/* =

> + * FIXME: temporary limit. next implementation will handle unlimited num=
ber =

> + * of operating point
> + */

Trailing spaces.  Also in lots of other places in the patch, please
remove them.

> +#define POWEROP_MAX_OPT_NUMBER      20

No tabs :(

> +/* current number of registered operating points */
> +static int registered_opt_number;
> +
> +/* array of registered opereting point names */
> +static char *registered_names[POWEROP_MAX_OPT_NUMBER];
> +
> +/* notifications about an operating point registration/deregistration */
> +static BLOCKING_NOTIFIER_HEAD(powerop_notifier_list);
> +
> +struct powerop_point {
> +	struct kobject   kobj;   /* hook to reference an operating point in
> +				  * some arch independent way
> +				  */

What do you do with this kobject?  It looks as if you only use the name
portion of it, which seems like a big waste of memory for a whole
kobject.

It's also the first time I've seen a struct kobject abused this way :)

> +static void *
> +create_point(const char *pwr_params, va_list args)

Return types on the same line please.

> +{
> +	void *res;
> +
> +	down(&powerop_mutex);
> +	res =3D powerop_driver && powerop_driver->create_point ? =

> +	      powerop_driver->create_point(pwr_params, args) :
> +	      NULL;

We do have the "if" statement in C.  Please use it, you like this style
a lot, but it's very hard to read for the majority of people.

> +/*
> + * get_point - get value of specified power paramenter of operating =

> + * point pointed by 'md_opt'
> + *
> + * INPUT:
> + *   md_opt     - pointer to operating point to be processed or NULL to =
get
> + *                values of currently active operating point
> + *   pwr_params - name of requested power parameters
> + * =

> + * OUTPUT:
> + *   none
> + *
> + * INPUT/OUTPUT:
> + *   args - array of result placeholders =

> + *
> + * RETURN:
> + *   0 on success, error code otherwise
> + */

What's with the wierd comment style?  Either use kerneldoc, or nothing,
don't invent your own INPUT, OUTPUT, RETURN, etc, style please.

> +/* PowerOP Core public interface */
> +
> +int =

> +powerop_driver_register(struct powerop_driver *p)
> +{
> +	int error =3D 0;
> +
> +	if (! powerop_driver) {
> +		printk(KERN_INFO "PowerOP registering driver %s.\n", p->name);

That's pretty noisy.  Please make it a debugging thing only.

> +		powerop_driver =3D p;
> +
> +	} else
> +		error =3D -EBUSY;

If you set error =3D -EBUSY on the first line of the function, these two
lines can be dropped.

> +	return error;
> +}
> +
> +void =

> +powerop_driver_unregister(struct powerop_driver *p)
> +{
> +	if (powerop_driver =3D=3D p) {
> +		printk(KERN_INFO "PowerOP unregistering driver %s.\n", p->name);

Same noise comment.

> +		powerop_driver =3D NULL;
> +	}
> +}
> +
> +EXPORT_SYMBOL_GPL(powerop_driver_register);
> +EXPORT_SYMBOL_GPL(powerop_driver_unregister);

But these after the individual functions please.

> +struct powerop_driver {
> +	char *name;
> +	void *(*create_point)(const char *pwr_params, va_list args);
> +	int  (*set_point)(void *md_opt);
> +	int  (*get_point)(void *md_opt, const char *pwr_params, va_list args);
> +};

Module owner perhaps too?  You need to handle these drivers in modules
properly with the correct usage counting.

> +
> +int powerop_driver_register(struct powerop_driver *p);
> +void powerop_driver_unregister(struct powerop_driver *p);
> +
> +/* Main PowerOP Core interface */
> +
> +/* =

> + * powerop_register_point - add new operating point with a given name to
> + * operating points list. A caller passes power parameters for new opera=
ting
> + * points as pairs of name/value and passes only those parameter names t=
he
> + * caller is interested in. PowerOP Core calls powerop driver to initial=
ize
> + * arch dependent part of new operating point and links new named operat=
ing =

> + * point to the list maintained by PowerOP Core
> + * =

> + *
> + * INPUT
> + *   id         - operating point name
> + *   pwr_params - set of (power parameter name, value) pairs
> + *
> + * OUTPUT
> + *   none
> + *
> + * RETURN
> + *   zero on success, error code otherwise
> + *    =

> + */
> +int powerop_register_point(const char *id, const char *pwr_params, ...);

Again with the wierd documentation style.  Also, this does not belong in
a .h file, kerneldoc can be generated from the .c files.  Please do it
that way instead of duplicating it twice.

thanks,

greg k-h
