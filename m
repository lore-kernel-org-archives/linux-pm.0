From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Occasional (too common) suspend problem
Date: Fri, 21 Jan 2011 16:56:17 -0800
Message-ID: <AANLkTinBaG27pdtEFh1ufjh85Bk7aMzgwHjzyifz406G__19917.1037915677$1295657938$gmane$org@mail.gmail.com>
References: <AANLkTikBRf00H_6YcS9nsnJG68WguDzL_AvNTRyDWRY=@mail.gmail.com>
	<201101220016.46227.rjw@sisk.pl>
	<AANLkTi=Tkf9MYmSmCX6CZ9Ymgqo8S1HmRkBn+Uvr2KUb@mail.gmail.com>
	<201101220131.11688.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201101220131.11688.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jeff Chua <jeff.chua.linux@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 21, 2011 at 4:31 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>>
>> Or - and perhaps more likely - it's connected to the lid event, and
>> how that interacts with user space and then eventually triggers the
>> sleep event (which is quite likely - as mentioned, I think I've only
>> ever seen the problem when I'm physically at the machine).
>
> Does opening the lid wake up the machine normally?

No. Closing the lid causes it to suspend (due to the normal Fedora PM
settings), but to actually resume you have to open the lid and then
press a key.

                  Linus
