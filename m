From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Bugs on aspire one A150
Date: Sat, 08 Nov 2008 05:26:19 +0200
Message-ID: <491506DB.1070000__45934.5577903607$1226115039$gmane$org@gmail.com>
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
To: linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, ath5k-devel@venema.h4ckr.net
Cc: alsa-devel@alsa-project.org
List-Id: linux-pm@vger.kernel.org

I have just bought an Aspire one A150, XP version,
as it was the only available here, and installed ubuntu on it.

Bugs I discovered so far:


** 1 - embedded controler works in polling mode, due to this:

[    0.708571] ACPI: EC: non-query interrupt received, switching to interrupt mode
[    1.224043] ACPI: EC: missing confirmations, switch off interrupt mode.


Maybe this is the reason for the fact that gnome power manager freezes when I unplug
the AC, and freezes often when I try to see battery status.


(Note: same is seen on my acer aspire 5720)


** 2 - wireless: not to mention the fact that ath5k wasn't installed by default in ubuntu...
wireless more or less works, but kernel log is full of backtraces.
Was able to connect to my WPA2 access point.
Sometimes wireless fails completely, especially after suspend to ram.
Advanced features like monitor/injection work, but when I changed the card's
mac address it stopped working.
I also noticed that if I then start airodump, then wireless works with new mac.



** 3 - internal mic doesn't work.
tried model=acer, model=auto.
Overall it seems that alsa misprograms O/B realteck
codec.
I talk about this later.
Have same issue on my acer 5720



** 4 - wireless led doesn't work.
ath5k devs, can you fix this?


** 5 - coretemp doesn't show cpu temperature,
I have seen somewhere that atom support same thermal diode as core2
and only patch to detect it is needed.
Please include such path in 2.6.28 if exists.


** 6 - both card readers are missing from lspci, is this normal?

** 7 - opengl is broken, I tried running neverball in fullscreen, but it shows wrong/corrupted
textures (compiz is running, and working well thought)
 
Now I installed 2.6.28-rc3 (actually latest -git)


Sadly nothing improved.
I only found few regressions:



* Wireless now drops connection from my WPA2 access point after few minutes.
I changed temporarily its wireless protection to WEP and open mode, and both work
fine, maybe this is related to periodic key exchange WPA does?

* System doesn't reboot/shutdown, just hangs.





Best regards,
	Maxim Levitsky.
