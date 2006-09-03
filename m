From: Greg KH <greg@kroah.com>
Subject: Re: PowerOP, Whatchanged/Issues/TODO 2/2
Date: Sat, 2 Sep 2006 18:42:23 -0700
Message-ID: <20060903014223.GB2481@kroah.com>
References: <44F9A031.8020203@gmail.com> <20060902183351.GC31197@kroah.com>
	<44FA0FFF.9020807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <44FA0FFF.9020807@gmail.com>
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

On Sun, Sep 03, 2006 at 03:13:03AM +0400, Eugeny S. Mints wrote:
> Greg,
> =

> Greg KH wrote:
> >On Sat, Sep 02, 2006 at 07:16:01PM +0400, Eugeny S. Mints wrote:
> >>whatchanged:
> >>- optional sysfs interface is added
> >>- code is moved under kernel/power
> >>- Greg's comments on kobject and coding style are addressed
> >>
> >>todo/issues:
> >>- better implementation for getting registered operating point names
> >>- move string parsing into powerop generic code
> >>- configfs for operating points creation from user space
> >
> >You forgot:
> >  - Handle module referencing counting issues.
> i'm discussing this and other issues you pointed out in a separate email.
> >
> >Also, no #ifdefs in the .c code please, that debugging stuff doesn't
> >have to look like that,
> do you mean CONFIG_POWEROP_SYSFS_OP_DEBUG_IF? Probably it's not a good na=
me =

> but it's not a debugging code. it could be CONFIG_POWEROP_SYSFS_OP_HW_IF =
- =

> this special HW point might be useful in a production code.

No matter what the name, the #ifdef does not belong in the .c code in
the manner like this was done.  Please move it.

thanks,

greg k-h
