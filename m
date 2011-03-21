From: =?UTF-8?Q?Ja=C5=A1a_Bartelj?= <jasa.bartelj@gmail.com>
Subject: Re: [Bug 31432] Resume from suspend fails on new
 FireWire stack (TSB43AB22/A IEEE-1394a-2000 Controller)
Date: Mon, 21 Mar 2011 20:02:28 +0100
Message-ID: <AANLkTimvEUdz+nTY80dTCSEPv5vGYiPKcGoxxkrm0OS9__49228.7092646167$1300897766$gmane$org@mail.gmail.com>
References: <bug-31432-35532@https.bugzilla.kernel.org/>
	<201103210659.p2L6xXQi019212@demeter2.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201103210659.p2L6xXQi019212@demeter2.kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: bugzilla-daemon@bugzilla.kernel.org
Cc: linux-pm@lists.linux-foundation.org, linux1394-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

> Is the failure in resume from suspend(-to-RAM), or in restore from
> hibernate (alias resume from suspend-to-disk), or both?

The described failure is from suspend-to-RAM.

I have just tried hibernation with firewire modules loaded and the
kernel does not complete it. It hangs at a VT with only a blinking
cursor on the top left. A hard reset is required to regain control!
Here's what I see in the messages log: http://pastebin.com/rz0c8hKM
