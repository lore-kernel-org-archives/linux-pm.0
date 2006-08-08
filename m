From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: swsusp and suspend2 like to overheat my laptop
Date: Tue, 08 Aug 2006 19:35:44 -0400
Message-ID: <1155080145.26338.130.camel@mindpipe>
References: <Pine.LNX.4.58.0608081612380.17442@gandalf.stny.rr.com>
	<200608090750.40111.nigel@suspend2.net>
	<Pine.LNX.4.58.0608081831580.18586@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0608081831580.18586@gandalf.stny.rr.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-pm@osdl.org, LKML <linux-kernel@vger.kernel.org>, Suspend2-devel@lists.suspend2.net
List-Id: linux-pm@vger.kernel.org

On Tue, 2006-08-08 at 19:31 -0400, Steven Rostedt wrote:
> On Wed, 9 Aug 2006, Nigel Cunningham wrote:
> =

> >
> > The problem will be ACPI related, not particular to swsusp or Suspend2,=
 which
> > is why you're seeing it with both implementations. I would suggest that=
 you
> > contact the ACPI guys, and also look to see whether there is a bios upd=
ate
> > available and/or a DSDT override for your machine. The later will help =
if the
> > problem is with your particular machine's ACPI support, the former if i=
t's a
> > more general ACPI issue.
> >
> =

> Thanks for the response Nigel,
> =

> There does exist a recent bios update for this machine:
> =

> http://www-307.ibm.com/pc/support/site.wss/document.do?sitestyle=3Dlenovo=
&lndocid=3DMIGR-58127
> =

> Hmm, it requires windows, and I've already wiped out that partition.  I
> did a search but it seems really scary to update the BIOS via Linux.
> =

> Anyone else out there have a Thinkpad G41 and has successfully upgraded
> their BIOS?

I would just report it to the ACPI people.  It's a bug if Linux does not
work with the same BIOS + DSDT that the other OS works on.

Lee
