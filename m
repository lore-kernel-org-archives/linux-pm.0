From: Ari Savolainen <ari.m.savolainen@gmail.com>
Subject: PROBLEM: Shutdown does not poweroff due to commit
 2a2d31c8 "intel_idle: open broadcast clock event"
Date: Fri, 21 Jan 2011 20:03:01 +0200
Message-ID: <AANLkTikDA9JqFjLRfPuPWTu3xbdfc16SzaRAwzKE3cH=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
To: Len Brown <lenb@kernel.org>, Shaohua Li <shaohua.li@intel.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,

I have a Dell Precision WorkStation T3500. It stopped to power off
after shutdown. Bisection revealed commit 2a2d31c8 "intel_idle: open
broadcast clock event" to be the reason. =A0Below are all the dmesg
lines containing "intel_idle":

[ =A0 =A02.184560] intel_idle: MWAIT substates: 0x1120
[ =A0 =A02.184561] intel_idle: v0.4 model 0x1A
[ =A0 =A02.184562] intel_idle: lapic_timer_reliable_states 0x2
[ =A0 =A02.204056] ACPI: acpi_idle yielding to intel_idle

Please let me know what further information you need to fix the problem.

Regards,
Ari
