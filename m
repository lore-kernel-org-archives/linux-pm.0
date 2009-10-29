From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: intermittent suspend problem again
Date: Thu, 29 Oct 2009 01:11:54 +0100
Message-ID: <87d447m52t.fsf@tac.ki.iif.hu>
References: <87fx93pwv2.fsf@tac.ki.iif.hu> <200910281956.44791.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200910281956.44791.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Wed, 28 Oct 2009 19:56:44 +0100")
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Wednesday 28 October 2009, Ferenc Wagner wrote:
> 
>> Something similar to http://bugzilla.kernel.org/show_bug.cgi?id=13894
>> raised its ugly head again, please see my last comments on that bug.
>
> This very well may be a separete bug, so please file a new bugzilla report
> on this and mark it as a regression.

Done.

>> 2.6.32-rc5 feels particularly bad, with frequent failures to switch
>> off the machine after "S|" or freezes after "Snapshotting system".
>> The former does not cause much trouble in itself, as the machine can
>> be switched off and resumed all right, but the latter is nasty.
>> Suspend to RAM works all the time.  The issue is not reproducible,
>> unfortunately, and the kernel change happened almost together with a
>> BIOS upgrade.  Yesterday I switched back to 2.6.31 to see whether it
>> still works stably with the new BIOS.  I'll report back my findings in
>> a couple of days.
>
> OK, thanks.
>
> Still, I'm really afraid we won't be able to debug it any further without a
> reproducible test case.

I've got another, fully reproducible but nevertheless neglected ACPI
problem, already mentioned in #13894:
https://bugs.freedesktop.org/show_bug.cgi?id=22126.  Well, it's
probably far-fetched, but maybe the two are somehow related...  Can't
you perhaps suggest a way forward there?  Or some tricks to create a
reproducible test case here?  Btw. my gut feeling is that hibernation
is getting slower with each kernel release.  I didn't measure it, and
didn't even care about comparable initial states... But could anything
explain this, or is it sheer impatience?
-- 
Regards,
Feri.
