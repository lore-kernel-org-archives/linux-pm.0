From: fanderay <fanderay4@googlemail.com>
Subject: Resume after suspend-to-ram broken for Vaio SR19VN in
	30rc2
Date: Mon, 20 Apr 2009 19:52:44 +0100
Message-ID: <31c940650904201152y5f440237rb9c49f1aedfef5a6@mail.gmail.com>
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

Hi,

I have a Vaio SR19VN (Radeon HD 3400 video) and resume after
suspend-to-ram fails with 2.6.30rc2/x86_64.  I have been testing with
the s2ram tool using the approach described at
http://en.opensuse.org/S2ram.  None of the s2ram options changes the
behavior, which is that the system freezes hard while attempting to
resume (screen stays off/black) and must be physically powered down.
The caps-lock test fails, which suggests this is more than just a
video problem.  Suspend/resume actually did work with the stock Debian
lenny kernel (2.6.26/amd64).  The kernel config is pasted at
http://pastebin.com/mb4dd790.  Any idea what might be wrong?
