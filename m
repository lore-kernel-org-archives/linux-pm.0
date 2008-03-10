From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] cpuidle: avoid singing capacitors
Date: Mon, 10 Mar 2008 14:04:15 +0100
Message-ID: <47D531CF.1060500__30268.7305179008$1205154376$gmane$org@firstfloor.org>
References: <Pine.LNX.4.44L0.0803031804330.8280-100000@iolanthe.rowland.org>	<20080303231033.GB15255@one.firstfloor.org>	<20080304040048.GA31562@codemonkey.org.uk>	<20080304071423.0e6b71c1@mjolnir.drzeus.cx>	<20080304181924.70aaf8c1@mjolnir.drzeus.cx>	<924EFEDD5F540B4284297C4DC59F3DEEA77031@orsmsx423.amr.corp.intel.com>	<20080305070201.0d16cd40@mjolnir.drzeus.cx>	<20080305094023.6486ebdf@mjolnir.drzeus.cx>	<20080306092730.4412d085@mjolnir.drzeus.cx>	<20080309151659.63d54f38@mjolnir.drzeus.cx>	<20080310100008.GA9520@elf.ucw.cz>
	<20080310134915.45ae7446@mjolnir.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080310134915.45ae7446@mjolnir.drzeus.cx>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>, Adam Belay <abelay@novell.com>, Lee Revell <rlrevell@joe-job.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


> I guess the only way to find out is to disassemble the DSDT. Exposing myself to such concentrations of ACPI is not an appealing project. :/

Normally such things are not visible in the DSDT, but hidden in SMM traps.

-Andi
