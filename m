From: Greg KH <greg@kroah.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Mon, 21 Aug 2006 19:13:05 -0700
Message-ID: <20060822021305.GB22565@kroah.com>
References: <20060814200735.GC14099@kroah.com>
	<c948ef9077556626e85291ad716b7ddb@nomadgs.com>
	<20060814224623.GH30814@redhat.com>
	<221e3d51950d20642b3655617527dc52@nomadgs.com>
	<20060814234801.GK30814@redhat.com>
	<20060815010020.GA14251@kroah.com>
	<b324b5ad0608182310v348f8936j527357e60c3a77bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <b324b5ad0608182310v348f8936j527357e60c3a77bb@mail.gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Singleton <daviado@gmail.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 18, 2006 at 11:10:02PM -0700, David Singleton wrote:
>                Oppoint could replace large pieces of the cpufreq code
>        in the kernel, most notably the policy and governor code, which I
>        believe belongs in user space in the power manager daemon.
>
>                You'll notice that the oppoint-cpufreq.patch only touches
>        two files, cpufreq.c and cpufreq.h. It only creates two new =

>        interfaces
>        to the cpufreq frequency scaling notifier lists to support driver =
pre
>        and post scaling routines, already supported in the kernel.
> =

>                The oppoint-x86-centrino.patch completes the replacement
>        of cpufreq code by introducing the transition routine to
>        change frequencies and creates operating points for the
>        centrino-speedstep processors already supported by Linux.
> =

>        (although I've recieved a note from Intel that the data I've copied
>        from the centrino-speedstep cpufreq tables is known to be inaccura=
te
>        and unsupported)
> =

>                This code could replace cpufreq code and simplify it quite=
 a
>        bit in the process.  The kernel drivers that support cpufreq =

>        frequency
>        scaling would not have to be changed.  Operating points for the re=
st
>        of the processors that support cpufreq would have to be created, b=
ut
>        as you can see it's quite a straight forward transformation from
>        a cpufreq table to a set of operating points for a processor.

This only touches on the cpu frequency stuff.  I am assuming that the
current driver interface to the different power management states is
acceptable to you?

thanks,

greg k-h
