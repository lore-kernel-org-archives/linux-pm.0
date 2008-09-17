From: Thomas Renninger <trenn@suse.de>
Subject: Re: DSDT from your system / new DSDT archive
Date: Wed, 17 Sep 2008 19:29:37 +0200
Message-ID: <200809171929.38238.trenn__3795.57947530902$1221673751$gmane$org@suse.de>
References: <20080916165543.EA6A42003D@smtp.hushmail.com>
	<20080917024127.GB1187@khazad-dum.debian.net>
	<200809171744.34064.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200809171744.34064.trenn@suse.de>
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
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Scott Thompson <postfail@hushmail.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday 17 September 2008 17:44:33 Thomas Renninger wrote:
> On Wednesday 17 September 2008 04:41:27 Henrique de Moraes Holschuh wrote:
> > Hi Scott!
> >
> > On Tue, 16 Sep 2008, Henrique de Moraes Holschuh wrote:
> > > On Tue, 16 Sep 2008, Scott Thompson wrote:
> > > > Since a current one doesn't seem to exist, I am attempting to put
> > > > my own database together up on the
> > > > internets (URL coming soon) and am looking for folks to send me the
> > > > DSDT from their systems.  Gathering your system DSDT takes
> > > > less than about 2 minutes by running the following:
> > >
> > > You also want the dmidecode output, which BTW you must sanitize to
> > > remove UUIDs and serial numbers.  Otherwise, the DSDTs are a lot less
> > > useful.
> >
> > Come to think of it, the DSDTs are useless without the other tables in
> > most systems, anyway, so you want to store the entire acpidump :-p
>
> Exactly.
> You should take dmidecode and acpidump in a specific format (provide a
> small script to (show how to) gather them?).
Plus the possibility to add a diff fixing the DSDT/SSDTs, then you have:
  - acpidump
  - dmidecode
  - fixes.diff
Still it should be checked that the full acpidump is there, the whole data
is not worth much without full acpidump and dmidecode.
Then these examples could greatly help others to get used to and how to
fix general warnings/errors.
Hope some will go one step further and suggest patches on http://acpica.org
to adopt/fix the acpi sources to work well with the ("not totally broken") 
tables.

     Thomas

> You should also double check the info you get uploaded. On the sourceforge
> list all kind of broken info was flying around (all kind of compressions
> used, only aml, only asl and only hex tables, only the diffs, and more...).
>
> Therefore IMO best is not to only provide a small script how you should
> gather and upload the data, but also internally do a quick check the other
> way round whether the data sent up is valid (unzip, acpixtract -a acpidump,
> [ -e DSDT.dsl ] or similar).
>
> I'd also only accept acpidumps or whole zips containing the dumps.
> You should not provide extracted acpidumps, even worse disassmbled ones as
> the code in there is protected by copyrights.
> Also a disclaimer that people must only use the info for getting their
> machine running for which they bought the copyrights should be stated
> somewhere.
>
> Expect that you get a lot dumps.
>
> You should state somewhere that people should (if they are doing a BIOS
> update anyway):
>    - upload the dumps
>    - upgrade the BIOS
>    - again upload the dumps
> Like that you get a nice history of fixups which can reveal interesting
> things...
>
>       Thomas
>
> PS: This work is very much appreciated. Tell me how I can help.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
