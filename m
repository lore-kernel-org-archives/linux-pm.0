From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] PowerOP, PowerOP Core, 1/3
Date: Sat, 2 Sep 2006 18:41:43 -0700
Message-ID: <20060903014143.GA2481@kroah.com>
References: <44ECFC97.5060609@gmail.com> <20060825055643.GA24226@kroah.com>
	<44FA0E59.5070303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <44FA0E59.5070303@gmail.com>
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

On Sun, Sep 03, 2006 at 03:06:01AM +0400, Eugeny S. Mints wrote:
> Greg,
> =

> Greg KH wrote:
> >On Thu, Aug 24, 2006 at 05:10:47AM +0400, Eugeny S. Mints wrote:
> [snip]
> >>+struct powerop_point {
> >>+	struct kobject   kobj;   /* hook to reference an operating point in
> >>+				  * some arch independent way
> >>+				  */
> >
> >What do you do with this kobject?  It looks as if you only use the name
> >portion of it, which seems like a big waste of memory for a whole
> >kobject.
> >
> >It's also the first time I've seen a struct kobject abused this way :)
> >
> it is a shim for sysfs interface which is now implemented in the next tak=
e =

> of the patchset.

Ok, will now look.

> >>+static void *
> >>+create_point(const char *pwr_params, va_list args)
> >
> >Return types on the same line please.
> I ran lindent script and now return types locate in the same line. =

> Personally I'd prefer to have it as I put it since such type of coding =

> allows to search a function _implementation_ much simpler by "grep =

> ^function_name" and to distinguish implementation from function =

> declaration/forward declaration/calls and similar function names. Isn't i=
t =

> a purpose of coding style among others?

No, that's what ctags/cscope/whatever_you_like is for.  Copy the code
that Linus wrote in the core kernel to get the coding style correct.

> [snip]
> >>+struct powerop_driver {
> >>+	char *name;
> >>+	void *(*create_point)(const char *pwr_params, va_list args);
> >>+	int  (*set_point)(void *md_opt);
> >>+	int  (*get_point)(void *md_opt, const char *pwr_params, va_list =

> >>args);
> >>+};
> >
> >Module owner perhaps too?  You need to handle these drivers in modules
> >properly with the correct usage counting.
> Current design assumes only one powerop driver in the system and powerop =

> core
> checks pointers to the routines against NULL value before every call. =


What happens within the call to the module?  module unload happens then,
and _boom_.  You get to keep the pieces of your kernel...

Please, if you are going to call into ANY code in a module, merely
checking for NULL is good to make sure the call works, but you had
better lock down that code and keep it from being unloaded when you make
the call.  That is what the module reference counting logic is for.

> PowerOP core does not share any data with powerop driver so I don't
> see the reason to lock powerop driver in this case.

It's not a "data" issue, module reference counting has nothing to do
with data (many people get that incorrect.)  It's all about the
codepaths.

So, you use kobjects and the like to reference count your data, and
module reference counts on the code.  Hopefully the two interconnect
properly so you don't have data hanging around longer than the module...

Hope this helps,

greg k-h
