From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] suspend/resume self-test
Date: Tue, 19 Feb 2008 15:43:28 +0100
Message-ID: <20080219144328.GD21176__5030.03434646434$1203432332$gmane$org@elte.hu>
References: <20080130131748.GA3796@elf.ucw.cz>
	<200802180240.47510.david-b@pacbell.net>
	<20080218130914.GC17697@elte.hu>
	<200802181216.25350.david-b@pacbell.net>
	<20080219101116.GA2202@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080219101116.GA2202@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


* Pavel Machek <pavel@ucw.cz> wrote:

> > Thing is, this will catch not just regressions ... but cases where 
> > STR never worked in the first place.  Video problems, etc.  Also 
> > various system startup races, as in the PCMCIA and MMC/SD/SDIO cases 
> > I noted.
> 
> David is right here. At minimum, s2ram needs acpi_sleep=... options to 
> tell it how to set up the video. That is not issue for you, but it 
> means we should not be doing it by default.

nowhere did i suggest that it should be default-enabled ...

i just suggest the obvious: please make it a trivial, 2 seconds flip of 
a switch, instead of a 60 minutes hunting which i had to do to enable 
the S2RAM self-test: which also meant i had to write a few patches to 
print out what the code does and why it does not work, to finally enable 
this critical test infrastructure.

damn, with that kind of attitude towards people who _want to help_, no 
wonder s2ram still sucks ;-)

	Ingo
