From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: Wrong remaining capacity of my battery when it is
	charged
Date: Sun, 29 Jul 2007 12:49:22 +0400
Message-ID: <46AC5492.3060306@gmail.com>
References: <46AC4A40.1070300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <46AC4A40.1070300@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nicolas <nikos42@gmail.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Nicolas wrote:
> Hello,
> I have a problem with the remaining capacity indicator of my battery.
> Here is what I read in /proc/acpi/battery/BAT0/info:
> design capacity:         79920 mWh
> last full capacity:      75000 mWh
> I run Linux 2.6.15.
> But when the battery is charged, remaining capacity as indicated in
> /proc/acpi/battery/BAT0/state is 79920 mWh. When the battery is
> charging, remaining capacity slowly rises to 75000 mWh, then jumps to
> 79920 mWh.
> I could not figure out if remaining capacity is computed by the battery
> itself, which would mean that there is a little bug in my battery
> firmware, or by ACPI, using other informations.
> Thanks in advance for explanations!
> Nicolas
ACPI does not compute anything. Information is supplied by BIOS methods (_BST in DSDT).
_BST could compute something, but it usually just reads registers of embedded controller (battery).


Regards,
Alex.
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
> 
