From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: broken suspend [Was: 2.6.24-rc2-mm1]
Date: Sun, 18 Nov 2007 12:07:37 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0711181203220.5712-100000__38210.1399278783$1195405770$gmane$org@netrider.rowland.org>
References: <4740570A.5030101@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4740570A.5030101@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 18 Nov 2007, Jiri Slaby wrote:

> On 11/18/2007 04:23 PM, Rafa=C5=82 J. Wysocki wrote:
> > On Sunday, 18 of November 2007, Jiri Slaby wrote:
> >> On 11/18/2007 04:03 PM, Rafael J. Wysocki wrote:
> >>> Can you also make the new System-map available, please?
> >> Sure:
> >> http://www.fi.muni.cz/~xslaby/sklad/System.map1
> >=20
> > The last notifier called in http://www.fi.muni.cz/~xslaby/sklad/susp_=
hang2.png
>=20
> Last... Note, that it's only first 20 invokations of notifiers, there a=
re
> bazillion of them when I remove the condition '< 20'.
>=20
> > is apparently cpu_swap_callback() which is not called in
> > http://www.fi.muni.cz/~xslaby/sklad/susp_hang1.png .
> >=20
> > Can you verify that cpu_swap_callback() gets called if the patch is n=
ot
> > applied?
>=20
> Does this still apply?

You'll get more useful results if you redo your changes to=20
notifier_call_chain().  Have it print out the address of the routine=20
_before_ making the call, and don't limit it to 20.  That way you'll=20
know exactly which notifier routine ends up hanging.

Alan Stern
