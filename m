From: "Johannes Berg" <johannes@sipsolutions.net>
Subject: Re: Re: [PATCH] PM: Acquire device locks on suspend
Date: Mon, 7 Jan 2008 00:46:02 +0100 (CET)
Message-ID: <33675.9742153392$1199663255@news.gmane.org>
References: <Pine.LNX.4.44L0.0801061734150.20032-100000@netrider.rowland.org>
	<200801062347.49935.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801062347.49935.rjw@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:

>> I don't see anything wrong with it.  All that will happen is that the
>> removal will start before the suspend and finish after the resume.
>
> In that case, we'll attempt to call the device's .suspend() and .resume()
> routines, but we shouldn't do that, IMHO.

I don't see anything wrong with that since the driver must be prepared to
handle that even in the regular case, it's the only thing you can
guarantee: no more method calls after removal finishes. Am I totally
misunderstanding things?

johannes
