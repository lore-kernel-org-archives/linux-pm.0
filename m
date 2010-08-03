From: Raj Kumar <rajkumar278@hotmail.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Tue, 3 Aug 2010 17:56:51 +0530
Message-ID: <BLU102-W27964047CD70AACE5A24C9EBAE0@phx.gbl>
References: <20100731175841.GA9367@linux.vnet.ibm.com>,
	<20100731215214.2543c07e@infradead.org>,
	<20100801054816.GI2470@linux.vnet.ibm.com>,
	<20100731230101.7cc1d8c7@infradead.org>,
	<20100801191228.GL2470@linux.vnet.ibm.com>,
	<20100801154708.19817b75@infradead.org>,
	<20100802011006.GS2470@linux.vnet.ibm.com>,
	<AANLkTi=a-1hn_oL=i-=RKK9xOur+4mQjTRut+aiXtYkE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6063476372022321493=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTi=a-1hn_oL=i-=RKK9xOur+4mQjTRut+aiXtYkE@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: arve@android.com, stern@rowland.harvard.edu
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

--===============6063476372022321493==
Content-Type: multipart/alternative;
	boundary="_aca1dea6-bfb4-4b67-afc5-9c1baadbb210_"

--_aca1dea6-bfb4-4b67-afc5-9c1baadbb210_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


=20

Hi Arve and Alan=2C

=20

I have some questions regarding the Android early suspend and ACPI that are=
 as follows:

=20

1) If i see the early suspend features which is for android=2C it is if the=
 user presses power off

the button and on button for late resumes. The question is if there is mobi=
le platform=2C

then when user presses power off button=2C will the early suspend handlers =
will be called

at that time?=20

what usecase android early suspend handles?

=20

2) Regarding ACPI which is more bios centric=2C will the drivers need to im=
plement suspend/resume

as for normal OS use case scenarios?

=20

Regards

Raj

=20

=20

=20

=20

=20


=20
> Date: Mon=2C 2 Aug 2010 21:56:10 -0700
> Subject: Re: Attempted summary of suspend-blockers LKML thread
> From: arve@android.com
> To: paulmck@linux.vnet.ibm.com
> CC: arjan@infradead.org=3B linux-pm@lists.linux-foundation.org=3B linux-k=
ernel@vger.kernel.org=3B mjg59@srcf.ucam.org=3B pavel@ucw.cz=3B florian@mic=
kler.org=3B rjw@sisk.pl=3B stern@rowland.harvard.edu=3B swetland@google.com=
=3B peterz@infradead.org=3B tglx@linutronix.de=3B alan@lxorguk.ukuu.org.uk
>=20
> On Sun=2C Aug 1=2C 2010 at 6:10 PM=2C Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> > On Sun=2C Aug 01=2C 2010 at 03:47:08PM -0700=2C Arjan van de Ven wrote:
> ...
> >> Another one: freezing whole cgroups..... we have that today. it
> >> actually works quite well.... of course the hard part is the decision
> >> what to put in which cgroup=2C and at what frequency and duration you =
let
> >> cgroups run.
> >
> > Indeed=2C the Android guys seemed to be quite excited by cgroup freezin=
g
> > until they thought about the application-classification problem.
> > Seems like it should be easy for some types of applications=2C but I do
> > admit that apps can have non-trivial and non-obvious dependencies.
> >
>=20
> The dependencies is what made this solution uninteresting to us. For
> instance=2C we currently use cgroup scheduling to reduce the impact of
> some background tasks=2C but we occasionally saw a watchdog restart of
> the system process were critical services were waiting on a kernel
> mutex owned by a background task for more than 20 seconds. If we froze
> a cgroup instead=2C we would not hit this particular problem since tasks
> cannot be frozen while executing kernel code the same way they can be
> preempted=2C but nothing prevents a task from being frozen while holding
> a user-space resource.
>=20
> --=20
> Arve Hj=F8nnev=E5g
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at http://www.tux.org/lkml/
 		 	   		  =

--_aca1dea6-bfb4-4b67-afc5-9c1baadbb210_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Tahoma
}
--></style>
</head>
<body class=3D'hmmessage'>
&nbsp=3B<BR>
Hi Arve and Alan=2C<BR>
&nbsp=3B<BR>
I have some questions regarding the Android early suspend and ACPI that are=
 as follows:<BR>
