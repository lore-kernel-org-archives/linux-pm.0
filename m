From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: Re: [RFC] PowerOP, PowerOP Core 1/3
Date: Fri, 18 Aug 2006 02:23:22 +0400
Message-ID: <44E4EC5A.4090201@gmail.com>
References: <44D7EA4D.1020001@gmail.com> <20060815203756.GI4032@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060815203756.GI4032@ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@suse.cz>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Pavel Machek wrote:
> Hi!
>
>   =

>> diff --git a/drivers/Makefile b/drivers/Makefile
>> index fc2d744..f8eaf31 100644
>> --- a/drivers/Makefile
>> +++ b/drivers/Makefile
>> @@ -65,6 +65,7 @@ obj-$(CONFIG_ISDN)		+=3D isdn/
>>  obj-$(CONFIG_EDAC)		+=3D edac/
>>  obj-$(CONFIG_MCA)		+=3D mca/
>>  obj-$(CONFIG_EISA)		+=3D eisa/
>> +obj-$(CONFIG_POWEROP)		+=3D powerop/
>>     =

>
> Can we make it drivers/power? It is probably suitable for more than
> powerop.
>
>   =

>> +static int
>> +get_point(void *md_opt, const char *pwr_params, va_list args)
>> +{
>>     =

>
> Uhuh... is there a way to use something safer than unchecked va_list
> s?
>
>   =

please elaborate.
>   =

>> +int =

>> +powerop_driver_register(struct powerop_driver *p)
>> +{
>> +	int error =3D 0;
>> +
>> +	if (! powerop_driver) {
>>     =

>
> No space between ! and argument...
>
>   =

>> +/* =

>> + * powerop_register_point - add new operating point with a given name to
>> + * operating points list. A caller passes power parameters for new oper=
ating
>> + * points as pairs of name/value and passes only those parameter names =
the
>> + * caller is interested in. PowerOP Core calls powerop driver to initia=
lize
>> + * arch dependent part of new operating point and links new named opera=
ting =

>> + * point to the list maintained by PowerOP Core
>> + * =

>> + *
>> + * INPUT
>> + *   id         - operating point name
>> + *   pwr_params - set of (power parameter name, value) pairs
>> + *
>> + * OUTPUT
>> + *   none
>> + *
>> + * RETURN
>> + *   zero on success, error code otherwise
>> + *    =

>> + */
>> +int =

>> +powerop_register_point(const char *id, const char *pwr_params, ...)
>> +{
>> +	int err =3D 0;
>> +	struct powerop_point *opt;
>> +	va_list args;
>> +
>> +	if ((!powerop_initialized) || (id =3D=3D NULL))
>> +		return -EINVAL;
>> +
>> +	if ((opt =3D kmalloc(sizeof(struct powerop_point), GFP_KERNEL)) =3D=3D=
 NULL)
>> +		return -ENOMEM;
>> +
>> +	memset(opt, 0, sizeof(struct powerop_point));
>>     =

>
> kzalloc?
>
> Why do we want one more string parser in kernel?
>   =

referencing power parameters by name  interface is result of  gradual =

evolution of PowerOP interface mainly in order to address the =

requirement to be truly arch independent interface and to get rid of =

sharing an arch dependent data structures (a structure which defines =

operating point for a certain platform) between layers on top and =

beneath PowerOP (see the picture of the layers; thus a layer which =

creates operating points with help of PowerOP don't need to include arch =

dependent definition of operating point structure from PM Core layer). =

The latter fixes the overall PM architecture with OOP design concept.

Thanks,
Eugeny
> 							Pavel
>   =
