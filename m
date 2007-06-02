From: "Indan Zupancic" <indan@nul.nu>
Subject: Re: [2.6.22-rc3][ACPI?] Resume from s2r doesn't work.
Date: Sat, 2 Jun 2007 02:07:36 +0200 (CEST)
Message-ID: <3499.81.207.0.53.1180742856.squirrel__44896.2030387067$1180742922$gmane$org@secure.samage.net>
References: <878xb35sje.fsf@goat.bogus.local>
	<200706012237.17375.rjw@sisk.pl> <87k5un4bwk.fsf@goat.bogus.local>
	<200706012340.54394.rjw@sisk.pl> <87hcpr2ubl.fsf@goat.bogus.local>
Mime-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87hcpr2ubl.fsf@goat.bogus.local>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Olaf Dietsche <olaf+list.linux-acpi@olafdietsche.de>
Cc: linux-acpi@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sat, June 2, 2007 00:17, Olaf Dietsche wrote:
> It doesn't work. I tried all options "s2ram -f (-s, -p, -m, -r, -a 1, -a 2,
> -a 3)" one after the other.
>
> Since the screen (or any other device) works without problems, when I
> skip acpi_enter_sleep_state(), I don't think it's screen related.

I use "s2ram -f -p -s -a 3", maybe you need some exotic combination too.

Greetings,

Indan
