From: David Zeuthen <davidz-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: suspend/resume uevents [was Re: Introducing HAL
	userspace power management]
Date: Fri, 11 Mar 2005 10:52:03 -0500
Message-ID: <1110556324.4203.7.camel@daxter.boston.redhat.com>
References: <Pine.LNX.4.44L0.0503071125001.1378-100000@ida.rowland.org>
	<1110411138.7779.86.camel@daxter.boston.redhat.com>
	<20050309233556.GO17034@elf.ucw.cz>
	<1110426926.3443.3.camel@daxter.boston.redhat.com>
	<20050310095629.GA13444@elf.ucw.cz>
	<1110476278.3404.60.camel@daxter.boston.redhat.com>
	<20050310211320.GG632@openzaurus.ucw.cz>
	<1110490939.3404.84.camel@daxter.boston.redhat.com>
	<20050310230745.GC10954@elf.ucw.cz>
	<1110518935.4512.14.camel@daxter.boston.redhat.com>
	<1110525158.12485.178.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============45969622496972429=="
In-Reply-To: <1110525158.12485.178.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Adam Belay <abelay-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>
Cc: linux-pm <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, seife-l3A5Bk7waGM@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--===============45969622496972429==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-03-11 at 02:12 -0500, Adam Belay wrote:
> > Maybe I'm reading the source wrong, but isn't it the case that some
> > laptops using APM (my IBM thinkpad T41 with acpi=off for instance)
> > suspends without user space interaction when the lid is closed, thus
> > rendering it impossible to send the event from user space? 
> > 
> > One may even ask whether it's sound to assume that all architectures
> > will be suspended via user space?
> > 
> > <snip>
> 
> I would consider this to be an exception.  APM has been obsolete for
> years.  Our focus (for those platforms where it is available) should be
> with ACPI on.
> 

Except that quite a few laptop users (it's getting fewer thankfully,
since ACPI support is getting better all the time) currently are forced
to use APM if they want their laptop to actually suspend.

Cheers,
David



--===============45969622496972429==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

_______________________________________________
linux-pm mailing list
linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
http://lists.osdl.org/mailman/listinfo/linux-pm

--===============45969622496972429==--
