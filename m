From: "Ray Lee" <ray-lk@madrabbit.org>
Subject: Re: [RFT][PATCH] swsusp: Change code ordering related to
	ACPI
Date: Fri, 4 May 2007 16:11:17 -0700
Message-ID: <2c0942db0705041611u2d82fbb7m4719c1bcf8bcdbf7__42197.8134698749$1178320335$gmane$org@mail.gmail.com>
References: <200705041143.02451.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705041143.02451.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Tobias Diedrich <ranma+kernel@tdiedrich.de>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Marcus Better <marcus@better.se>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 5/4/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> The change of the hibernation/suspend code ordering made before 2.6.21 has
> caused some systems to have problems related to ACPI.  In particular, the
> 'platform' hibernation mode doesn't work any more on some systems.

It seems that somewhere between 2.6.21-rc4 and 2.6.21 final my laptop
stopped being able to come out of suspend to RAM. Before I start
bisecting (again, sigh), is this ringing any bells for anyone? In
particular your, patch (snipped) that deals with hibernation, would it
also affect suspend to RAM?

Ray
