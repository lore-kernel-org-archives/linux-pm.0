From: Adam Belay <abelay@novell.com>
Subject: Re: Re: [RFC] Driver States
Date: Wed, 06 Apr 2005 15:51:12 -0400
Message-ID: <1112817072.8517.15.camel@linux.site>
References: <1111963367.3503.152.camel@localhost.localdomain>
	<Pine.LNX.4.50.0503292155120.26543-100000@monsoon.he.net>
	<1112222717.3503.213.camel@localhost.localdomain>
	<20050405092423.GA7254@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============84000468335349576=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050405092423.GA7254@elf.ucw.cz>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============84000468335349576==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2005-04-05 at 11:24 +0200, Pavel Machek wrote:
> Hi!
> 
> > > You have a few things here that can easily conflict, and that will be
> > > developed at different paces. I like the direction that it's going, but
> > > how do you intend to do it gradually. I.e. what to do first?
> > 
> > I think the first step would be for us to all agree on a design, whether
> > it be this one or another, so we can began planning for long term
> > changes.
> > 
> > My arguments for these changes are as follows:
> 
> 0. I do not see how to gradually roll this in.
> 
> >      4. Having responsibilities at each driver level encourages a
> >         layered and object based design, reducing code duplication and
> >         complexity.
> 
> Unfortunately, you'll be retrofiting this to existing drivers. AFAICS,
> trying to force existing driver to "layered and object based design"
> can only result in mess.
> 								Pavel

Fair enough.  How does this sound?  I'd like to add "*attach" and
"*detach" to "struct device_driver".  These functions would act as one
time initializers and decontructors.  Then we could rename "*probe" to
"*start", and "*remove" to "*stop", which should be rather trivial to
fix up.  From there drivers could slowly be converted to use "*attach"
and "*detach", but will not be broken along the way.

So the basic flow would be like this:

1.) a driver is bound to a device
2.) *attach is called to allocate data structures
3.) *start when it's time to probe the device
4.) *stop when the user disables the device
5.) repeat steps 3 and 4 any number of times
6.) *detach is called when unbinding the driver

The driver layering stuff could come later, but just implementing these
specific components would have immediate benefits.

In this early stage in development, I'd like to at least be able to
start and stop drivers for reasons outside of power management (ex. user
preference or resource re-balancing).  If a "*resume" function can also
utilize this functionality, then all the better.

Thanks,
Adam



--===============84000468335349576==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============84000468335349576==--
