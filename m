From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Resume problems
Date: Wed, 24 Oct 2007 00:57:09 +0200
Message-ID: <200710240057.10131.rjw@sisk.pl>
References: <471CCC98.10101@googlemail.com> <471D3C26.3090602@googlemail.com>
	<471D47D2.2070707@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <471D47D2.2070707@googlemail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Gabriel C <nix.or.die@googlemail.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 23 October 2007 03:01, Gabriel C wrote:
> 
> > Also box just froze on level 3 but I got a ACPI error at least which I didn't got in any other dmesg till now :
> > ( also patch was tested with HT disabled and Suspend and Hibernation enabled in kernel and BIOS )
> > 
> > ...
> > 
> > Oct 23 01:51:05 lara [  273.512374] PM: Removing info for No Bus:input0
> > Oct 23 01:51:05 lara [  274.545158] PM: Removing info for No Bus:mouse0
> > Oct 23 01:51:05 lara [  274.551435] PM: Removing info for No Bus:event1
> > Oct 23 01:51:05 lara [  274.559493] PM: Removing info for No Bus:input1
> > Oct 23 01:53:06 lara [  394.869468] ACPI Error (evevent-0303): No installed handler for fixed event [00000002] [20070126]
> > 
> > ....
> > 
> > ( I hard reseted after that ) 
> > 
> > I try level 2 and 1 now I just wanted to let you know.
> > 
> 
> Same issues with level 2 and 1.

Yes.  If you have a problem at level n, it should always reappear for n-1 etc.

> BTW I found out why my box does not shutdown with acpi=ht. It seems like libata does not like that 
> acpi mode =) dropping the '... read http://linux-ata.org/shutdown.html , power down manually' message.
> 
> That works perfectly with full acpi here.
> 
> After all I think all this problems may be some who ACPI related 
> but the question is why they get triggered by Suspend/Hibernation.

They certainly are ACPI-related, because the only difference between level 4
and level 3 suspend testing is that some global ACPI methods are executed
at level 3 (in addition to level 4).

Unfortunately, I have no idea what to do next, for now.

I think you can file a bug report at http://bugzilla.kernel.org and put a link
to this thread in there (against ACPI and please add my address to the CC
list).

Greetings,
Rafael
