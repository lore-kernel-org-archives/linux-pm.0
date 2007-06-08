From: Olaf Dietsche <olaf.dietsche@olafdietsche.de>
Subject: Re: [2.6.22-rc3][ACPI?] Resume from s2r doesn't work.
Date: Fri, 08 Jun 2007 15:07:27 +0200
Message-ID: <877iqeoar4.fsf__5225.72979466549$1181308035$gmane$org@goat.bogus.local>
References: <878xb35sje.fsf@goat.bogus.local> <200706041013.49428.rjw@sisk.pl>
	<87hcpnpt4k.fsf@goat.bogus.local> <200706042302.45628.rjw@sisk.pl>
	<87y7ivo86z.fsf@goat.bogus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87y7ivo86z.fsf@goat.bogus.local> (Olaf Dietsche's message of
	"Thu, 07 Jun 2007 21:50:28 +0200")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Olaf Dietsche <olaf+list.linux-acpi@olafdietsche.de> writes:

> I installed the nvidia.ko (1.0-9755) kernel module and now the machine
> comes back to life. Although the screen stays black as before, I can
> type blindly "shutdown -r now" or ssh into the laptop.

Here's an update: when I additionally install the complete nvidia
package, including the binary X server modules, my screen becomes
active on resume.

This is not really satisfactory, since my console stays black. Anyway,
this is another step forward, nonetheless.

Regards, Olaf.
