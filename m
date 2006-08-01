From: "Vitaly Wool" <vitalywool@gmail.com>
Subject: Re: PowerOp Design and working patch
Date: Tue, 1 Aug 2006 23:28:53 +0400
Message-ID: <acd2a5930608011228m3a1ad869hddd8b8c523e9e3ff@mail.gmail.com>
References: <242d827d33807b6b46608a26ed29c273@mvista.com>
	<20060729004546.GA3917@kroah.com>
	<1c70fd37e4eb876295e0194e2b8725d6@mvista.com>
	<44CBB1E0.3030908@gmail.com>
	<62e4476a851bbed395b509023edc5c5c@mvista.com>
	<acd2a5930607300402n13890dbg150315f617c86ffd@mail.gmail.com>
	<b04f25ff9b3eb8a48cad52ee832d5bf2@mvista.com>
	<215c230e2979117fd14d83ea2fd83054@embeddedalley.com>
	<287a694aae15b3fba505f4381c95c9c8@mvista.com>
	<44CFA2F5.1070707@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <44CFA2F5.1070707@am.sony.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Tim Bird <tim.bird@am.sony.com>
Cc: David Singleton <daviado@gmail.com>, linux-pm@lists.osdl.org, david singleton <dsingleton@mvista.com>
List-Id: linux-pm@vger.kernel.org

On 8/1/06, Tim Bird <tim.bird@am.sony.com> wrote:
> david singleton wrote:
> > On Aug 1, 2006, at 3:09 AM, Matthew Locke wrote:
> >>Well, no one is suggesting a user define and install that info.
> >>Operating point creation will be done by someone who understands the
> >>system (system designer) regardless of the method used to get the
> >>operating points in the kernel.
> >
> > It sounds to me like they don't want to have to change kernel code and
> > recompile the kernel
> > to get a new operating point.
> >
> > It sounds like they are talking about a dynamic operating point as a
> > loadable
> > module, which would fit perfectly with the PowerOp scheme, since it's
> > the
> > system designer who would be creating the new  dynamic operating point,
> > not the user.
>
> Often, in the embedded world, the person defining the operating
> states will not be a kernel developer, and may not be comfortable
> with, or capable of, creating a kernel module.  (There are
> significant sections of the embedded space where modules are
> not used at all, and no module support is compiled into the
> kernel.)  In these cases, requiring loadable module support
> for runtime OPs would be a problem.

In my understanding, runtime OPs should be registered via configfs.
Modules with definitions are worse yet acceptable.

> > The point of PowerOp is that the system designer creates (and validates)
> > the operating points that the hardware vendor supports, not the user.
> >
> > A system designer creating a new operating point as a loadable
> > module would satisfy this requirement, and the user would not
> > be able to put the system into an undefined state, either by accident
> > or maliciously.
> >
>
> OK, I think I understand better your objection to user-space
> created operating points.   In embedded projects, it is often
> assumed that no one but the system designer has access to
> arbitrary user space programs.  Hence, it sometimes doesn't
> register that an end user could or would utilize a particular
> interface, just because it existed.

Well, why Unix allows root to do 'rm -rf'? It can put the system in an
undefined state... :P

Speaking seriously, if restrictions are comprehensive, then only
correct OPs will be created  run-time or whenever. And being able to
create OPs runtime is a very important requirement for PowerOP, for
many reasons.
