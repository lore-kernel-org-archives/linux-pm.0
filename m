From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH -mm 0/2] swsusp: Reduce code duplication
	between user.c and disk.c (rev. 2)
Date: Wed, 9 May 2007 00:19:18 +0200
Message-ID: <200705090019.20232.rjw__11991.3656068549$1178663240$gmane$org@sisk.pl>
References: <200705052227.14265.rjw@sisk.pl>
	<20070507122619.GE20605@elf.ucw.cz>
	<200705072257.13405.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705072257.13405.rjw@sisk.pl>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: suspend-devel@lists.sourceforge.net, Johannes Berg <johannes@sipsolutions.net>, Nigel Cunningham <nigel@nigel.suspend2.net>, pm list <linux-pm@lists.linux-foundation.org>, Pekka Enberg <penberg@cs.helsinki.fi>
List-Id: linux-pm@vger.kernel.org

Hi,

This two patches are aimed at reducing the code duplication between
kernel/power/disk.c and kernel/power/user.c .

The first of them removes the calls to 'platform mode' functions from the
restore part.  As far as I can tell after reading the ACPI specification,
they shouldn't be there.

The second patch actually removes the above-metntioned duplication of
code.

Comments welcome.

Greetings,
Rafael
