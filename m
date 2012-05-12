From: Jiri Slaby <jslaby@suse.cz>
Subject: 3.3.5 regression: resume doesn't switch to X
Date: Sat, 12 May 2012 09:17:28 +0200
Message-ID: <4FAE0E88.2030703@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: stable@kernel.org
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, Jiri Slaby <jirislaby@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi,

since update to 3.3.5, my X doesn't show up after resume from
hibernation anymore. The only thing I see is "resuming..." on the
console. I can switch to any tty and login in text mode, but cannot
switch to X despite it is running. I have to restart whole session to
have X again.

Now I'm back to 3.3.4 and everything is OK.

Using radeon driver on:
01:00.0 VGA compatible controller [0300]: Advanced Micro Devices [AMD]
nee ATI RV515 [Radeon Mobility X1450] [1002:7186]

regards,
-- 
js
suse labs
