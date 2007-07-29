From: Nicolas <nikos42@gmail.com>
Subject: Wrong remaining capacity of my battery when it is charged
Date: Sun, 29 Jul 2007 10:05:20 +0200
Message-ID: <46AC4A40.1070300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hello,
I have a problem with the remaining capacity indicator of my battery. 
Here is what I read in /proc/acpi/battery/BAT0/info:
design capacity:         79920 mWh
last full capacity:      75000 mWh
I run Linux 2.6.15.
But when the battery is charged, remaining capacity as indicated in 
/proc/acpi/battery/BAT0/state is 79920 mWh. When the battery is 
charging, remaining capacity slowly rises to 75000 mWh, then jumps to 
79920 mWh.
I could not figure out if remaining capacity is computed by the battery 
itself, which would mean that there is a little bug in my battery 
firmware, or by ACPI, using other informations.
Thanks in advance for explanations!
Nicolas
