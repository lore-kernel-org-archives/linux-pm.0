From: Victor Lowther <victor.lowther@gmail.com>
Subject: pm-utils 1.3.1 and pm-utils 1.4.1 released
Date: Sun, 4 Jul 2010 10:21:21 -0500
Message-ID: <AANLkTil4j1XpoH80wnLk52qYzIHraUj0VNpEVDIwZmrT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <pm-utils-bounces+gcfp-pm-utils=m.gmane.org@lists.freedesktop.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pm-utils>,
	<mailto:pm-utils-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pm-utils>
List-Post: <mailto:pm-utils@lists.freedesktop.org>
List-Help: <mailto:pm-utils-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pm-utils>,
	<mailto:pm-utils-request@lists.freedesktop.org?subject=subscribe>
Sender: pm-utils-bounces+gcfp-pm-utils=m.gmane.org@lists.freedesktop.org
Errors-To: pm-utils-bounces+gcfp-pm-utils=m.gmane.org@lists.freedesktop.org
To: pm-utils <pm-utils@lists.freedesktop.org>, devkit-devel@lists.freedesktop.org, Linux Power Management List <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

pm-utils 1.3.1 and 1.4.1 have been released.  They include a rewritten
on_ac_power that queries sysfs directly for whether the system is on
AC power or not to avoid a deadlock with upower on resume and explicit
support in the configure script for generating the manpages.
1.3.1 also includes the file locking and manpage fixes that were
applied to the 1.4 series in development.
