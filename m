From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: 2.6.29-rc2 regression: hibernation hang on eeepc-701
	(method "platform" only)
Date: Sun, 18 Jan 2009 11:45:18 +0000
Message-ID: <9b2b86520901180345j434eacbdn7386958991ee50b__39456.8685246215$1232279375$gmane$org@mail.gmail.com>
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
To: kernel-testers@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux acpi <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hibernation hangs just after writing the image.  With s2disk I can see
this from the console messages.  The same hang happens with kernel
swsusp ('echo disk | sudo tee /sys/power/state'), and I can see that
the image has been written from the HDD led.

In either case, I can still hard-power-off and resume from hibernation.

It doesn't hang if I use the shutdown method (either 'echo shutdown |
sudo tee /sys/power/disk' or  's2disk -P "shutdown method=shutdown"').

Let me know if you'd like more information.

Thanks
Alan
