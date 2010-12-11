From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Wrong commit in the ACPI release branch
Date: Sat, 11 Dec 2010 23:29:34 +0100
Message-ID: <201012112329.35080.rjw__25517.0173397802$1292106705$gmane$org@sisk.pl>
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
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jan Beulich <jbeulich@novell.com>
List-Id: linux-pm@vger.kernel.org

Hi Len,

The following commit:

http://git.kernel.org/?p=linux/kernel/git/lenb/linux-acpi-2.6.git;a=commit;h=091aad6af4ab29af693ced5d6970ceee9d5981c8

(ACPI: eliminate unused variable warning for !ACPI_SLEEP)
is actually wrong, because it's going to break compilation for
(!CONFIG_PM_SLEEP && CONFIG_PM_RUNTIME).

I haven't seen it before, let alone acking it or something like this, so I wonder
why it's being pushed directly to Linus?

Thanks,
Rafael
