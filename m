From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: intermittent suspend problem again
Date: Sat, 31 Oct 2009 15:06:05 +0100
Message-ID: <874opfwtde.fsf__26434.0921109126$1256998053$gmane$org@tac.ki.iif.hu>
References: <87fx93pwv2.fsf@tac.ki.iif.hu> <200910301918.53301.rjw@sisk.pl>
	<87k4yc3drd.fsf@tac.ki.iif.hu> <200910302138.37938.rjw@sisk.pl>
	<9b2b86520910310502p7fe8e0edmff09220632fab5e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <9b2b86520910310502p7fe8e0edmff09220632fab5e2@mail.gmail.com>
	(Alan Jenkins's message of "Sat, 31 Oct 2009 12:02:02 +0000")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Cc: yakui.zhao@intel.com, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Alan Jenkins <sourcejedi.lkml@googlemail.com> writes:

> On 10/30/09, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> On Friday 30 October 2009, Ferenc Wagner wrote:
>>> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
>>>
>>>> On Thursday 29 October 2009, Ferenc Wagner wrote:
>>>>
>>>>> and saving the image as well.  If s2disk didn't report funny huge
>>>>> negative ratios all the time,
>>>>
>>>> Hmm.  This looks like a bug in s2disk.
>>>
>>> Definitely.  Do you also experience this?
>>
>> Not really, but I use newer versions.
>>
>>> Probably an easy one, but I've never had the chance to check the CVS
>>> version (running 0.7 at the moment).  I can probably give 0.8 a spin
>>> if you deem necessary.  I always thought it wasn't more than a
>>> cosmetic flaw.
>>
>> It probably is.  You can try the current version from my git tree at:
>> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-utils.git
>
> I seem to recall reporting this and finding that the latest version
> fixed the bug simply by removing the code which printed the ratio :-).

Heh, maybe, but the version compiled from Rafael's git tree prints the
ratio all right, and its value is even positive and less than 1.  So I
confirm that the ratio issue is fixed.  I'll be running with this
version from now on, and if it exhibits the same original issue, I'll
switch to shutdown mode and gather some experience running that.
-- 
Thanks,
Feri.
