From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: ACPI Lid Issue
Date: Thu, 28 Jan 2010 21:11:25 +0100
Message-ID: <201001282111.25276.rjw__5567.61932462013$1264709600$gmane$org@sisk.pl>
References: <36d20d7f1001280848taf92485g53bb3f6061ea414e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <36d20d7f1001280848taf92485g53bb3f6061ea414e@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Robin <diilbert.atlantis@gmail.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday 28 January 2010, Robin wrote:
> The lid/suspend event works on my Toshiba Satellite A205-S4607 50% of
> the time.  I think it is possible it is an ACPI driver clitch.
> 
> After doing a little research I found out that the current lid state
> is stored at:
> /proc/acpi/button/lid/*/state.
> 
> So I ran some simple tests:
> 
> 1)  After a fresh boot:
> cat /proc/acpi/button/lid/*/state gives me:
> State: open
> 
> 2) Close (successful suspend) and Reopen the lid:
> cat /proc/acpi/button/lid/*/state gives me:
> State: closed
> 
> 3) Close the lid (failure to suspend the laptop) and reopen
> cat /proc/acpi/button/lid/*/state gives me:
> State: open
> 
> 4) Close (successful suspend) and Reopen the lid:
> cat /proc/acpi/button/lid/*/state gives me:
> State: closed
> 
> I repeated this several times to make sure the pattern is consistent.
> 
> Any thoughts?

It's better to ask on the linux-acpi list (CC added).

Rafael
