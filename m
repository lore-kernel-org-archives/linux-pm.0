From: Pavel Machek <pavel@suse.cz>
Subject: Re: Powerop-core.patch
Date: Tue, 15 Aug 2006 16:30:40 +0000
Message-ID: <20060815163039.GE4032@ucw.cz>
References: <ca336d7d3b5ccf11a06a76d8a732fbea@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <ca336d7d3b5ccf11a06a76d8a732fbea@mvista.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: david singleton <dsingleton@mvista.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> Here is the core patch for the PowerOp concept.  It adds the powerop  =

> struct
> for opertaing point support to linux/pm.h and adds support to =

> transition to supported operating points by
> setting their name into /sys/power/state.
> =

> The supported operating points are shown in a readonly sysfs file,
> /sys/power/supported_states.

Could you fix the /sys interface to be value-per-file, and split it to
separate patch?

> -static const char * const pm_states[PM_SUSPEND_MAX] =3D {
> -       [PM_SUSPEND_STANDBY]    =3D "standby",
> -       [PM_SUSPEND_MEM]        =3D "mem",
> +static struct powerop standby =3D {
> +       .name =3D "standby",
> +       .description =3D "Power-On Suspend ACPI State: S1",
> +       .type =3D PM_SUSPEND_STANDBY,
> +};

You got the description fields wrong...

> +static struct powerop mem =3D {
> +       .name =3D "mem   ",
> +       .description =3D "Suspend-to-RAM ACPI State: S3",
> +       .type =3D PM_SUSPEND_MEM,
> +};

...for example mem is used on non-acpi machines, too. Plus, it is
useless.

> +#endif
> =

> -static inline int valid_state(suspend_state_t state)
> +/*
> + *
> + */
> +static int pm_change_state(struct powerop *state)

Eh?

> +       /*
> +        * list_find new operating point.
> +        * compare to current operating point.
> +        * if different change to new operating point.
> +        */
> +       list_for_each_entry_safe(this, next, head, list) {
> +               if (strncmp(state->name, this->name, len) =3D=3D 0) {
> +                       if ((strcmp(current_state->name, this->name)) =

> =3D=3D 0) {

Do we really need to do list search here?

> +                               return 0;
> +                       }

And please avoid {} around single return.

> +                       /*
> +                        * now lets wait for the transition latency
> +                        */
> +                       udelay(this->latency);

udelay in generic code seems wrong.

> @@ -211,7 +275,15 @@ static int enter_state(suspend_state_t s
>    */
>   int software_suspend(void)
>   {
> -       return enter_state(PM_SUSPEND_DISK);
> +       struct powerop *this, *next;
> +       struct list_head *head =3D &pm_states.list;
> +       int error =3D 0;
> +
> +       list_for_each_entry_safe(this, next, head, list) {
> +               if (this->type =3D=3D PM_SUSPEND_DISK)
> +                       error=3D enter_state(this);
> +       }
> +       return error;
>   }

Ugly....

> +struct powerop {
> +       struct list_head list;
> +       suspend_state_t type;
> +       char name[PM_NAME_SIZE];
> +       char description[PM_DESCRIPTION_SIZE];
> +       unsigned int frequency;         /* in KHz */
> +       unsigned int voltage;           /* mV */

having voltage/frequency/latency field for suspend-to-disk seems wrong.

-- =

Thanks for all the (sleeping) penguins.
