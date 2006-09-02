From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: Re: [PATCH] PowerOP, PowerOP Core, 1/3
Date: Sun, 03 Sep 2006 03:06:01 +0400
Message-ID: <44FA0E59.5070303@gmail.com>
References: <44ECFC97.5060609@gmail.com> <20060825055643.GA24226@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060825055643.GA24226@kroah.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Greg KH <greg@kroah.com>
Cc: pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Greg,

Greg KH wrote:
> On Thu, Aug 24, 2006 at 05:10:47AM +0400, Eugeny S. Mints wrote:
[snip]
>> +struct powerop_point {
>> +	struct kobject   kobj;   /* hook to reference an operating point in
>> +				  * some arch independent way
>> +				  */
> =

> What do you do with this kobject?  It looks as if you only use the name
> portion of it, which seems like a big waste of memory for a whole
> kobject.
> =

> It's also the first time I've seen a struct kobject abused this way :)
> =

it is a shim for sysfs interface which is now implemented in the next take =
of =

the patchset.
>> +static void *
>> +create_point(const char *pwr_params, va_list args)
> =

> Return types on the same line please.
I ran lindent script and now return types locate in the same line. Personal=
ly =

I'd prefer to have it as I put it since such type of coding allows to searc=
h a =

function _implementation_ much simpler by "grep ^function_name" and to =

distinguish implementation from function declaration/forward declaration/ca=
lls =

and similar function names. Isn't it a purpose of coding style among others?
[snip]
>> +struct powerop_driver {
>> +	char *name;
>> +	void *(*create_point)(const char *pwr_params, va_list args);
>> +	int  (*set_point)(void *md_opt);
>> +	int  (*get_point)(void *md_opt, const char *pwr_params, va_list args);
>> +};
> =

> Module owner perhaps too?  You need to handle these drivers in modules
> properly with the correct usage counting.
Current design assumes only one powerop driver in the system and powerop co=
re
checks pointers to the routines against NULL value before every call. Power=
OP
core does not share any data with powerop driver so I don't see the reason =
to lock
powerop driver in this case.

Eugeny
>> +
>> +int powerop_driver_register(struct powerop_driver *p);
>> +void powerop_driver_unregister(struct powerop_driver *p);
>> +
>> +/* Main PowerOP Core interface */
>> +
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
>> +int powerop_register_point(const char *id, const char *pwr_params, ...);
> =

> Again with the wierd documentation style.  Also, this does not belong in
> a .h file, kerneldoc can be generated from the .c files.  Please do it
> that way instead of duplicating it twice.
> =

> thanks,
> =

> greg k-h
> =
