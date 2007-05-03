From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Why don't we use _TTS method?
Date: Thu, 3 May 2007 22:01:48 +0200
Message-ID: <200705032201.49071.rjw__14459.1618249708$1178222280$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Hi,

I've got two questions regarding the implementation of the ACPI poweroff/sleep
code in drivers/acpi/sleep and drivers/acpi/hardware .

1) We don't seem to use the _TTS system-control method, although the ACPI
specification (ACPI 3.0b) says that this method should be used for intiating
and finishing power transitions.  Could you please tell me why we don't use it?

2) In the functions acpi_enter_sleep_state_prep(), acpi_enter_sleep_state(),
acpi_leave_sleep_state() we manipulate GPEs quite extensively (we disable
and enable them for a couple of times during a transition), although the
specification doesn't tell anything about that explicitly.  Could you please
explain to me what the purpose of that is?

Greetings,
Rafael


-- 
If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King
