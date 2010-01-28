From: Robin <diilbert.atlantis@gmail.com>
Subject: ACPI Lid Issue
Date: Thu, 28 Jan 2010 12:48:52 -0400
Message-ID: <36d20d7f1001280848taf92485g53bb3f6061ea414e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

The lid/suspend event works on my Toshiba Satellite A205-S4607 50% of
the time.  I think it is possible it is an ACPI driver clitch.

After doing a little research I found out that the current lid state
is stored at:
/proc/acpi/button/lid/*/state.

So I ran some simple tests:

1)  After a fresh boot:
cat /proc/acpi/button/lid/*/state gives me:
State: open

2) Close (successful suspend) and Reopen the lid:
cat /proc/acpi/button/lid/*/state gives me:
State: closed

3) Close the lid (failure to suspend the laptop) and reopen
cat /proc/acpi/button/lid/*/state gives me:
State: open

4) Close (successful suspend) and Reopen the lid:
cat /proc/acpi/button/lid/*/state gives me:
State: closed

I repeated this several times to make sure the pattern is consistent.

Any thoughts?

Thanks!

Robin
