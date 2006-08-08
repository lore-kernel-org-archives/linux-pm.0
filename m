From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: swsusp and suspend2 like to overheat my laptop
Date: Tue, 8 Aug 2006 19:31:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0608081831580.18586@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0608081612380.17442@gandalf.stny.rr.com>
	<200608090750.40111.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200608090750.40111.nigel@suspend2.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Nigel Cunningham <nigel@suspend2.net>
Cc: linux-pm@osdl.org, LKML <linux-kernel@vger.kernel.org>, Suspend2-devel@lists.suspend2.net
List-Id: linux-pm@vger.kernel.org


On Wed, 9 Aug 2006, Nigel Cunningham wrote:

>
> The problem will be ACPI related, not particular to swsusp or Suspend2, w=
hich
> is why you're seeing it with both implementations. I would suggest that y=
ou
> contact the ACPI guys, and also look to see whether there is a bios update
> available and/or a DSDT override for your machine. The later will help if=
 the
> problem is with your particular machine's ACPI support, the former if it'=
s a
> more general ACPI issue.
>

Thanks for the response Nigel,

There does exist a recent bios update for this machine:

http://www-307.ibm.com/pc/support/site.wss/document.do?sitestyle=3Dlenovo&l=
ndocid=3DMIGR-58127

Hmm, it requires windows, and I've already wiped out that partition.  I
did a search but it seems really scary to update the BIOS via Linux.

Anyone else out there have a Thinkpad G41 and has successfully upgraded
their BIOS?

Thanks,

-- Steve
