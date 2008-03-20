From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: suspend slow in 2.6.25-rc6 (was Re: Suspend and
	hibernation	patchset against -rc6)
Date: Thu, 20 Mar 2008 12:19:31 -0300
Message-ID: <20080320151931.GD5615__15911.2874920995$1206026568$gmane$org@khazad-dum.debian.net>
References: <200803120129.25585.rjw@sisk.pl> <200803172317.33745.rjw@sisk.pl>
	<20080318130642.GA1609@elf.ucw.cz>
	<20080318130710.GB1609@elf.ucw.cz>
	<alpine.LFD.1.00.0803181028400.3020@woody.linux-foundation.org>
	<20080318232037.GA1670@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080318232037.GA1670@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@suse.cz>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Wed, 19 Mar 2008, Pavel Machek wrote:
>     Also, for polling mode to work on Acers, we need
>     to insert a delay.

Can we, in the future, always trigger any such performance damaging "fixups"
based on DMI white/black lists?  As a rule?

This is not the first time I see a vendor push broken crap, and everyone
else who did it right get the shaft, because people don't like to add
quirks to common code.  We get performance enhancement features disabled,
mdelays added...

And for the do-as-windows-does crowd, they do it on vendor=ADissued device
drivers, which obviously don't hork everyone else's devices.  Our equivalent
solution is to key things to DMI matches.   This is worth keeping in mind,
because the ACPI subsystem seems to be a common target for such bad
behaviour.

-- =

  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