&nbsp=3B<BR>
1) If i see the early suspend features which is for android=2C it is if the=
 user presses power off<BR>
the button and on button for late resumes. The question is if there is mobi=
le platform=2C<BR>
then when user presses power off button=2C will the early suspend handlers =
will be called<BR>
at that time? <BR>
what usecase android early suspend handles?<BR>
&nbsp=3B<BR>
2) Regarding ACPI which is more bios centric=2C will the drivers need to im=
plement suspend/resume<BR>
as for normal OS use case scenarios?<BR>
&nbsp=3B<BR>
Regards<BR>
Raj<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
<BR>&nbsp=3B<BR>&gt=3B Date: Mon=2C 2 Aug 2010 21:56:10 -0700<BR>&gt=3B Sub=
ject: Re: Attempted summary of suspend-blockers LKML thread<BR>&gt=3B From:=
 arve@android.com<BR>&gt=3B To: paulmck@linux.vnet.ibm.com<BR>&gt=3B CC: ar=
jan@infradead.org=3B linux-pm@lists.linux-foundation.org=3B linux-kernel@vg=
er.kernel.org=3B mjg59@srcf.ucam.org=3B pavel@ucw.cz=3B florian@mickler.org=
=3B rjw@sisk.pl=3B stern@rowland.harvard.edu=3B swetland@google.com=3B pete=
rz@infradead.org=3B tglx@linutronix.de=3B alan@lxorguk.ukuu.org.uk<BR>&gt=
=3B <BR>&gt=3B On Sun=2C Aug 1=2C 2010 at 6:10 PM=2C Paul E. McKenney<BR>&g=
t=3B &lt=3Bpaulmck@linux.vnet.ibm.com&gt=3B wrote:<BR>&gt=3B &gt=3B On Sun=
=2C Aug 01=2C 2010 at 03:47:08PM -0700=2C Arjan van de Ven wrote:<BR>&gt=3B=
 ...<BR>&gt=3B &gt=3B&gt=3B Another one: freezing whole cgroups..... we hav=
e that today. it<BR>&gt=3B &gt=3B&gt=3B actually works quite well.... of co=
urse the hard part is the decision<BR>&gt=3B &gt=3B&gt=3B what to put in wh=
ich cgroup=2C and at what frequency and duration you let<BR>&gt=3B &gt=3B&g=
t=3B cgroups run.<BR>&gt=3B &gt=3B<BR>&gt=3B &gt=3B Indeed=2C the Android g=
uys seemed to be quite excited by cgroup freezing<BR>&gt=3B &gt=3B until th=
ey thought about the application-classification problem.<BR>&gt=3B &gt=3B S=
eems like it should be easy for some types of applications=2C but I do<BR>&=
gt=3B &gt=3B admit that apps can have non-trivial and non-obvious dependenc=
ies.<BR>&gt=3B &gt=3B<BR>&gt=3B <BR>&gt=3B The dependencies is what made th=
is solution uninteresting to us. For<BR>&gt=3B instance=2C we currently use=
 cgroup scheduling to reduce the impact of<BR>&gt=3B some background tasks=
=2C but we occasionally saw a watchdog restart of<BR>&gt=3B the system proc=
ess were critical services were waiting on a kernel<BR>&gt=3B mutex owned b=
y a background task for more than 20 seconds. If we froze<BR>&gt=3B a cgrou=
p instead=2C we would not hit this particular problem since tasks<BR>&gt=3B=
 cannot be frozen while executing kernel code the same way they can be<BR>&=
gt=3B preempted=2C but nothing prevents a task from being frozen while hold=
ing<BR>&gt=3B a user-space resource.<BR>&gt=3B <BR>&gt=3B -- <BR>&gt=3B Arv=
e Hj=F8nnev=E5g<BR>&gt=3B --<BR>&gt=3B To unsubscribe from this list: send =
the line "unsubscribe linux-kernel" in<BR>&gt=3B the body of a message to m=
ajordomo@vger.kernel.org<BR>&gt=3B More majordomo info at http://vger.kerne=
l.org/majordomo-info.html<BR>&gt=3B Please read the FAQ at http://www.tux.o=
rg/lkml/<BR> 		 	   		  </body>
</html>=

--_aca1dea6-bfb4-4b67-afc5-9c1baadbb210_--

--===============6063476372022321493==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6063476372022321493==--
